<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/**
 * Inserts a withdrawal using $member_id and the given $data
 *
 * @param $member_id
 * @param $data
 * @return bool
 */
function insert_withdrawal($member_id, $data){

    global $database;

    try {

        $rs = $database->Execute('select * from withdrawal_requests');

        $data['withdrawal_requests_member_id'] = $member_id;

        $insertSQL = $database->GetInsertSQL($rs, $data);

        $database->Execute($insertSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets total count of withdrawals that need approval
 *
 * @return bool
 */
function get_withdrawals_count(){

    $sql = 'select * from withdrawal_requests where withdrawal_requests_status = 0';
    return record_count($sql);

}

/**
 * Gets total amount of withdrawal
 *
 * @return mixed
 */
function get_total_withdrawals_stat() {

    $sql = 'select * from withdrawal_requests';
    return record_count($sql);

}

/**
 * Gets withdrawal request based on $withdrawal_request_id
 *
 * @param $withdrawal_request_id
 * @return bool
 */
function get_withdrawal_request($withdrawal_request_id){

    $sql = 'select * from withdrawal_requests where withdrawal_requests_id = ' .  make_safe($withdrawal_request_id);
    return fetch_row($sql);

}

/**
 * Updates withdrawal requests using the ID and $status
 *
 * @param $withdrawal_request_id
 * @param int $status
 * @return bool
 */
function update_withdrawal_request_status($withdrawal_request_id, $status = 0){

    global $database;

    try {

        $rs = $database->Execute('select * from withdrawal_requests where withdrawal_requests_id = ' . make_safe($withdrawal_request_id));

        $withdrawal_request = array();

        $withdrawal_request['withdrawal_requests_status'] = $status;

        $updateSQL = $database->GetUpdateSQL($rs, $withdrawal_request);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets all withdrawal requests for admin panel
 *
 * @return bool
 */
function get_all_withdrawals(){

    $sql = 'select * from withdrawal_requests left join members on withdrawal_requests.withdrawal_requests_member_id = members.members_id order by withdrawal_requests_added desc';
    return get_rows($sql);

}

/**
 * Gets PayPal's MassPay Withdrawals
 *
 * @param $m
 * @param $y
 * @param int $export_type
 * @return bool
 */
function get_masspay_withdrawals($m, $y, $export_type = 1){

    $export_sql = null;

    if($export_type == 0)
           $export_sql = "withdrawal_requests.withdrawal_requests_status = 0 and ";

    $sql = 'select * from withdrawal_requests left join members on withdrawal_requests.withdrawal_requests_member_id = members.members_id where ' . $export_sql . 'year(withdrawal_requests_added) = '.make_safe($y).' and month(withdrawal_requests_added) = '.make_safe($m).' order by withdrawal_requests_added desc';

    return get_rows($sql);

}

/**
 * Get all withdrawals for a specific member based on $member_id
 *
 * @param $member_id
 * @return bool
 */
function get_withdrawals($member_id){

    $sql = 'select * from withdrawal_requests where withdrawal_requests.withdrawal_requests_member_id = ' . make_safe($member_id) . ' order by withdrawal_requests.withdrawal_requests_added DESC';
    return get_rows($sql);

}