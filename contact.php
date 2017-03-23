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

$pid = 23;

$errors = array();
$success = false;

if(empty($_POST) == false){

    $email = isset($_POST['email']) ? $_POST['email'] : null;
    $url = isset($_POST['url']) ? $_POST['url'] : null;
    $desc = isset($_POST['desc']) ? $_POST['desc'] : null;
    $captcha = isset($_POST['captcha']) ? $_POST['captcha'] : null;

    $securimage = new Securimage();

    if(!$securimage->check($captcha))
        $errors[] = $langs[257];

    if (!filter_var($email, FILTER_VALIDATE_EMAIL))
        $errors[] = $langs[283];

    if(empty($url) == false) {
        if (!filter_var($url, FILTER_VALIDATE_URL))
            $errors[] = $langs[32];
    }

    if(strlen($desc) < 100)
        $errors[] = $langs[284];

    if(empty($errors)){

        $contact_data = array();

        $contact_data['contacts_url'] = $url;
        $contact_data['contacts_desc'] = strip_tags($desc);
        $contact_data['contacts_email'] = $email;

        if(isset($member_data['members_id']))
            $contact_data['contacts_members_id'] = $member_data['members_id'];

        if(insert_contact($contact_data))
            $success = true;

    }else{
        $template->assign('errors', $errors);
    }

}

$template->assign('success', $success);

$template->assign(PAGE_TITLE, $langs[61]);
$template->assign(PAGE_ID, $pid);

/* Rendering template */

$template->display($current_template . 'contact.tpl');