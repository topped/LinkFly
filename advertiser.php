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

$pid = 8;

if($member_data && $current_permission['permissions_can_advertise']) {

    if(isset($_POST['delete_id'])){

            $campaign_id  = $_POST['delete_id'];

            $campaign_data = get_campaign_data($campaign_id);

            if($campaign_data['campaigns_members_id'] == $member_data['members_id']) {
                delete_campaign($campaign_id);
                redirect('advertiser');
            }

    }

    $template->assign(PAGE_TITLE, $langs[28]);
    $template->assign(PAGE_ID, $pid);

    $campaigns_member = get_campaigns_member($member_data['members_id']);

    $m = isset($_GET['m']) ? $_GET['m'] : date('n');
    $y = isset($_GET['y']) ? $_GET['y'] : date('Y');

    $template->assign('curr_month', date('F'));

    $template->assign('months', get_months());
    $template->assign('years', get_years());

    $template->assign('m', $m);
    $template->assign('y', $y);

    $template->assign('top_countries', get_top_countries_campaigns($member_data['members_id']));
    $template->assign('top_refs', get_top_referrals_campaigns($member_data['members_id']));
    $template->assign('top_devices', get_top_devices_campaigns($member_data['members_id']));

    /* Rendering template */

    $template->assign('chart_code', generate_chart_code($m, $y, null, true));
    $template->assign('campaigns', $campaigns_member);

    $template->display($current_template . 'advertiser.tpl');

}else{

    redirect('home');

}