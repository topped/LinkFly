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

    $announcement_id = $_GET['announcement_id'];

    $success = false;

    if(isset($_POST['announcement_id'])){

        $announcement_id = $_POST['announcement_id'];

        $announcement_update_data = array();

        $announcement_update_data['announcements_type'] = $_POST['type'];

        if(empty($_POST['message'])){
            $success = false;
        }else{

            $announcement_update_data['announcements_message'] = $_POST['message'];

            update_announcement($announcement_id, $announcement_update_data);

            $success = true;

        }

    }

    $announcement_data = get_announcement($announcement_id);

    $template->assign('success', $success);

    $template->assign('announcement', $announcement_data);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'announcements_edit.tpl');

}else{

    redirect(get_setting('base_url'));

}