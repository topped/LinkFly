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

$pid = 12;

if($member_data) {

    $errors = array();

    $success = false;

    /* Changing account settings if $_POST is full */

    if(empty($_POST) == false){

        $changing_pass = false;

        $current_password = hash('sha256', isset($_POST['password']) ? $_POST['password'] : null);
        $email = isset($_POST['email']) ? $_POST['email'] : null;
        $username = isset($_POST['username']) ? $_POST['username'] : null;
        $csrf_token = $_POST['csrf_token'];

        if(validate_csrf($csrf_token) == false)
            $errors[] = $langs[339];

        if($current_password != $member_data['members_password'])
            $errors[] = $langs[287];

        if (!filter_var($email, FILTER_VALIDATE_EMAIL))
            $errors[] = $langs[283];

        if(unique_email($email) == false && $email != $member_data['members_email'])
            $errors[] = $langs[293];

        if(empty($_POST['new_password']) == false){

            $changing_pass = true;

            $password = $_POST['new_password'];
            $password_repeat = $_POST['new_password_repeat'];

            if(strlen($username) < 3)
                $errors[] = $langs[289];

            if(strlen($username) > 20)
                $errors[] = $langs[335];

            if (preg_match('/[^A-Za-z0-9]/', $username))
                $errors[] = $langs[290];

            if(unique_username($username) == false)
                $errors[] = $langs[292];

            if($password != $password_repeat)
                $errors[] = $langs[266];

            if(strlen($password) < get_setting('min_pass_length'))
                $errors[] = $langs[267];

            if(!preg_match('/[A-Z]/', $password))
                $errors[] = $langs[268];

            if (!preg_match('#[0-9]#', $password))
                $errors[] = $langs[269];

        }

        /* Changing passwords, username and valid password is required before anything can be updated */

        if(empty($errors)){

            if($changing_pass)
                update_password($member_data['members_id'], hash('sha256', $password));

            if(isset($username) && $member_data['members_username'] != $username)
                update_username($member_data['members_id'], $username);

            if($email != $member_data['members_email'])
                update_email($member_data['members_id'], $email);

            $success = true;

        }

    }

    $template->assign(PAGE_TITLE, $langs[41]);
    $template->assign(PAGE_ID, $pid);

    $template->assign('errors', $errors);

    $template->assign('domains', get_domains());
    $template->assign('success', $success);

    $template->assign('transactions', get_transactions_member($member_data['members_id']));

    /* Rendering template */

    $template->display($current_template . 'my_account.tpl');

}else{

    redirect('home');

}