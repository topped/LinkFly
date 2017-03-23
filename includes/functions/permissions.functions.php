<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

$current_permission = get_permission(get_setting('default_permission_visitor'));

if(!empty($_SESSION['members_id']))
    $current_permission = get_permission(get_member($_SESSION['members_id'])['members_permissions_id']);

/**
 * Gets a permission based on $permission_id
 *
 * @param $permission_id
 * @return null
 */
function get_permission($permission_id){

    $sql = 'select * from permissions where permissions_id = ' . make_safe($permission_id);
    return fetch_row($sql);

}

/**
 * Inserts a permission based on the permission data given
 *
 * @param $permission_data
 * @return bool
 */
function insert_permission($permission_data){

    global $database;

    try {

        $rs = $database->Execute('select * from permissions where permissions_id = -1');

        $insertSQL = $database->GetInsertSQL($rs, $permission_data);
        $database->Execute($insertSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates permission based on given $permission_id
 *
 * @param $permission_id
 * @param $update_data
 * @return bool
 */
function update_permission($permission_id, $update_data){

    global $database;

    try {

        $rs = $database->Execute('select * from permissions where permissions_id = ' . make_safe($permission_id));

        $updateSQL = $database->GetUpdateSQL($rs, $update_data);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Deletes a permission based on given $permission_id
 *
 * @param $permission_id
 * @return bool
 */
function delete_permission($permission_id){

    $sql = 'delete from permissions where permissions_id = ' . make_safe($permission_id);
    return delete_row($sql);

}

/**
 * Gets all permissions
 *
 * @return mixed
 */
function get_permissions() {

    $sql = 'select * from permissions';
    return get_rows($sql);

}