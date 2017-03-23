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

    $campaign_id = $_GET['campaign_id'];

    $success = false;

    if(isset($_POST['campaign_id'])){

        $campaign_id = $_POST['campaign_id'];

        $campaign_update_data = array();

        $campaign_update_data['campaigns_name'] = strip_tags($_POST['name']);
        $campaign_update_data['campaigns_website_name'] = strip_tags($_POST['website_name']);
        $campaign_update_data['campaigns_website_url'] =  strip_tags($_POST['website_url']);
        $campaign_update_data['campaigns_daily_budget'] =  strip_tags($_POST['daily_budget']);
        $campaign_update_data['campaigns_current_budget'] =  strip_tags($_POST['current_budget']);
        $campaign_update_data['campaigns_budget_used_today'] =  strip_tags($_POST['budget_used_today']);
        $campaign_update_data['campaigns_last_budget_reset'] =  strip_tags($_POST['last_budget_reset']);
        $campaign_update_data['campaigns_started'] =  strip_tags($_POST['campaigns_started']);
        $campaign_update_data['campaigns_rates_id'] =  strip_tags($_POST['rates_id']);
        $campaign_update_data['campaigns_ordered_views'] = strip_tags($_POST['ordered_views']);
        $campaign_update_data['campaigns_approved'] =  strip_tags($_POST['approved']);

        if($_POST['approved'] == 1){
            $reject_reason = null;
        }else{
            $reject_reason = $_POST['reject_reason'];
        }
        $campaign_update_data['campaigns_reject_reason'] = $reject_reason;

        $campaign_update_data['campaigns_status'] =  strip_tags($_POST['status']);
        $campaign_update_data['campaigns_type'] =  strip_tags($_POST['type']);
        $campaign_update_data['campaigns_device'] =  strip_tags($_POST['device']);
        $campaign_update_data['campaigns_payment_accepted'] =  strip_tags($_POST['payment_accepted']);

        update_campaign($campaign_id, $campaign_update_data);

        $success = true;

    }

    $campaign_info_data = get_campaign_data($campaign_id);

    $template->assign('success', $success);

    $template->assign('rates', get_rates());

    $template->assign('campaign', $campaign_info_data);

    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());

    $template->display(ADMIN_TEMPLATE . 'campaigns_edit.tpl');

}else{

    redirect(get_setting('base_url'));

}