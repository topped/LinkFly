<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/**
 * Inserts a transaction and if successful returns the transaction ID
 *
 * @param $object_type
 * @param $object_id
 * @param $gateway
 * @param $value
 * @param $currency
 * @param $item_name
 * @param $status
 * @return bool
 */
function insert_transaction($object_type, $object_id, $gateway, $value, $currency, $item_name, $status){

    global $database;
    global $member_data;

    try {

        $rs = $database->Execute('select * from transactions');

        $transaction_data = array();

        $transaction_data['transactions_object_type'] = $object_type;
        $transaction_data['transactions_object_id'] = $object_id;
        $transaction_data['transactions_gateway'] = $gateway;
        $transaction_data['transactions_value'] = $value;
        $transaction_data['transactions_curr'] = $currency;
        $transaction_data['transactions_item_name'] = $item_name;
        $transaction_data['transactions_status'] = $status;
        $transaction_data['transactions_members_id'] = $member_data['members_id'];

        $insertSQL = $database->GetInsertSQL($rs, $transaction_data);

        $database->Execute($insertSQL);

        return $database->Insert_ID();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets all transactions
 *
 * @return bool
 */
function get_all_transactions(){

    $sql = 'select * from transactions left join members on transactions.transactions_members_id = members.members_id order by transactions_added desc';
    return get_rows($sql);

}

/**
 * Updates the transaction status for a specific $transaction_id
 * 0 = Processing, 1 = Processed, 2 = Failed, 3 = Denied
 *
 * @param $transaction_id
 * @param $value
 * @return bool
 */
function update_transaction_status($transaction_id, $value){

    global $database;

    try {

        $rs = $database->Execute('select * from transactions where transactions_id = ' . make_safe($transaction_id));

        $transaction = array();

        $transaction['transactions_status'] = $value;

        $updateSQL = $database->GetUpdateSQL($rs, $transaction);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates the transactions status for a specific campaign
 *
 * @param $campaign_id
 * @param $value
 * @return bool
 */
function update_transaction_status_campaign($campaign_id, $value){

    global $database;

    try {

        $rs = $database->Execute('select * from transactions where transactions_object_type = 1 and transactions_object_id = ' . make_safe($campaign_id));

        $transaction = array();

        $transaction['transactions_status'] = $value;

        $updateSQL = $database->GetUpdateSQL($rs, $transaction);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets a transaction based on the $tid (transaction ID)
 *
 * @param $tid
 * @return null
 */
function get_transaction($tid){

    $sql = 'select * from transactions where transactions_id = ' . make_safe($tid);
    return fetch_row($sql);

}

/**
 * Gets a transaction by the object ID ($object_id)
 *
 * @param $object_id
 * @return null
 */
function get_transactions_object_id($object_id){

    $sql = 'select * from transactions where transactions_object_id = ' . make_safe($object_id);
    return fetch_row($sql);

}

/**
 * Gets all transactions for a specific member
 *
 * @param $member_id
 * @return null
 */
function get_transactions_member($member_id){

    $sql = 'select * from transactions where transactions_members_id = '. make_safe($member_id);
    return get_rows($sql);

}