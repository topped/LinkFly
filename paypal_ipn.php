<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once 'includes/definitions.php';
require_once FUNCS_DIR . 'core.functions.php';

require_once LIBS_DIR . 'IPNListener/ipnlistener.php';

error_log('IPN posted');

$listener = new IpnListener();

if(get_setting('payment_test_mode')) {
    $listener->use_sandbox = true;
}else{
    $listener->use_sandbox = false;
}

try {

    $listener->requirePostMethod();
    $verified = $listener->processIpn();

} catch (Exception $e) {

    error_log($e->getMessage());
    exit(0);

}

if($verified){

    error_log('IPN was received');

    $errors = array();

    $custom = explode('|', $_POST['custom']);

    $campaign_id = $custom[0];
    $member_id = $custom[1];

    $campaign_data = get_campaign_data($campaign_id);
    $member_data_t = get_member($campaign_data['campaigns_members_id']);

    $transaction_data = get_transactions_object_id($campaign_id);
    $tid = $transaction_data['transactions_id'];

    if(empty($campaign_id) || $campaign_data == false)
        $errors[] = $tid . ': Invalid campaign';

    if($member_id != $member_data_t['members_id'] || $member_data_t == false)
        $errors[] = $tid . ': Invalid member';

    if($_POST['payment_status'] != 'Completed')
        $errors[] = $tid . ": Payment not completed - " . $_POST['payment_status'] . '. Reason: ' . $_POST['pending_reason'];

    if($transaction_data == false)
        $errors[] = $tid . ': Invalid transaction data';

    if(sprintf('%.02f', $transaction_data['transactions_value']) != $_POST['mc_gross'])
        $errors[] = $tid . ': Price does not match';

    if($_POST['mc_currency'] != $transaction_data['transactions_curr'])
        $errors[] = $tid . ': Currency does not match';

    if(empty($errors)){

        //No errors
        update_transaction_status_campaign($campaign_id, 1);
        update_payment_status($campaign_id, 1);

    }else{
        foreach($errors as $error){
            error_log('IPN Error - TID#' . $error);
        }

    }

}