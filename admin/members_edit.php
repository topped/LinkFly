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

    $admin_pid = 3;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    /* Rendering template & basic navigation */

    $member_id = $_GET['member_id'];

    $success = false;

    if(isset($_POST['member_id'])){

        $member_id = $_POST['member_id'];

        $member_update_data = array();

        $member_update_data['members_username'] =  strip_tags($_POST['username']);
        $member_update_data['members_email'] =  strip_tags($_POST['email']);
        $member_update_data['members_balance'] =  strip_tags($_POST['balance']);
        $member_update_data['members_activation_code'] =  strip_tags($_POST['activation_code']);
        $member_update_data['members_email_code'] =  strip_tags($_POST['email_code']);
        $member_update_data['members_ip'] =  strip_tags($_POST['ip']);
        $member_update_data['members_status'] = strip_tags( $_POST['status']);
        $member_update_data['members_admin'] =  strip_tags($_POST['admin']);
        $member_update_data['members_permissions_id'] = strip_tags( $_POST['permissions_id']);

        if(empty($password) == false)
            $member_update_data['members_password'] = hash('sha256', $_POST['password']);

        update_member($member_id, $member_update_data);

        $success = true;

    }

    $member_info_data = get_member($member_id);
    $permissions = get_permissions();

    $template->assign('success', $success);
    $template->assign('permissions', $permissions);

    $template->assign('member', $member_info_data);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'members_edit.tpl');

}else{

    redirect(get_setting('base_url'));

}