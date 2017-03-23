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

$pid = 15;

if($member_data && $current_permission['permissions_can_advertise']) {

    $errors = array();

    if(empty($_POST) == false){

        $campaign_id = $_POST['campaign_id'];

        $campaign_data = get_campaign_data($campaign_id);

        if($campaign_data['campaigns_members_id'] == $member_data['members_id']){

            $campaign_name = $_POST['campaign_name'];
            $daily_budget = $_POST['daily_budget'];
            $ad_type = $_POST['ad_type'];
            $website_name = $_POST['website_name'];
            $website_url = $_POST['website_url'];
            $traffic_source = $_POST['traffic_source'];
            $csrf_token = $_POST['csrf_token'];

            if(validate_csrf($csrf_token) == false)
                $errors[] = $langs[339];

            if(strlen($campaign_name) < 5)
                $errors[] = $langs[258];

            if(!is_numeric($daily_budget))
                $errors[] = $langs[259];

            if($daily_budget < get_setting('min_daily_budget'))
                $errors[] = sprintf($langs[260], get_setting('min_daily_budget'), get_setting('site_curr'));

            if(strlen($website_name) < 5)
                $errors[] = $langs[261];

            if(!filter_var($website_url, FILTER_VALIDATE_URL))
                $errors[] = $langs[262];

            if($traffic_source < 0 || $traffic_source > 2)
                $errors[] = $langs[263];

            if(empty($errors)){

                $update_data = array();

                $update_data['campaigns_name'] = strip_tags($campaign_name);
                $update_data['campaigns_daily_budget'] = $daily_budget;
                $update_data['campaigns_type'] = $ad_type;
                $update_data['campaigns_website_name'] = strip_tags($website_name);
                $update_data['campaigns_website_url'] = $website_url;
                $update_data['campaigns_device'] = $traffic_source;

                if(get_setting('update_requires_approval'))
                    $update_data['campaigns_approved'] = 0;

                update_campaign($campaign_id, $update_data);
                redirect('advertiser');

            }

        } else {

            show_404();

        }

    } else {

        $campaign_id = $_GET['id'];
        $campaign_data = get_campaign_data($campaign_id);

        if ( $campaign_data['campaigns_members_id'] == $member_data['members_id']) {

            $template->assign('campaign_data', $campaign_data);

        } else {

            show_404();

        }
    }

    $template->assign('errors', $errors);
    $template->assign(PAGE_TITLE, $langs[55]);
    $template->assign(PAGE_ID, $pid);

    /* Rendering template */

    $template->display($current_template . 'edit_campaign.tpl');

}else{

    redirect('home');

}