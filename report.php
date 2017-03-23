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

$pid = 14;

$errors = array();
$success = false;

if(empty($_POST) == false){

    /* Inserting new report */

    $email = isset($_POST['email']) ? $_POST['email'] : null;
    $topic = $_POST['topic'];
    $url = isset($_POST['url']) ? $_POST['url'] : null;
    $desc = isset($_POST['desc']) ? $_POST['desc'] : null;
    $captcha = isset($_POST['captcha']) ? $_POST['captcha'] : null;

    $securimage = new Securimage();

    if(!$securimage->check($captcha))
        $errors[] = $langs[257];

    if (!filter_var($email, FILTER_VALIDATE_EMAIL))
        $errors[] = $langs[283];

    if(in_array($topic, array(0,1,2,3,4)) == false)
        $errors[] = $langs[286];

    if(empty($url) == false) {
        if (!filter_var($url, FILTER_VALIDATE_URL))
            $errors[] = $langs[32];
    }

    if(strlen($desc) < 100)
        $errors[] = $langs[284];

    if(empty($errors)){

        $report_data = array();

        $report_data['reports_topic'] = strip_tags($topic);
        $report_data['reports_url'] = $url;
        $report_data['reports_desc'] = strip_tags($desc);
        $report_data['reports_email'] = $email;

        if(insert_report($report_data))
            $success = true;

    }else{
        $template->assign('errors', $errors);
    }

}

$template->assign('success', $success);

$template->assign(PAGE_TITLE, $langs[51]);
$template->assign(PAGE_ID, $pid);

/* Rendering template */

$template->display($current_template . 'report.tpl');