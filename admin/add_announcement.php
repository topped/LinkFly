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

    $admin_pid = 7;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    /* Rendering template & basic navigation */

    $success = false;
    $errors = array();

    if(isset($_POST['message'])){

        $announcement_message = $_POST['message'];
        $announcement_type = $_POST['type'];

        if(empty($announcement_message))
            $errors[] = 'Message is required.';

        if(count($errors) == 0){

            $announcement_data = array();

            $announcement_data['announcements_message'] = $announcement_message;
            $announcement_data['announcements_type'] = strip_tags($announcement_type);

            if(insert_announcement($announcement_data))
                $success = true;

        }

    }

    $template->assign('success', $success);

    $template->assign('errors', $errors);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'add_announcement.tpl');

}else{

    redirect(get_setting('base_url'));

}