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

    $admin_pid = 4;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    /* Rendering template & basic navigation */

    $rate_id = $_GET['rate_id'];

    $success = false;

    if(isset($_POST['rate_id'])){

        $rate_id = $_POST['rate_id'];

        $rate_update_data = array();

        $rate_update_data['rates_name'] =  strip_tags($_POST['name']);
        $rate_update_data['rates_desc'] = $_POST['desc'];
        $rate_update_data['rates_location'] =  strip_tags($_POST['location']);

        if($_POST['cpm'] < 0) {
            $success = false;
        }else {

            $rate_update_data['rates_cpm'] = $_POST['cpm'];

            update_rate($rate_id, $rate_update_data);

            $success = true;

        }

    }

    $rate_data = get_rate($rate_id);

    $template->assign('success', $success);

    $template->assign('rate', $rate_data);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'rates_edit.tpl');

}else{

    redirect(get_setting('base_url'));

}