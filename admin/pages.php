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

    $admin_pid = 6;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    if(isset($_POST['delete_id'])){
        $page_id = $_POST['delete_id'];
        delete_page($page_id);
    }

    if(save_settings())
        $success = true;

    /* Rendering template & basic navigation */

    $success = false;

    $pages = get_all_pages();

    $template->assign('success', $success);
    $template->assign('pages', $pages);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'pages.tpl');

}else{

    redirect(get_setting('base_url'));

}