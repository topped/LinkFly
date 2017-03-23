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

$pid = 10;

if($member_data) {

    /* Validating and displaying if a user can withdraw funds */

    $errors = array();

    $has_min_earnings = false;
    $has_required_age = false;
    $has_not_changed_pass = false;

    $account_created = strtotime($member_data['members_added']);
    $total_earnings = $member_data['members_balance'];
    $last_pass_change = strtotime($member_data['members_password_change']);

    if($total_earnings >= get_setting('min_withdraw'))
        $has_min_earnings = true;

    if($account_created <= strtotime('-'.get_setting('min_account_age') . ' days'))
        $has_required_age = true;

    if($last_pass_change <= strtotime('-'.get_setting('min_pass_change_time') . ' days'))
        $has_not_changed_pass = true;


    if(empty($_POST) == false){

        $paypal_email = isset($_POST['pp_email']) ? $_POST['pp_email'] : false;
        $amount = isset($_POST['amount']) ? $_POST['amount'] : false;
        $captcha = isset($_POST['captcha']) ? $_POST['captcha'] : false;

        $securimage = new Securimage();

        if(get_setting('enable_withdrawals') == 0)
            $errors = $langs[311];

        if(!$securimage->check($captcha))
            $errors[] = $langs[257];

        if (!filter_var($paypal_email, FILTER_VALIDATE_EMAIL))
            $errors[] = $langs[283];

        if(!is_numeric($amount))
            $errors[] = $langs[312];

        if($amount > $member_data['members_balance'])
            $errors[] = $langs[313];

        if(empty($errors) && $has_min_earnings && $has_required_age && $has_not_changed_pass) {

            $data = array();
            $data['withdrawal_requests_amount'] = $amount;
            $data['withdrawal_requests_curr'] = get_setting('site_curr');
            $data['withdrawal_requests_pp_email'] = $paypal_email;

            insert_withdrawal($member_data['members_id'], $data);
            update_member_balance($member_data['members_id'], $amount, false);

            /* Sending the e-mail to the user */

            send_email_template('new_withdrawal.tpl', $data, $member_data['members_email'], get_setting('site_name') . ' - New Withdrawal Request');

            $template->assign('success', true);

        }

    }

    $template->assign('has_min_earnings', $has_min_earnings);
    $template->assign('has_required_age', $has_required_age);
    $template->assign('has_not_changed_pass', $has_not_changed_pass);

    $template->assign('withdrawals', get_withdrawals($member_data['members_id']));

    $template->assign('errors', $errors);

    $template->assign(PAGE_TITLE, $langs[31]);
    $template->assign(PAGE_ID, $pid);

    /* Rendering template */

    $template->display($current_template . 'withdrawals.tpl');

}else{

    redirect('home');

}