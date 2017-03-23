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

    $admin_pid = 1;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    /* Rendering template & basic navigation */

    $success = false;
    $errors = array();

    if(empty($_POST) == false) {

        if(isset($_POST['base_url'])) {
            if (ends_with($_POST['base_url'], '/') == false)
                $errors[] = 'Base URL needs to end with \'/\'.';
        }

        if(isset($_POST['email_from'])) {
            if (!filter_var($_POST['email_from'], FILTER_VALIDATE_EMAIL))
                $errors[] = '\'From\' E-Mail needs to be a valid e-mail address.';
        }

        if(count($errors) == 0){
            save_settings();
            $success = true;
        }

    }

    $templates = get_all_templates();

    //die(print_r($templates));

    $template->assign('templates', $templates);

    $template->assign('success', $success);
    $template->assign('errors', $errors);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'general.tpl');

}else{

    redirect(get_setting('base_url'));

}