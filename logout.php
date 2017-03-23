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

$pid = 5;

if(!empty($_SESSION['members_id'])) {

    /* Destroying login session */

    destroy_session();

    /* Redirecting home */

    redirect('login');

}