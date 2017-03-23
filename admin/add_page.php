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

    $success = false;
    $errors = array();

    if(isset($_POST['title'])){

        $page_title = $_POST['title'];
        $page_slug = slugify($_POST['slug']);
        $page_content = $_POST['content'];
        $page_lang = $_POST['lang'];

        if(empty($page_title))
            $errors[] = 'Page title required.';

        if(empty($page_content))
            $errors[] = 'Page content required.';

        if(empty($page_lang))
            $errors[] = 'Language required.';

        if(count($errors) == 0){

            $page_data = array();

            $page_data['pages_title'] = strip_tags($page_title);
            $page_data['pages_slug'] = strip_tags($page_slug);
            $page_data['pages_content'] = $page_content;
            $page_data['pages_lang'] = strip_tags($page_lang);

            if(insert_page($page_data))
                $success = true;

        }

    }

    $template->assign('success', $success);

    $template->assign('errors', $errors);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'add_page.tpl');

}else{

    redirect(get_setting('base_url'));

}