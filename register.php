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

$pid = 5;

$errors = array();
$success = false;

if(empty($_POST) == false){

    /* Creating the account */

    $username = isset($_POST['username']) ? $_POST['username'] : null;
    $password = isset($_POST['password']) ? $_POST['password'] : null;
    $password_repeat = isset($_POST['password_repeat']) ? $_POST['password_repeat'] : null;
    $email = isset($_POST['email']) ? $_POST['email'] : null;
    $terms = isset($_POST['terms']) ? $_POST['terms'] : 'off';
    $captcha = isset($_POST['captcha']) ? $_POST['captcha'] : false;

    $securimage = new Securimage();

    if(get_setting('open_registration') == 0)
        $errors[] = $langs[306];

    if(empty($username))
        $errors[] = $langs[288];

    if(strlen($username) < 3)
        $errors[] = $langs[289];

    if(strlen($username) > 20)
        $errors[] = $langs[335];

    if (preg_match('/[^A-Za-z0-9]/', $username))
        $errors[] = $langs[290];

    if($captcha == false || !$securimage->check($captcha))
        $errors[] = $langs[257];

    if($password != $password_repeat)
        $errors[] = $langs[266];

    if(strlen($password) < get_setting('min_pass_length'))
        $errors[] = $langs[267];

    if(!preg_match('/[A-Z]/', $password))
        $errors[] = $langs[268];

    if (!preg_match('#[0-9]#', $password))
        $errors[] = $langs[269];

    if (!filter_var($email, FILTER_VALIDATE_EMAIL))
        $errors[] = $langs[283];

    if($terms == 'off')
        $errors[] = $langs[291];

    if(unique_username($username) == false)
        $errors[] = $langs[292];

    if(unique_email($email) == false)
        $errors[] = $langs[293];

    if(empty($errors)){

        $activation_code = md5($username . microtime());
        $api_key = md5(rand() . microtime());

        $member_data = array();

        $member_data['members_username'] = $username;
        $member_data['members_password'] = hash('sha256', $password);
        $member_data['members_email'] = $email;
        $member_data['members_ip'] = strip_tags(get_ip());
        $member_data['members_permissions_id'] = get_setting('default_permission_user');
        $member_data['members_activation_code'] = $activation_code;
        $member_data['members_api_key'] = $api_key;

        $member_id = insert_member($member_data);

        if($member_id){

            /* Send activation e-mail */

            $activation_link = get_setting('base_url') . 'login?activate=' . $activation_code;

            $data = array();
            $data['activation_link'] = $activation_link;

            /* Sending e-mail activation */

            send_email_template('activate_email.tpl', $data, $email, get_setting('site_name') . ' - Welcome! Please activate your account.');

            $success = true;

        }else{
            $errors[] = $langs[190];
        }

    }

}

$template->assign('errors', $errors);

$template->assign('success', $success);

$template->assign(PAGE_TITLE, $langs[24]);
$template->assign(PAGE_ID, $pid);

/* Rendering template */

$template->display($current_template . 'register.tpl');