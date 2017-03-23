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

$pid = 19;

if($member_data) {

    /* Viewing individual link statistics */

    if(isset( $_GET['link_id'])) {

        $link_id = $_GET['link_id'];
        $link_data = get_link($link_id);

        if($link_data) {
            if ($link_data['links_members_id'] == $member_data['members_id'] || $member_data['members_admin']) {

                $template->assign(PAGE_TITLE, $langs[56]);
                $template->assign(PAGE_ID, $pid);

                $m = isset($_GET['m']) ? $_GET['m'] : date('n');
                $y = isset($_GET['y']) ? $_GET['y'] : date('Y');

                $template->assign('curr_month', date('F'));

                $template->assign('months', get_months());
                $template->assign('years', get_years());

                $template->assign('m', $m);
                $template->assign('y', $y);

                $template->assign('top_countries', get_top_countries_link($link_id));
                $template->assign('top_refs', get_top_referrals_link($link_id));

                $template->assign('chart_code', generate_chart_code($m, $y, $link_id));

                $template->assign('link_data', $link_data);

                /* Rendering template */

                $template->display($current_template . 'view_statistics.tpl');

            } else {

                show_404();

            }
        }else{

            show_404();
        }

    }else{

        show_404();
    }


}else{

    redirect('home');

}