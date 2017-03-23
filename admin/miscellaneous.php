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

    if(isset($_POST['delete_report_id'])){
        $report_id = $_POST['delete_report_id'];
        delete_report($report_id);
    }

    if(isset($_POST['delete_contact_id'])){
        $contact_id = $_POST['delete_contact_id'];
        delete_contact($contact_id);
    }

    if(isset($_POST['delete_announcement_id'])){
        $announcement_id = $_POST['delete_announcement_id'];
        delete_announcement($announcement_id);
    }

    /* Rendering template & basic navigation */

    $reports = get_all_reports();
    $contacts = get_all_contacts();
    $announcements = get_all_announcements();

    $success = false;

    $template->assign('success', $success);

    $template->assign('reports', $reports);
    $template->assign('contacts', $contacts);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'miscellaneous.tpl');

}else{

    redirect(get_setting('base_url'));

}