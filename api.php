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

define('IS_AJAX', isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest');

/* Ensure it is an AJAX request */

if(IS_AJAX) {

    if (!isset($_POST['suffix'])) {

        /* Shortening URL */

        if (isset($_POST['long_url']) && $current_permission['permissions_can_shorten']) {

            $long_url = $_POST['long_url'];

            $domain_id = 0;
            $ad_type = 0;
            $alias = false;

            if (filter_var($long_url, FILTER_VALIDATE_URL)) {

                $spam_diff = $current_permission['permissions_spam_waiting_time'];

                if ($spam_diff != 0) {

                    $last_link = get_link_ip(get_ip());

                    /* Spam prevention */

                    if ($last_link) {

                        $timestamp = strtotime($last_link['links_added']);
                        $difference = time() - $timestamp;

                        if ($difference <= $spam_diff)
                            json_error(sprintf($langs[336], $spam_diff - $difference++));

                    }
                }

                if ($member_data == false && get_setting('anon_link_captcha') == true || $current_permission['permissions_need_captcha']) {
                    $securimage = new Securimage();

                    if ($securimage->check($_POST['captcha']) == false)
                        json_error($langs[257]);

                }

                /* Selecting domains */

                if (isset($_POST['domain'])) {

                    if ($_POST['domain'] != 0) {

                        $domain = get_domain($_POST['domain']);

                        if ($current_permission['permissions_change_domain'] == false)
                            json_error($langs[20]);

                        if ($domain == false)
                            json_error($langs[189]);

                        $domain_id = $_POST['domain'];

                    }

                }

                /* Setting ad types and validating them */

                if (isset($_POST['ad_type'])) {

                    if ($current_permission['permissions_change_ad_type'] == false)
                        json_error($langs[20]);

                    if (!in_array($_POST['ad_type'], array(0, 1, 2)))
                        json_error($langs[188]);

                    $ad_type = $_POST['ad_type'];

                }

                if (isset($_POST['alias']) && empty($_POST['alias']) == false) {

                    if ($current_permission['permissions_custom_alias'] == false)
                        json_error($langs[20]);

                    if (strlen($_POST['alias']) < get_setting('custom_alias_min_length'))
                        json_error(sprintf($langs[317], get_setting('custom_alias_min_length')));

                    if (strlen($_POST['alias']) > get_setting('custom_alias_max_length'))
                        json_error(sprintf($langs[318], get_setting('custom_alias_max_length')));

                    if (!ctype_alpha($_POST['alias']))
                        json_error($langs[319]);

                    if (exist_alias($_POST['alias']))
                        json_error($langs[320]);

                    //In case some user is trying to steal passwords or similar
                    $disallowed_aliases = array('home', 'dashboard', 'advertiser', 'add_campaign', 'edit_campaign', 'stats', 'login', 'logout', 'withdrawals', 'register', 'report', 'contact', 'payment_page', 'forgot_password', 'my_account', 'signup', 'signin', 'create', 'createaccount', 'account', 'view' , 'password', 'passwords', 'settings', 'setting');

                    if (in_array($_POST['alias'], $disallowed_aliases))
                        json_error($langs[321]);

                    $alias = $_POST['alias'];

                }

                $short_url = create_short_url($long_url, $domain_id, $ad_type, $alias);

                if ($short_url != false) {

                    http_response_code(200);
                    header('Content-type: application/json');

                    echo json_encode(array('error' => false, 'short_url' => $short_url));

                } else {
                    json_error($langs[309]);
                }

            } else {
                json_error($langs[308]);
            }
        } else {
            json_error();
        }

    } else {

        $pos = strpos($_SERVER['HTTP_REFERER'],getenv('HTTP_HOST'));

        if($pos === false)
            json_error('Unknown suffix resolve request');

        if (isset($_SERVER["HTTP_X_FORWARDED_FOR"]) && get_setting('disallow_proxies'))
            json_error($langs[323]);

        $suffix = $_POST['suffix'];

        $link_data = get_link_suffix($suffix);

        if ($link_data)
            echo json_encode(array('long_url' => $link_data['links_long_url']));

    }
}else{

     json_error();

}

/* Very simple error message that outputs a 500 HTTP response code */

function json_error($msg = 'Unknown error'){

    http_response_code(500);
    header('Content-type: application/json');

    die(json_encode(array('error' => true, 'msg' => $msg)));

}