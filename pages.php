<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once 'includes/definitions.php';
require_once FUNCS_DIR . 'core.functions.php';

$slug = $_GET['slug'];

if(isset($slug)) {

    /* Displaying pages based on the slug */

    $page_data = get_page($slug);

    if($page_data) {

        $template->assign(PAGE_TITLE, $page_data['pages_title']);
        $template->assign('rates', get_rates());
        $template->assign('page_content', $template->fetch('string:'.$page_data['pages_content']));
        $template->assign(PAGE_ID, $page_data['pages_id']);

        /* Rendering template */

        $template->display($current_template . 'page.tpl');

    } else{

        error_log('No lang file associated with page ID ' . $page_data['pages_id'] . ' for language ' . get_setting('site_lang'));
        show_404();

    }

}else{

    show_404();

}