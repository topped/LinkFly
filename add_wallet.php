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

$pid = 17;

if($member_data) {

    /* Validating and displaying if a user can withdraw funds */

    $errors = array();

  //  $template->assign('withdrawals', get_withdrawals($member_data['members_id']));

    $template->assign('errors', $errors);

    $template->assign(PAGE_TITLE, $langs[31]);
    $template->assign(PAGE_ID, $pid);

    /* Rendering template */

    $template->display($current_template . 'add_wallet.tpl');

}else{

    redirect('home');

}