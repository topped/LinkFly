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

    $success = false;
    $errors = array();

    if(isset($_POST['name'])){

        $permission_name = $_POST['name'];
        $permission_need_account = $_POST['need_account'];
        $permission_can_shorten = $_POST['can_shorten'];
        $permission_can_advertise = $_POST['can_advertise'];
        $permission_need_captcha = $_POST['need_captcha'];
        $permission_custom_alias = $_POST['custom_alias'];
        $permission_change_domain = $_POST['change_domain'];
        $permission_change_ad_type = $_POST['change_ad_type'];
        $permission_link_waiting_time_sec = $_POST['link_waiting_time_sec'];
        $permission_spam_waiting_time = $_POST['spam_waiting_time'];

        if(empty($permission_name))
            $errors[] = 'Permission name required.';

        if($permission_link_waiting_time_sec < 0)
            $errors[] = 'Link waiting time cannot be smaller than 0.';

        if(is_numeric($permission_link_waiting_time_sec) == false)
            $errors[] = 'Link waiting time needs to be a number.';

        if(is_numeric($permission_spam_waiting_time) == false)
            $errors[] = 'Spam waiting time needs to be a number.';

        if(count($errors) == 0){

            $permission_data = array();

            $permission_data['permissions_name'] = strip_tags($permission_name);
            $permission_data['permissions_need_account'] = $permission_need_account;
            $permission_data['permissions_can_shorten'] = $permission_can_shorten;
            $permission_data['permissions_can_advertise'] = $permission_can_advertise;
            $permission_data['permissions_link_waiting_time_sec'] = $permission_link_waiting_time_sec;
            $permission_data['permissions_need_captcha'] = $permission_need_captcha;
            $permission_data['permissions_custom_alias'] = $permission_custom_alias;
            $permission_data['permissions_change_domain'] = $permission_change_domain;
            $permission_data['permissions_change_ad_type'] = $permission_change_ad_type;
            $permission_data['permissions_spam_waiting_time'] = $permission_spam_waiting_time;

            if(insert_permission($permission_data))
                $success = true;

        }

    }

    $template->assign('success', $success);

    $template->assign('errors', $errors);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'add_permission.tpl');

}else{

    redirect(get_setting('base_url'));

}