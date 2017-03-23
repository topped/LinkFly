<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once 'includes/definitions.php';
$flag_login = true;
require_once FUNCS_DIR . 'core.functions.php';

$pid = 4;

if($member_data == false) {

    $login_error_code = false;

    /* Validating login */

    if (isset($_POST['username'])) {

        $username = $_POST['username'];
        $password = $_POST['password'];

        //$remember_me = $_POST['remember_me'];

        if (isset($password)) {

            if (validate_user($username, $password)) {

                redirect('dashboard');

            } else {

                $login_error_code = 2;
            }
        } else {

            $login_error_code = 1;
        }

    }

    /* Handling account activation */

    $activated = false;

    if (isset($_GET['activate'])) {

        $activation_code = $_GET['activate'];

        if (activate_user($activation_code)) {

            $activated = true;

        }

    }

    $template->assign('login_error_code', $login_error_code);
    $template->assign('activated', $activated);

    $template->assign(PAGE_TITLE, $langs[25]);
    $template->assign(PAGE_ID, $pid);

    /* Rendering template */

    $template->display($current_template . 'login.tpl');

}else{

    redirect(get_setting('base_url'));

}