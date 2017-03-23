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

    $success = false;
    $errors = array();

    if(empty($_POST) == false && isset($_POST['delete_id']) == false && isset($_POST['delete_permission']) == false) {

        if(is_numeric($_POST['min_pass_length']) == false)
            $errors[] = 'Minimum Password length needs to be a number.';

        if(count($errors) == 0){
            save_settings();
            $success = true;
        }

    }

    /* Rendering template & basic navigation */

    if(isset($_POST['delete_id'])){
        if($_POST['delete_id'] != $member_data['members_id']) {
            $member_id = $_POST['delete_id'];
            delete_member($member_id);
        }
    }

    if(isset($_POST['delete_permission'])){
        $permission_id = $_POST['delete_permission'];
        delete_permission($permission_id);
    }

    $members = get_members();

    $permissions = get_permissions();

    $template->assign('success', $success);
    $template->assign('errors', $errors);

    $template->assign('permissions', $permissions);

    $template->assign('members', $members);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'members.tpl');

}else{

    redirect(get_setting('base_url'));

}