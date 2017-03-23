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

$pid = 2;

/* Viewing a link/presenting ads */

$suffix = $_GET['s'];
$link_data = get_link_suffix($suffix);

if($link_data) {

    if($link_data['links_ad_type'] == 2) {

        redirect($link_data['links_long_url']);

    }else{

        /* Finding a suitable campaign */

        $campaign = find_valid_campaign();

        if($campaign == false){

            $fallback_campaign = get_setting('default_campaign');

            if($fallback_campaign != 0)
                $campaign = get_campaign_data($fallback_campaign);

        }

        if($campaign) {

            $count_as_view = true;

            /* If this link belongs to the current member viewing, make sure we don't count it as a view. Same counts for the ip address in case the publisher is trying to logout to count it as a view. */

            if (isset($_SERVER["HTTP_X_FORWARDED_FOR"]) && get_setting('disallow_proxies'))
                $count_as_view = false;

            if(check_if_banned_ip(get_ip()))
                $count_as_view = false;

            if ($member_data)

                if ($member_data['members_id'] == $link_data['links_members_id'] || get_ip() == $link_data['links_ip'])
                    $count_as_view = false;

            if ($count_as_view) {

                register_view($link_data['links_id'], $campaign);

                /* Calculating how much it cost to show the campaign for the advertiser and how much the publisher receives PER VIEW */

                update_used_daily_budget($campaign);

                /* If it was an anonymous link, do not update it */

                if ($link_data['links_members_id'] != 0)
                    update_link_profit($link_data['links_id'], $campaign);

            }

            /* Assign campaign */
            $template->assign('campaign_data', $campaign);

            /* Page ID */

            $template->assign(PAGE_ID, $pid);

            /* Assigning page title */

            $template->assign(PAGE_TITLE, $langs[54]);

            /* Rendering template */

            $template->display($current_template . 'view_link.tpl');

        }else{

            /* This means that no valid ad was found, meaning they all used up their daily budget already or other*/

            redirect($link_data['links_long_url']);

        }

    }

}else{

    show_404();

}