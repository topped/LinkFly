<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

$settings = get_settings();

/**
 * Gets all settings
 *
 * @return mixed
 */
function get_settings() {

    $sql = 'select * from settings_values';
    return get_rows($sql);

}

/**
 * Gets a setting based on the slug
 *
 * @param $slug
 * @return null
 */
function get_setting($slug){

    $sql = 'select * from settings_values where settings_slug = '. make_safe($slug);
    return fetch_row($sql)['settings_value'];

}

/**
 * Updates setting based on slug with $value
 *
 * @param $slug
 * @param $value
 * @return bool
 */
function update_setting($slug, $value){

    global $database;

    try {

        $rs = $database->Execute('select * from settings_values where settings_slug = ' . make_safe($slug));

        $setting = array();

        $setting['settings_value'] = $value;

        $updateSQL = $database->GetUpdateSQL($rs, $setting);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Checks if setting exists
 *
 * @param $slug
 * @return bool
 */
function exist_setting($slug){

    global $database;

    try {

        $rs = $database->Execute('select * from settings_values where settings_slug = '. make_safe($slug));

        if($rs->RecordCount() > 0)
            return true;

        return false;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

