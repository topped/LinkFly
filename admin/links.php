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

    $admin_pid = 2;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    /* Rendering template & basic navigation */

    $success = false;
    $errors = array();

    if(empty($_POST) == false && isset($_POST['delete_domain']) == false) {

        if(is_numeric($_POST['suffix_length']) == false)
            $errors[] = 'Suffix Length needs to be a number.';

        if(is_numeric($_POST['custom_alias_max_length']) == false)
            $errors[] = 'Custom alias max length needs to be a number.';

        if(is_numeric($_POST['custom_alias_min_length']) == false)
            $errors[] = 'Custom alias min length needs to be a number.';

        if(count($errors) == 0){
            save_settings();
            $success = true;
        }

    }

    if(isset($_GET['delete_link'])){
        $delete_link_id = $_GET['delete_link'];
        delete_link($delete_link_id);
    }

    if(isset($_POST['delete_domain'])){
        $delete_domain_id = $_POST['delete_domain'];
        delete_domain($delete_domain_id);
    }

    if(isset($_GET['disable_link'])){
        $disable_link_id = $_GET['disable_link'];
        change_link_status($disable_link_id, 0);
    }

    if(isset($_GET['enable_link'])){
        $enable_link_id = $_GET['enable_link'];
        change_link_status($enable_link_id, 1);
    }

    $links = get_admin_links();

    $template->assign('links', $links);
    $template->assign('domains', get_domains());

    $template->assign('success', $success);
    $template->assign('errors', $errors);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'links.tpl');

}else{

    redirect(get_setting('base_url'));

}