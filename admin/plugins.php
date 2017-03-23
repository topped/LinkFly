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

    $admin_pid = 8;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    $success = false;
    $errors = array();

    if(isset($_GET['enable_plugin'])){

        $plugin_id = $_GET['enable_plugin'];

        update_plugin_status($plugin_id, 1);

        $success = true;

    }

    if(isset($_GET['disable_plugin'])){

        $plugin_id = $_GET['disable_plugin'];

        update_plugin_status($plugin_id, 0);

        $success = true;

    }

    if(isset($_POST['slug'])){

        $slug = $_POST['slug'];

        $plugin_folder = sprintf('../plugins/%s/', $slug);
        $plugin_file = sprintf('%s%s.php', $plugin_folder, $slug);

        if(file_exists($plugin_file) == false)
            $errors[] = 'Plugin file could not be found.';

        if(count($errors) == 0){

            $success = true;

        }

    }

    /* Rendering template & basic navigation */

    $template->assign('success', $success);
    $template->assign('errors', $errors);

    $template->assign('plugins', get_plugins());

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'plugins.tpl');

}else{

    redirect(get_setting('base_url'));

}