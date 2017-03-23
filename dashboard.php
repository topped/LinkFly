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

$pid = 7;

if($member_data) {

    /* Posting a shortened URL using the dashboard */

    if(isset($_POST['delete_id'])){

        $link_id = $_POST['delete_id'];

        /* First, check if the link belongs to the current user */

        $link_data = get_link($link_id);

        if($link_data['links_members_id'] == $member_data['members_id'])
            delete_link($link_id);

        redirect('dashboard');

    }

    $template->assign(PAGE_TITLE, $langs[27]);
    $template->assign(PAGE_ID, $pid);

    $template->assign('domains', get_domains());
    $template->assign('links',  get_links_member($member_data['members_id']));

    $total_views = get_total_view_count($member_data['members_id']);
    $total_earnings = get_total_earnings($member_data['members_id']);

    $template->assign('top_countries', get_top_countries($member_data['members_id']));
    $template->assign('top_refs', get_top_referrals($member_data['members_id']));

    $template->assign('total_views', $total_views);
    $template->assign('total_earnings', number_format($total_earnings, 5, '.', ''));
    $template->assign('average_cpm', number_format(@round(($total_earnings / $total_views ) * 1000, 5), 5, '.', ''));
    $template->assign('average_view', number_format(@round(($total_earnings / $total_views ), 5), 5, '.', ''));

    $template->assign('curr_month', date('F'));

    $template->assign('months', get_months());
    $template->assign('years', get_years());

    $m = isset($_GET['m']) ? $_GET['m'] : date('n');
    $y = isset($_GET['y']) ? $_GET['y'] : date('Y');

    $template->assign('m', $m);
    $template->assign('y', $y);

    $template->assign('chart_code', generate_chart_code($m, $y));

    /* Rendering template */

    $template->display($current_template . 'dashboard.tpl');

}else{

    redirect('home');

}

