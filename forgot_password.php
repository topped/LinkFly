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

$pid = 13;

$template->assign(PAGE_TITLE, $langs[47]);
$template->assign(PAGE_ID, $pid);

/* Rendering template */

$errors = array();
$step = 1;

$reset_code = null;

if(empty($_POST) == false) {

    if(isset($_POST['email'])) {

        $email = $_POST['email'];

        if (email_exists($email) == false)
            $errors[] = $langs[264];

        if (empty($errors)) {

            $reset_code = md5($_POST['email'] + microtime());

            update_email_code($email, $reset_code);

            $data['reset_link'] = get_setting('base_url') . 'forgot_password?reset_code=' . $reset_code;

            send_email_template('forgot_password.tpl', $data, $email, get_setting('site_name') . ' - Password Reset');
        }

    }else{

        $password = $_POST['password'];
        $password_repeat = $_POST['password_repeat'];
        $reset_code = $_POST['reset_code'];

        $member_data = get_member_email_code($reset_code);

        $step = 2;

        if($member_data == false)
            $errors[] = $langs[265];

        if($password != $password_repeat)
            $errors[] = $langs[266];

        if(strlen($password) < get_setting('min_pass_length'))
            $errors[] = $langs[267];

        if(!preg_match('/[A-Z]/', $password))
            $errors[] = $langs[268];

        if (!preg_match('#[0-9]#', $password))
            $errors[] = $langs[269];

        if(empty($errors)){

            $password_hash = hash('sha256', $password);

            if(update_password($member_data['members_id'], $password_hash)){
                redirect('login?pr=true');
            }else{
                $errors[] = $langs[270];
            }

        }

    }

}

if(empty($_GET) == false){

    $reset_code = $_GET['reset_code'];
    $member_data = get_member_email_code($reset_code);

    if(empty($reset_code)){
        $errors[] = $langs[271];
    }else if($member_data == false){
        $errors[] = $langs[272];
    }

    if(empty($errors)){

        $step = 2;

    }

}

$template->assign('reset_code', $reset_code);

$template->assign('errors', $errors);
$template->assign('step', $step);

$template->display($current_template . 'forgot_password.tpl');