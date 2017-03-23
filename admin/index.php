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

    $admin_pid = 0;

    $template->assign(PAGE_TITLE, 'Admin Panel');
    $template->assign(PAGE_ID, $admin_pid);

    /* Rendering template & basic navigation */

    $members_ten = get_last_ten_members();
    $campaigns_ten = get_last_ten_campaigns();

    $template->assign('last_members', $members_ten);
    $template->assign('last_campaigns', $campaigns_ten);

    /* Statistics */

    $template->assign('total_links', get_all_link_count());
    $template->assign('total_views', get_all_view_count());
    $template->assign('total_earnings', get_total_earnings_stat());
    $template->assign('withdrawals_count', get_withdrawals_count());
    $template->assign('campaigns_count', get_campaigns_count());
    $template->assign('rejected_campaigns', get_total_campaigns_rejected_stat());
    $template->assign('total_campaigns', get_total_campaigns_stat());
    $template->assign('total_withdrawals', get_total_withdrawals_stat());
    $template->assign('total_reports', get_total_withdrawals_stat());
    $template->assign('total_members', get_all_member_count());

    $template->display(ADMIN_TEMPLATE . 'dashboard.tpl');

}else{

    redirect(get_setting('base_url'));

}