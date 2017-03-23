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

    $success = false;
    $errors = array();

    if(isset($_POST['name'])){

        $rate_name = $_POST['name'];
        $rate_desc = $_POST['desc'];
        $rate_cpm = $_POST['cpm'];
        $rate_location = $_POST['location'];

        if(empty($rate_name))
            $errors[] = 'Rate name required.';

        if(empty($rate_desc))
            $errors[] = 'Rate description required.';

        if($rate_cpm <= 0)
            $errors[] = 'Rate CPM cannot be 0 or be smaller than 0.';

        if(is_numeric($rate_cpm) == false)
            $errors[] = 'Rate CPM has to be a number.';

        if(empty($rate_location))
            $rate_location = null;

        if(count($errors) == 0){

            $rate_data = array();

            $rate_data['rates_name'] = strip_tags($rate_name);
            $rate_data['rates_desc'] = $rate_desc;
            $rate_data['rates_cpm'] = $rate_cpm;
            $rate_data['rates_location'] = strip_tags($rate_location);

            if(insert_rate($rate_data))
                $success = true;

        }

    }

    $template->assign('success', $success);

    $template->assign('errors', $errors);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'add_rate.tpl');

}else{

    redirect(get_setting('base_url'));

}