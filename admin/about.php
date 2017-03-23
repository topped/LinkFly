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

    $admin_pid = 9;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    if(save_settings())
        $success = true;

    /* Rendering template & basic navigation */

    $withdrawals = get_all_withdrawals();
    $transactions = get_all_transactions();

    $success = false;

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'about.tpl');

}else{

    redirect(get_setting('base_url'));

}