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

    if(isset($_POST['domain_url'])){

        $domain_url = $_POST['domain_url'];

        if (filter_var($domain_url, FILTER_VALIDATE_URL) === false) {
            $errors[] = 'Not a valid URL.';
        }

        if(ends_with($domain_url, '/') == false){
            $errors[] = 'Needs to end with a forward slash (/).';
        }

        if(count($errors) == 0){

            if(insert_domain($domain_url))
                $success = true;

        }

    }

    $template->assign('success', $success);

    $template->assign('errors', $errors);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'add_domain.tpl');

}else{

    redirect(get_setting('base_url'));

}