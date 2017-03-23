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

    /* Rendering template & basic navigation */

    $page_id = $_GET['page_id'];

    $success = false;

    if(isset($_POST['page_id'])){

        $page_id = $_POST['page_id'];

        $page_update_data = array();

        $page_update_data['pages_title'] =  strip_tags($_POST['title']);
        $page_update_data['pages_content'] = $_POST['content'];
        $page_update_data['pages_lang'] =  strip_tags($_POST['lang']);
        $page_update_data['pages_slug'] = slugify($_POST['slug']);

        if(empty($_POST['title']) == false){

            update_page($page_id, $page_update_data);

            $success = true;

        }

    }

    $page_data = get_page_by_id($page_id);

    $template->assign('success', $success);

    $template->assign('page', $page_data);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'pages_edit.tpl');

}else{

    redirect(get_setting('base_url'));

}