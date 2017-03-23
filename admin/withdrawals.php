<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once '../includes/admins.definitions.php';
require_once FUNCS_DIR . 'core.functions.php';

if($member_data['members_admin']) {

    $admin_pid = 5;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    $success = false;
    $errors = array();

    if(isset($_GET['mp_error'])){

        $errors[] = 'No withdrawals found to export.';

    }

    if(empty($_POST) == false) {

        if(is_numeric($_POST['min_account_age']) == false)
            $errors[] = 'Minimum Account Age for Withdrawal needs to be a number.';

        if(is_numeric($_POST['min_pass_change_time']) == false)
            $errors[] = 'Minimum Time Password Changed needs to be a number.';

        if(is_numeric($_POST['min_withdraw']) == false)
            $errors[] = 'Minimum Withdrawal Amount needs to be a number.';

        if(count($errors) == 0){
            save_settings();
            $success = true;
        }

    }

    if(isset($_GET['withdrawal_request_id'])){

        $withdrawal_request_id = $_GET['withdrawal_request_id'];

        $withdrawal_request = get_withdrawal_request($withdrawal_request_id);

        if(isset($_GET['action']) && $withdrawal_request){

            $action = $_GET['action'];

            if($action > 0 && $action <= 4) {

                $mail_data = $withdrawal_request;

                update_withdrawal_request_status($withdrawal_request_id, $action);

                if ($action == 1) {
                    send_email_template('withdrawal_processed.tpl', $mail_data, $mail_data['withdrawal_requests_pp_email'], get_setting('site_name') . ' - Withdrawal Processed', true);
                } elseif ($action == 2) {
                    send_email_template('withdrawal_delayed.tpl', $mail_data, $mail_data['withdrawal_requests_pp_email'], get_setting('site_name') . ' - Withdrawal Delayed', true);
                } elseif ($action == 3) {
                    send_email_template('withdrawal_failed.tpl', $mail_data, $mail_data['withdrawal_requests_pp_email'], get_setting('site_name') . ' - Withdrawal Failed', true);
                } elseif ($action == 4) {
                    send_email_template('withdrawal_denied.tpl', $mail_data, $mail_data['withdrawal_requests_pp_email'], get_setting('site_name') . ' - Withdrawal Denied', true);
                }

                $success = true;

            }

        }

    }

    /* Rendering template & basic navigation */

    $withdrawals = get_all_withdrawals();
    $transactions = get_all_transactions();

    $permissions = get_permissions();

    $template->assign('success', $success);
    $template->assign('errors', $errors);

    $m = isset($_GET['m']) ? $_GET['m'] : date('n');
    $y = isset($_GET['y']) ? $_GET['y'] : date('Y');

    $template->assign('curr_month', date('F'));

    $template->assign('months', get_months());
    $template->assign('years', get_years());

    $template->assign('m', $m);
    $template->assign('y', $y);

    $template->assign('withdrawals', $withdrawals);
    $template->assign('transactions', $transactions);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'withdrawals.tpl');

}else{

    redirect(get_setting('base_url'));

}