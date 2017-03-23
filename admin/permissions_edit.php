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

    $permission_id = $_GET['permission_id'];

    $success = false;

    if(isset($_POST['permission_id'])){

        $permission_id = $_POST['permission_id'];

        $permission_update_data = array();

        $permission_update_data['permissions_name'] =  strip_tags($_POST['name']);
        $permission_update_data['permissions_need_account'] = $_POST['need_account'];
        $permission_update_data['permissions_can_shorten'] = $_POST['can_shorten'];
        $permission_update_data['permissions_can_advertise'] = $_POST['can_advertise'];
        $permission_update_data['permissions_need_captcha'] = $_POST['need_captcha'];
        $permission_update_data['permissions_custom_alias'] = $_POST['custom_alias'];
        $permission_update_data['permissions_change_domain'] = $_POST['change_domain'];
        $permission_update_data['permissions_change_ad_type'] = $_POST['change_ad_type'];
        $permission_update_data['permissions_spam_waiting_time'] = $_POST['spam_waiting_time'];

        if($_POST['link_waiting_time_sec'] < 0) {
            $success = false;
        }else {

            $permission_update_data['permissions_link_waiting_time_sec'] = $_POST['link_waiting_time_sec'];

            update_permission($permission_id, $permission_update_data);

            $success = true;

        }

    }

    $permission_data = get_permission($permission_id);

    $template->assign('success', $success);

    $template->assign('permission', $permission_data);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'permissions_edit.tpl');

}else{

    redirect(get_setting('base_url'));

}