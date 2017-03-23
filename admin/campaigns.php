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

    if(empty($_POST) == false && isset($_POST['delete_id']) == false && isset($_POST['delete_rate']) == false) {

        if($_POST['interstitial_ad_percentage'] < 0 || $_POST['interstitial_ad_percentage'] > 100)
            $errors[] = 'Interstitial Ad Percentage needs to be larger than 0 and smaller than 100.';

        if($_POST['banner_ad_percentage'] < 0 || $_POST['banner_ad_percentage'] > 100)
            $errors[] = 'Banner Ad Percentage needs to be larger than 0 and smaller than 100.';

        if($_POST['no_ad_percentage'] < 0 || $_POST['no_ad_percentage'] > 100)
            $errors[] = 'No Ad Percentage needs to be larger than 0 and smaller than 100.';

        if(is_numeric($_POST['interstitial_ad_percentage']) == false)
            $errors[] = 'Interstitial Ad Percentage needs to be a number.';

        if(is_numeric($_POST['banner_ad_percentage']) == false)
            $errors[] = 'Banner Ad Percentage needs to be a number.';

        if(is_numeric($_POST['no_ad_percentage']) == false)
            $errors[] = 'No Ad Percentage needs to be a number.';

        if(is_numeric($_POST['min_daily_budget']) == false)
            $errors[] = 'Minimum Daily Budget needs to be a number.';

        if(is_numeric($_POST['min_quantity_views']) == false)
            $errors[] = 'Minimum Quantity Views needs to be a number.';

        if(is_numeric($_POST['max_quantity_views']) == false)
            $errors[] = 'Maximum Quantity views needs to be a number.';

        if(is_numeric($_POST['banner_width']) == false)
            $errors[] = 'Banner Width needs to be a number.';

        if(is_numeric($_POST['banner_height']) == false)
            $errors[] = 'Banner Height needs to be a number.';

        if(count($errors) == 0){
            save_settings();
            $success = true;
        }

    }

    if(isset($_POST['delete_id'])){
        $campaign_id = $_POST['delete_id'];
        delete_campaign($campaign_id);
    }

    if(isset($_POST['delete_rate'])){
        $rate_id = $_POST['delete_rate'];
        delete_rate($rate_id);
    }

    if(isset($_GET['approve_campaign_id'])){
        $campaign_id = $_GET['approve_campaign_id'];
        change_campaign_status($campaign_id, 1);
    }

    if(isset($_GET['reject_campaign_id'])){
        $campaign_id = $_GET['reject_campaign_id'];
        change_campaign_status($campaign_id, 2);
    }

    $campaigns = get_campaigns();

    $template->assign('success', $success);
    $template->assign('errors', $errors);

    $template->assign('rates', get_rates());
    $template->assign('campaigns', $campaigns);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'campaigns.tpl');

}else{

    redirect(get_setting('base_url'));

}