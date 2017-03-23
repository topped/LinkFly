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

$pid = 27;

$template->assign(PAGE_TITLE, $langs[224]);
$template->assign(PAGE_ID, $pid);

$completed = false;
$transaction_data = get_transaction($_GET['tid']);

if($transaction_data) {

    if (isset($_GET['completed']) == false && isset($_GET['id'])) {

        $campaign_id = $_GET['id'];
        $campaign_data = get_campaign_data($campaign_id);

        if ($campaign_data && $campaign_data['campaigns_members_id'] == $member_data['members_id'] && $transaction_data['transactions_status'] == 0) {

            $value = sprintf('%.02f', $transaction_data['transactions_value']);

            $template->assign('value', $value);
            $template->assign('campaign', $campaign_data);

        } else {
            show_404();
        }

    } else {

        if($transaction_data['transactions_members_id'] != $member_data['members_id'])
            show_404();

        $completed = true;

    }

    $template->assign('transaction', $transaction_data);
    $template->assign('completed', $completed);

    $template->display($current_template . 'payment_page.tpl');

}else{
    show_404();
}