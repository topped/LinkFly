<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once LIBS_DIR . 'Mobile_Detect/Mobile_Detect.php';

global $template;

$member_data = false;

if(isset($_SESSION['members_id']))
    $member_data = get_member($_SESSION['members_id']);

/* Validates user and sets session */

/**
 * Validates a user by username and password
 *
 * @param $username
 * @param $password
 * @return bool
 */
function validate_user($username, $password){

    global $database;

    try {

        $password_hash = hash('sha256', $password);

        $rs = $database->Execute('select * from members where members_status = 1 and members_username = '. make_safe($username) .' and members_password = ' . make_safe($password_hash));

        $records_count = $rs->RowCount();

        if($records_count == 1) {

            $members_id = $rs->FetchRow()['members_id'];
            $csrf_token = md5(uniqid(rand(), true));

            set_session($members_id, $username, $csrf_token);

            return true;
        }

        return false;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Sets the $_SESSION variable for a user when logged in
 *
 * @param $member_id
 * @param $member_username
 */
function set_session($member_id, $member_username, $csrf_token){

    $_SESSION['members_id'] = $member_id;
    $_SESSION['members_username'] = $member_username;
    $_SESSION['csrf_token'] = $csrf_token;

}

/**
 * Destroys the session, e.g. logs user out
 */
function destroy_session(){

    // remove all session variables
    session_unset();

    // destroy the session
    session_destroy();

}

/**
 * Checks if $username is unique in the database
 *
 * @param $username
 * @return bool
 */
function unique_username($username){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_username = ' . make_safe($username));

        if($rs->RecordCount() == 0)
            return true;

        return false;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Validates CSRF
 *
 * @param $token
 * @return bool
 */
function validate_csrf($token){

    if(isset($_SESSION['csrf_token'])){

        if($token == $_SESSION['csrf_token'])
            return true;

    }

    return false;

}

/**
 * Checks if $email is unique in the database
 *
 * @param $email
 * @return bool
 */
function unique_email($email){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_email = ' . make_safe($email));

        if($rs->RecordCount() == 0)
            return true;

        return false;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets member data from $id
 *
 * @param $id
 * @return bool
 */
function get_member($id){

    $sql = 'select * from members where members_id = ' . make_safe($id);
    return fetch_row($sql);

}

/**
 * Gets the total member count
 *
 * @return bool
 */
function get_all_member_count(){

    $sql = 'select * from members';
    return record_count($sql);

}

/**
 * Gets the country of the IP using an external service
 * Do note however that ipinfo limits us to a 1000 API requests a day.
 * If you have a lot of visitors and note a lot of Unknown country locations,
 * we suggest you purchase ipinfo's premium plan or look for a different service.
 * You will have to implement that yourself, however.
 *
 * @param $ip
 * @return bool
 */
function get_country($ip){

    $details = json_decode(file_get_contents("http://ipinfo.io/{$ip}/json"));

    if(isset($details->country))
        return $details->country;

    return false;
}

/**
 * Checks if user is on a mobile device
 *
 * @return bool
 */
function is_mobile(){

    $detect = new Mobile_Detect;

    return $detect->isMobile();

}

/**
 * Get member from $email_code
 *
 * @param $email_code
 * @return bool
 */
function get_member_email_code($email_code){

    $sql = 'select * from members where members_email_code = ' . make_safe($email_code);
    return fetch_row($sql);

}

/**
 * Gets member from $api_key
 *
 * @param $api_key
 * @return bool
 */
function get_member_api_key($api_key){

    $sql = 'select * from members where members_api_key = ' . make_safe($api_key);
    return fetch_row($sql);

}

/**
 * Inserts member using $member_data
 *
 * @param $member_data
 * @return bool
 */
function insert_member($member_data){

    global $database;

    global $member_data;

    try {

        $rs = $database->Execute('select * from members limit 1');

        $insertSQL = $database->GetInsertSQL($rs, $member_data);

        $database->Execute($insertSQL);

        return $database->Insert_ID();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates member's balance using $member_id, $value. Can also subtract using $add
 *
 * @param $member_id
 * @param $value
 * @param bool $add
 * @return bool
 */
function update_member_balance($member_id, $value, $add = true)
{
    global $database;

    try {

        $member_data = get_member($member_id);
        $rs = $database->Execute('select * from members where members_id = ' . make_safe($member_id));

        $member = array();

        if($add) {
            $member['members_balance'] = $member_data['members_balance'] + $value;
        }else{
            $member['members_balance'] = $member_data['members_balance'] - $value;
        }

        $updateSQL = $database->GetUpdateSQL($rs, $member);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }
}

/**
 * Updates $member_data using $member_id
 *
 * @param $member_id
 * @param $member_data
 * @return bool
 */
function update_member($member_id, $member_data){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_id = ' . make_safe($member_id));

        $updateSQL = $database->GetUpdateSQL($rs, $member_data);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates member's password based on $member_id and $password
 *
 * @param $member_id
 * @param $password
 * @return bool
 */
function update_password($member_id, $password){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_id = ' . make_safe($member_id));

        $member = array();

        $member['members_password'] = $password;
        $member['members_email_code'] = null;
        $member['members_password_change'] = date('Y-m-d H:i:s');

        $updateSQL = $database->GetUpdateSQL($rs, $member);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Inserts a contact request using $contact_data
 *
 * @param $contact_data
 * @return bool
 */
function insert_contact($contact_data){

    global $database;

    try {

        $rs = $database->Execute('select * from contacts');

        $insertSQL = $database->GetInsertSQL($rs, $contact_data);

        $database->Execute($insertSQL);

        return $database->Insert_ID();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Activates a user using the given $activation_code
 *
 * @param $activation_code
 * @return bool
 */
function activate_user($activation_code){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_status = 0 and members_activation_code = ' . make_safe($activation_code));

        if($rs->RecordCount() == 1) {

            $member = array();

            $member['members_status'] = 1;

            $updateSQL = $database->GetUpdateSQL($rs, $member);
            $database->Execute($updateSQL);

            return true;

        }

        return false;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets the last ten members from the database
 *
 * @return bool
 */
function get_last_ten_members(){

    $sql = 'select members.members_username, members.members_email, members.members_added from members order by members.members_added desc limit 10';
    return get_rows($sql);

}

/**
 * Deletes a member based on the given $member_id
 *
 * @param $member_id
 * @return bool
 */
function delete_member($member_id){

    $sql = 'delete from members where members_id = ' . make_safe($member_id);
    return delete_row($sql);

}

/**
 * Gets all members
 *
 * @return bool
 */
function get_members(){

    $sql = 'select * from members left join permissions on permissions.permissions_id = members.members_permissions_id order by members.members_added desc';
    return get_rows($sql);

}

/**
 * Updates username based on $member_id and $username
 *
 * @param $member_id
 * @param $username
 * @return bool
 */
function update_username($member_id, $username){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_id = ' . make_safe($member_id));

        $member = array();

        $member['members_username'] = $username;

        $updateSQL = $database->GetUpdateSQL($rs, $member);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates email based on $member_id and $email
 *
 * @param $member_id
 * @param $email
 * @return bool
 */
function update_email($member_id, $email){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_id = ' . make_safe($member_id));

        $member = array();

        $member['members_email'] = $email;

        $updateSQL = $database->GetUpdateSQL($rs, $member);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}