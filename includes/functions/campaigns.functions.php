<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/**
 * Finds a valid campaign based on a multitude of factors, such as campaign age, funds, rate, location, device, etc...
 *
 * @return bool
 */
function find_valid_campaign(){

   /* Do location check to match with the campaign's rates if it has a specified location */

    $location = get_country(get_ip());
    $is_mobile = is_mobile();

    $device = 1;

    if($is_mobile)
        $device = 2;

    $sql = 'select *, count(distinct views.views_id) as ViewCount from campaigns left join views ON views.views_campaign_id = campaigns.campaigns_id left join rates on rates.rates_id = campaigns.campaigns_rates_id where campaigns.campaigns_budget_used_today < campaigns.campaigns_daily_budget and campaigns.campaigns_current_budget > 0 and campaigns.campaigns_approved = 1 and campaigns.campaigns_status = 0 and campaigns.campaigns_payment_accepted = 1 and campaigns_device = ' . $device . ' or campaigns.campaigns_device = 0 and rates_location = ' . make_safe($location) . ' or rates.rates_location IS NULL group by campaigns.campaigns_daily_budget having ViewCount <= campaigns.campaigns_ordered_views * 1000 order by campaigns.campaigns_daily_budget asc';
die($sql);
    return fetch_row($sql);

}

/**
 * Takes data for new rates and inserts it
 *
 * @param $rate_data
 * @return bool
 */
function insert_rate($rate_data){

    global $database;

    try {

        $rs = $database->Execute('select * from rates where rates_id = -1');

        $insertSQL = $database->GetInsertSQL($rs, $rate_data);
        $database->Execute($insertSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Changes the given campaign based on the $campaign_id to the given $status
 * Statuses: 0 = Running, 1 = Stopped, 2 = Ended
 *
 * @param $campaign_id
 * @param $status
 * @return bool
 */
function change_campaign_status($campaign_id, $status){

    global $database;

    try {

        $rs = $database->Execute('select * from campaigns where campaigns_id = ' . make_safe($campaign_id));

        $campaign = array();

        $campaign['campaigns_approved'] = $status;

        $updateSQL = $database->GetUpdateSQL($rs, $campaign);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates a campaign based on $campaign_id using $update_data
 *
 * @param $campaign_id
 * @param $update_data
 * @return bool
 */
function update_campaign($campaign_id, $update_data){

    global $database;

    try {

        $rs = $database->Execute('select * from campaigns where campaigns_id = ' . make_safe($campaign_id));

        $updateSQL = $database->GetUpdateSQL($rs, $update_data);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates a campaign's payment_status based on $value
 * 0 = Processing, 1 = Processed
 *
 * @param $campaign_id
 * @param $value
 * @return bool
 */
function update_payment_status($campaign_id, $value){

    global $database;

    try {

        $rs = $database->Execute('select * from campaigns where campaigns_id = ' . make_safe($campaign_id));

        $campaign = array();

        $campaign['campaigns_payment_accepted'] = $value;

        $updateSQL = $database->GetUpdateSQL($rs, $campaign);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates the used daily budget using the last_budget_reset time in the last 24 hours
 *
 * @param $campaign_data
 * @return bool
 */
function update_used_daily_budget($campaign_data){

    global $database;

    try {

        $rs = $database->Execute('select * from campaigns where campaigns_id = ' . make_safe($campaign_data['campaigns_id']));

        $last_reset = strtotime($campaign_data['campaigns_last_budget_reset']);
        $day_ago = strtotime("-24 hours");

        $campaign = array();

        $cost = get_cost_per_view($campaign_data);

        if($last_reset <= $day_ago){
            $campaign['campaigns_last_budget_reset'] = date('Y-m-d H:i:s');
            $campaign['campaigns_budget_used_today'] = $cost;
        }else {
            $campaign['campaigns_budget_used_today'] = $campaign_data['campaigns_budget_used_today'] + $cost;
        }

        $campaign['campaigns_current_budget'] = $campaign_data['campaigns_current_budget'] - $cost;

        $updateSQL = $database->GetUpdateSQL($rs, $campaign);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets Cost Per View (not CPM) based on $campaign_data
 *
 * @param $campaign_data
 * @return float
 */
function get_cost_per_view($campaign_data){

    $rates_cpm = $campaign_data['rates_cpm'];
    return $rates_cpm / 1000;

}

/**
 * Gets all campaigns
 *
 * @return bool
 */
function get_campaigns() {

    $sql = 'select * from campaigns left join members on campaigns.campaigns_members_id = members.members_id left join rates on campaigns.campaigns_rates_id = rates.rates_id';
    return get_rows($sql);
}

/**
 * Gets all campaigns for a member based on $member_id
 *
 * @param $member_id
 * @return bool
 */
function get_campaigns_member($member_id) {

    $sql = 'select *, count(distinct views.views_id) as ViewCount from campaigns left join views ON views.views_campaign_id = campaigns.campaigns_id left join rates on rates.rates_id = campaigns.campaigns_rates_id where campaigns.campaigns_members_id = ' . make_safe($member_id) . ' group by campaigns.campaigns_started DESC';

    $rows = get_rows($sql);

    foreach ($rows as $row) {
        if ($row['campaigns_current_budget'] == 0) {

            $data = array();
            $data['campaigns_status'] = 2;

            update_campaign($row['campaigns_id'], $data);
        }

    }

    return $rows;

}

/**
 * Insert a report using the giben report data and returns the ID if successful
 *
 * @param $report_data
 * @return bool
 */
function insert_report($report_data){

    global $database;

    global $member_data;

    try {

        $rs = $database->Execute('select * from reports');

        $insertSQL = $database->GetInsertSQL($rs, $report_data);

        $database->Execute($insertSQL);

        return $database->Insert_ID();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets all contact requests
 *
 * @return bool
 */
function get_all_contacts() {

    $sql = 'select * from contacts left join members on members.members_id = contacts.contacts_members_id group by contacts_added desc';
    return get_rows($sql);

}

/**
 * Gets all reports
 *
 * @return bool
 */
function get_all_reports() {

    $sql = 'select * from reports';
    return get_rows($sql);

}

/**
 * Inserts a campaign and returns the ID of the new campaign if successfully inserted
 *
 * @param $campaign_data
 * @return bool
 */
function insert_campaign($campaign_data){

    global $database;

    global $member_data;

    try {

        $rs = $database->Execute('select * from campaigns');

        $campaign_data['campaigns_approved'] = 0;

        if(get_setting('campaigns_need_approval') == false){
            $campaign_data['campaigns_approved'] = 1;
        }

        $campaign_data['campaigns_status'] = 0;
        $campaign_data['campaigns_members_id'] = $member_data['members_id'];
        $campaign_data['campaigns_last_budget_reset'] = date('Y-m-d H:i:s');

        $insertSQL = $database->GetInsertSQL($rs, $campaign_data);

        $database->Execute($insertSQL);

        return $database->Insert_ID();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets the top referrals for all campaigns for a member
 *
 * @param $member_id
 * @return bool
 */
function get_top_referrals_campaigns($member_id){

    $sql = 'select views_referral, count(*) as occurences from views left join campaigns ON campaigns.campaigns_id = views.views_campaign_id where campaigns.campaigns_members_id = ' . make_safe($member_id) . ' group by views.views_referral order by occurences desc limit 10';
    return get_rows($sql);
}

/**
 * Gets the top devices for all campaigns for a member
 *
 * @param $member_id
 * @return bool
 */
function get_top_devices_campaigns($member_id){

    $sql = 'select views_mobile_device, count(*) as occurences from views left join campaigns ON campaigns.campaigns_id = views.views_campaign_id where campaigns.campaigns_members_id = ' . make_safe($member_id) . ' group by views.views_mobile_device order by occurences desc limit 3';
    return get_rows($sql);

}

/**
 * Gets the top countries for all campaigns for a member
 *
 * @param $member_id
 * @return bool
 */
function get_top_countries_campaigns($member_id){

    $sql = 'select views_country, count(*) as occurences from views left join campaigns ON campaigns.campaigns_id = views.views_campaign_id where campaigns.campaigns_members_id = ' . make_safe($member_id) . ' group by views.views_country order by occurences desc limit 10';
    return get_rows($sql);

}

/**
 * Gets the view count for all campaigns for a specific member on a specific date
 *
 * @param $member_id
 * @param $date
 * @return bool
 */
function get_view_count_campaign($member_id, $date) {

    $sql = 'select * from views left join campaigns ON campaigns.campaigns_id = views.views_campaign_id where campaigns.campaigns_members_id = ' . make_safe($member_id) . ' and DATE(views.views_date) = date(' . make_safe($date) . ')';
    return record_count($sql);
}

/**
 * Gets all rates
 *
 * @return bool
 */
function get_rates(){

    $sql = 'select * from rates order by rates.rates_name asc';
    return get_rows($sql);

}

/**
 * Updates a rate based on $rate_id using $update_data
 *
 * @param $rate_id
 * @param $update_data
 * @return bool
 */
function update_rate($rate_id, $update_data){

    global $database;

    try {

        $rs = $database->Execute('select * from rates where rates_id = ' . make_safe($rate_id));

        $updateSQL = $database->GetUpdateSQL($rs, $update_data);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets the total amount of campaigns that are NOT approved
 *
 * @return bool
 */
function get_campaigns_count(){

    $sql = 'select * from campaigns where campaigns_approved = 0';
    return record_count($sql);

}

/**
 * Gets a specific rate based on $rate_id
 *
 * @param $rate_id
 * @return bool
 */
function get_rate($rate_id){

    $sql = 'select * from rates where rates_id = ' . make_safe($rate_id);
    return fetch_row($sql);

}

/**
 * Deletes the given report based on $report_id
 *
 * @param $report_id
 * @return bool
 */
function delete_report($report_id){

    $sql = 'delete from reports where reports_id = ' . make_safe($report_id);
    return delete_row($sql);

}

/**
 * Deletes the given contact based on $contact_id
 *
 * @param $contact_id
 * @return bool
 */
function delete_contact($contact_id){

    $sql = 'delete from contacts where contacts_id = ' . make_safe($contact_id);
    return delete_row($sql);

}

/**
 * Gets total ten last campaigns for the admin panel
 *
 * @return bool
 */
function get_last_ten_campaigns(){

    $sql = 'select campaigns.campaigns_name, campaigns.campaigns_started from campaigns order by campaigns.campaigns_started desc limit 10';
    return get_rows($sql);

}

/**
 * Gets the statistics for the total amount of campaigns in the database
 *
 * @return bool
 */
function get_total_campaigns_stat() {

    $sql = 'select * from campaigns';
    return record_count($sql);

}

/**
 * Gets the statistics for the total amount of REJECTED campaigns in the database
 *
 * @return bool
 */
function get_total_campaigns_rejected_stat() {

    $sql = 'select * from campaigns where campaigns_approved = 2';
    return record_count($sql);

}

/**
 * Gets the total amount of reports in the database
 *
 * @return bool
 */
function get_total_reports_stat() {

    $sql = 'select * from reports';
    return record_count($sql);

}

/**
 * Gets the campaign based on $campaign_id
 *
 * @param $campaign_id
 * @return bool
 */
function get_campaign_data($campaign_id){

    $sql = 'select * from campaigns left join rates on rates.rates_id = campaigns.campaigns_rates_id where campaigns_id = ' . make_safe($campaign_id);
    return fetch_row($sql);

}

/**
 * Deletes the given campaign based on $campaign_id
 *
 * @param $campaign_id
 * @return bool
 */
function delete_campaign($campaign_id){

    $sql = 'delete from campaigns where campaigns_id = ' . make_safe($campaign_id);
    return delete_row($sql);

}

/**
 * Deletes the given rate using the $rate_id
 *
 * @param $rate_id
 * @return bool
 */
function delete_rate($rate_id){

    $sql = 'delete from rates where rates_id = ' . make_safe($rate_id);
    return delete_row($sql);

}