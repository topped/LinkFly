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

$pid = 9;

if($member_data && $current_permission['permissions_can_advertise']) {

    if(empty($_POST) == false){

        if(isset($_POST['campaign_id']) == false){

            $campaign_name = $_POST['campaign_name'];
            $daily_budget = $_POST['daily_budget'];
            $ad_type = $_POST['ad_type'];
            $website_name = $_POST['website_name'];
            $website_url = $_POST['website_url'];
            $terms = $_POST['terms'];
            $disclaimer = $_POST['disclaimer'];
            $rate = isset($_POST['rate']) ? $_POST['rate'] : false;
            $quantity = $_POST['quantity'];
            $traffic_source = $_POST['traffic_source'];
            $csrf_token = $_POST['csrf_token'];

            $errors = array();

            if(validate_csrf($csrf_token) == false)
                $errors[] = $langs[339];

            if (strlen($campaign_name) < 5)
                $errors[] = $langs[258];

            if (!is_numeric($daily_budget))
                $errors[] = $langs[259];

            if ($daily_budget < get_setting('min_daily_budget'))
                $errors[] = sprintf($langs[260], get_setting('min_daily_budget'), get_setting('site_curr'));

            if (strlen($website_name) < 5)
                $errors[] = $langs[261];

            if (!filter_var($website_url, FILTER_VALIDATE_URL))
                $errors[] = $langs[262];

            if (!$rate)
                $errors[] = $langs[278];

            if (!is_numeric($quantity))
                $errors[] = $langs[279];

            if ($quantity < get_setting('min_quantity_views'))
                $errors[] = sprintf($langs[280], get_setting('min_quantity_views') * 1000);

            if ($quantity > get_setting('max_quantity_views'))
                $errors[] = sprintf($langs[281], get_setting('max_quantity_views') * 1000);

            if ($traffic_source < 0 || $traffic_source > 2)
                $errors[] = $langs[263];

            if ($disclaimer == "off" || $terms == "off") {
                $errors[] = $langs[282];
            }

            if (empty($errors)) {

                $campaign_data = array();

                $rate = get_rate($rate);
                $final_price = $rate['rates_cpm'] * $quantity;

                $campaign_data['campaigns_name'] = strip_tags($campaign_name);
                $campaign_data['campaigns_website_name'] = strip_tags($website_name);
                $campaign_data['campaigns_website_url'] = $website_url;
                $campaign_data['campaigns_daily_budget'] = $daily_budget;
                $campaign_data['campaigns_rates_id'] = $rate['rates_id'];
                $campaign_data['campaigns_ordered_views'] = $quantity;
                $campaign_data['campaigns_current_budget'] = $final_price;
                $campaign_data['campaigns_type'] = $ad_type;
                $campaign_data['campaigns_device'] = $traffic_source;
                $campaign_data['campaigns_payment_accepted'] = 0;

                $campaign_id = insert_campaign($campaign_data);

                $template->assign('campaign_id', $campaign_id);

                if ($campaign_id) {

                    $item_name = $langs[57] . ' \'' . $campaign_data['campaigns_name'] . '\' ' . $campaign_data['campaigns_ordered_views'] . 'k ' . $langs[90];
                    $custom = $campaign_id . '|' . $member_data['members_id'];

                    $tid = insert_transaction(1, $campaign_id, 0, $final_price, get_setting('site_curr'), $item_name, 0);

                    redirect(get_setting('base_url') . 'payment_page?id=' . $campaign_id . '&tid=' . $tid);

                }

            } else {

                $template->assign('errors', $errors);

            }
        }

    }

    $template->assign(PAGE_TITLE, $langs[30]);
    $template->assign(PAGE_ID, $pid);

    $template->assign('rates', get_rates());

    /* Rendering template */

    $template->display($current_template . 'add_campaign.tpl');

}else{

    redirect('home');

}