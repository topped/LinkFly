<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/**
 * Shortens a long URL. Factors that can be changed include the domain, ad type, and the alias
 *
 * @param $long_url
 * @param int $domain_id
 * @param int $ad_type
 * @param bool $alias
 * @return bool|string
 */
function create_short_url($long_url, $domain_id = 0, $ad_type = 0, $alias = false){

    global $member_data;

    $member_id = $member_data['members_id'];

    if($member_data == false)
        $member_id = 0;

    /* Check if the domain is allowed */

    $disallowed_domains = explode(',', get_setting('disallowed_domains'));

    $host = parse_url($long_url)['host'];

    if(in_array($host, $disallowed_domains))
        return false;

    /* Getting the default domain in case a different domain wasn't specified */

    $domain = get_setting('base_url');

    /* The default domain ID is always 0 and gets pulled from the settings, but if it is a different domain, we look it up here */
    if(!$domain_id == 0)
        $domain = get_domain($domain_id)['domains_url'];

    /* Inserting the link into the DB */

    $link_id = insert_link($long_url, $member_id, $ad_type);

    if($link_id){

        if($alias == false) {

            /* Successfully inserted, now time to get unique short url */
            $suffix_length = get_setting('suffix_length');

            /* Generating a random suffix based on setting's length and microtime */
            $suffix = substr(rtrim(base64_encode(md5(microtime().$link_id)),"="), 0, $suffix_length);

        }else{

            $suffix = $alias;

        }

        $short_url = $domain . $suffix;

        if(update_short_url($link_id, $suffix, $short_url))
            return $short_url;

    }

    return false;

}

/**
 * Checks if the IP is on the banned list
 *
 * @param $ip
 * @return bool
 */
function check_if_banned_ip($ip){

    $banned_ips_text = get_setting('banned_ips');
    $banned_ips = explode(PHP_EOL, $banned_ips_text);

    foreach($banned_ips as $banned_ip){
        if($banned_ip == $ip)
            return true;
    }

    return false;

}

/**
 * Updates a short URL's suffix and short URL using the link ID
 *
 * @param $link_id
 * @param $suffix
 * @param $short_url
 * @return bool
 */
function update_short_url($link_id, $suffix, $short_url){

    global $database;

    try {

        $rs = $database->Execute('select * from links where links_id = ' . $link_id);

        $link = array();

        $link['links_suffix'] = $suffix;
        $link['links_short'] = $short_url;

        $updateSQL = $database->GetUpdateSQL($rs, $link);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates a link status based on the $link_id
 *
 * @param $link_id
 * @param $status
 * @return bool
 */
function change_link_status($link_id, $status){

    global $database;

    try {

        $rs = $database->Execute('select * from links where links_id = ' . make_safe($link_id));

        $link = array();

        $link['links_enabled'] = $status;

        $updateSQL = $database->GetUpdateSQL($rs, $link);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates link profit based on the $link_id
 *
 * @param $link_id
 * @param $campaign_data
 * @return bool
 */
function update_link_profit($link_id, $campaign_data){

    if($campaign_data){

        $ad_type = $campaign_data['campaigns_type'];

        if($ad_type == 0){

            $percentage = get_setting('interstitial_ad_percentage');

        }elseif($ad_type == 1){

            $percentage = get_setting('banner_ad_percentage');

        }

        /* How much the publisher then gets */

        $profit = ($percentage / 100 * ($campaign_data['rates_cpm'] / 1000));

        global $database;

        try {

            $rs = $database->Execute('select * from links where links_enabled = 1 and links_id = ' . make_safe($link_id));

            $link = array();
            $link_data = get_link($link_id);

            $link['links_profit'] = $link_data['links_profit'] + $profit;

            $updateSQL = $database->GetUpdateSQL($rs, $link);
            $database->Execute($updateSQL);

            update_member_balance($link_data['links_members_id'], $profit);

            return true;

        } catch (exception $e) {

            error_log($e);

            return false;

        }

    }

    return false;

}

/**
 * Inserts a link using the long URL, member ID and ad type
 *
 * @param $long_url
 * @param $member_id
 * @param $ad_type
 * @return bool
 */
function insert_link($long_url, $member_id, $ad_type){

    global $database;

    try {

        $rs = $database->Execute('select * from links where links_id = -1');

        $link = array();

        $link['links_long_url'] = $long_url;
        $link['links_ad_type'] = $ad_type;
        $link['links_members_id'] = $member_id;

        $link['links_ip'] = get_ip();

        $insertSQL = $database->GetInsertSQL($rs, $link);
        $database->Execute($insertSQL);

        return $database->Insert_ID();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets a members top referrals based on $member_id
 *
 * @param $member_id
 * @return bool
 */
function get_top_referrals($member_id){

    $sql = 'select views_referral, count(*) as occurences from views left join links ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_members_id = ' . make_safe($member_id) . ' group by views.views_referral order by occurences desc limit 10';
    return get_rows($sql);

}

/**
 * Gets top referrals for a link based on $link_id
 *
 * @param $link_id
 * @return bool
 */
function get_top_referrals_link($link_id){

    $sql = 'select views_referral, count(*) as occurences from views left join links ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_id = ' . make_safe($link_id) . ' group by views.views_referral order by occurences desc limit 10';
    return get_rows($sql);

}

/**
 * Gets a members top countries based on $member_id
 *
 * @param $member_id
 * @return bool
 */
function get_top_countries($member_id){

    $sql = 'select views_country, count(*) as occurences, sum(distinct links.links_profit) as profit from views left join links ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_members_id = ' . make_safe($member_id) . ' group by views.views_country order by occurences desc limit 10';
    return get_rows($sql);

}

/**
 * Gets top countries for a link based on $link_id
 *
 * @param $link_id
 * @return bool
 */
function get_top_countries_link($link_id){

    $sql = 'select views_country, count(*) as occurences, sum(distinct links.links_profit) as profit from views left join links ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_id = ' . make_safe($link_id) . ' group by views.views_country order by occurences desc limit 10';
    return get_rows($sql);

}

/**
 * Gets total earnings for a member based on $member_id
 *
 * @param $member_id
 * @return mixed
 */
function get_total_earnings($member_id){

    $sql = 'select sum(links_profit) as TotalEarnings from links where links_enabled = 1 and links_members_id = ' . make_safe($member_id);
    return fetch_row($sql)['TotalEarnings'];

}

/**
 * Gets total earnings for the statistics
 *
 * @return bool
 */
function get_total_earnings_stat(){

    $sql = 'select sum(links_profit) as TotalEarnings from links';
    return fetch_row($sql)['TotalEarnings'];

}

/**
 * Registers a view based on the link and the campaign
 *
 * @param $link_id
 * @param $campaign_data
 * @return bool
 */
function register_view($link_id, $campaign_data){

    global $database;

    try {

        $rs = $database->Execute('select * from views where views_link_id = ' . make_safe($link_id) . ' and views_ip = ' . make_safe(get_ip()));

        if($rs->RowCount() == 0){

            $view = array();

            $refer = isset($_SERVER["HTTP_REFERER"]) ? $_SERVER["HTTP_REFERER"] : null;

            $view['views_link_id'] = $link_id;
            $view['views_ip'] = get_ip();
            $view['views_date'] = date('Y-m-d');
            $view['views_campaign_id'] = $campaign_data['campaigns_id'];
            $view['views_country'] = get_country(get_ip());

            if($refer)
                $view['views_referral'] = $refer;

            $device = 1;

            if(is_mobile())
                $device = 2;

            $view['views_mobile_device'] = $device;

            $insertSQL = $database->GetInsertSQL($rs, $view);

            $database->Execute($insertSQL);

            return true;
        }

        return false;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets IP for current visitor
 *
 * @return $ip
 */
function get_ip(){

    $ip = null;

    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {

        $ip = $_SERVER['HTTP_CLIENT_IP'];

    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {

        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];

    } else {
        $ip = $_SERVER['REMOTE_ADDR'];
    }

    return $ip;

}

/**
 * Deletes a link based on $link_id
 *
 * @param $link_id
 * @return bool
 */
function delete_link($link_id){

    $sql = 'delete from links where links_id = ' . make_safe($link_id);
    return delete_row($sql);
}

/**
 * Gets specific link by ID and additional SQL queries
 *
 * @param $id
 * @param null $additional
 * @return bool
 */
function get_link($id, $additional = null)
{

    $sql = 'select *, count(distinct views.views_id) as ViewCount from links left join views ON views.views_link_id = links.links_id where links.links_enabled = 1 and links_id = ' . make_safe($id) . ' ' . $additional;
    return fetch_row($sql);

}

/**
 * Generates the data for the chart.js chart
 *
 * @param $month
 * @param $year
 * @param null $link_id
 * @param bool $for_campaigns
 * @return mixedg
 */
function generate_chart_code($month, $year, $link_id = null, $for_campaigns = false){

    global $member_data;

    $labels = null;

    /* Generating the y-axis labels. Represents the days in the current month */

    $days_in_month = date('t', strtotime($year . "-" . $month . "-1"));
    $month_name = date('M', strtotime($year . "-" . $month . "-1"));

    for($i = 1; $i <= $days_in_month; $i++)
        $labels[] = $month_name . ' ' . $i;

    $data = array();

    /* For every day, we check how many views there were in total for all links - this isn't super pretty, I apologize */

    for($i = 1; $i <= $days_in_month; $i++) {

        $date = strtotime($year . "-" . date('m', strtotime($year . "-" . $month . "-1")) . "-" . str_pad($i, 2, '0', STR_PAD_LEFT));

        if($link_id == null) {
            if($for_campaigns){
                $date_views = get_view_count_campaign($member_data['members_id'], date('Y-m-d', $date));
            }else {
                $date_views = get_view_count($member_data['members_id'], date('Y-m-d', $date));
            }
        }else{
            $date_views = get_view_count_link($link_id, date('Y-m-d', $date));
        }

        $data[] = $date_views;

    }

    $chart = array( "labels" => $labels, "datasets" => array(array("data" => $data, "fillColor" => get_setting('graph_fill_color'), "strokeColor" => get_setting('graph_stroke_color') )) );

    return preg_replace('/"([a-zA-Z]+[a-zA-Z0-9_]*)":/','$1:',json_encode($chart));

}

/**
 * Gets the link view count for a specific member and date
 *
 * @param $member_id
 * @param $date
 * @return mixed
 */
function get_view_count($member_id, $date) {

    $sql = 'select * from views left join links ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_members_id = ' . make_safe($member_id) . ' and DATE(views.views_date) = date(\'' . $date . '\')';
    return record_count($sql);

}

/**
 * Gets the view count for a specific link on a specific date
 *
 * @param $link_id
 * @param $date
 * @return mixed
 */
function get_view_count_link($link_id, $date) {

    $sql = 'select * from views left join links ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_id = ' . make_safe($link_id) . ' and DATE(views.views_date) = date(\'' . $date . '\')';
    return record_count($sql);

}

/**
 * Gets the total view count for a specific member based on the $member_id
 *
 * @param $member_id
 * @return bool
 */
function get_total_view_count($member_id) {

    $sql = 'select * from views left join links ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_members_id = ' . make_safe($member_id);
    return record_count($sql);

}

/**
 * Gets all the links from a specific member
 *
 * @param $member_id
 * @return bool
 */
function get_links_member($member_id) {

    $sql = 'select *, count(distinct views.views_id) as ViewCount from links left join views ON views.views_link_id = links.links_id where links.links_enabled = 1 and links.links_members_id = ' . make_safe($member_id) . ' group by links.links_added DESC';
    return get_rows($sql);

}

/**
 * Gets all the links for the admin  panel
 *
 * @return mixed
 */
function get_admin_links() {

    $sql = 'select *, count(distinct views.views_id) as ViewCount from links left join views ON views.views_link_id = links.links_id left join members ON members.members_id = links.links_members_id group by links.links_added DESC';
    return get_rows($sql);

}

/**
 * Gets the total link count in the database
 *
 * @return bool
 */
function get_all_link_count(){

    $sql = 'select * from links';
    return record_count($sql);

}

/**
 * Gets the total view count for everything
 * @return bool
 */
function get_all_view_count(){

    $sql = 'select * from views';
    return record_count($sql);

}

/**
 * Gets the link based on the given $ip
 *
 * @param $ip
 * @return bool
 */
function get_link_ip($ip){

    $sql = 'select * from links where links_ip = ' . make_safe($ip) . ' order by links_added desc limit 1';
    return fetch_row($sql);

}

/**
 * Checks if an alias exists
 *
 * @param $alias
 * @return bool
 */
function exist_alias($alias){

    global $database;

    try {

        $rs = $database->Execute('select * from links where links_suffix = '. make_safe($alias));

        if($rs->RecordCount() > 0)
            return true;

        return false;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets a link based on the suffix
 *
 * @param $suffix
 * @return bool
 */
function get_link_suffix($suffix)
{

    $sql = 'select * from links where links_enabled = 1 and links_suffix = ' . make_safe($suffix);
    return fetch_row($sql);

}