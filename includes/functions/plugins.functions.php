<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

$plugins = get_plugins();

/**
 * Gets all plugins
 *
 * @return mixed
 */
function get_plugins() {

    $sql = 'select * from plugins';

    $rows = get_rows($sql);
    foreach($rows as $key => $value)
    {

        $thumb = get_setting('base_url') . 'plugins/' . $value['plugins_slug'] . '/thumb.png';
        $rows[$key]['plugins_thumb'] = $thumb;

    }

    return $rows;

}

/**
 * Updates plugin status
 *
 * @param $plugin_id
 * @param int $status
 * @return bool
 */
function update_plugin_status($plugin_id, $status = 0){

    global $database;

    try {

        $rs = $database->Execute('select * from plugins where plugins_id = ' . $plugin_id);

        $plugin_data = array();

        $plugin_data['plugins_enabled'] = $status;

        $updateSQL = $database->GetUpdateSQL($rs, $plugin_data);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Loads plugins
 */
function load_plugins() {

    global $plugins;

    foreach($plugins as $plugin){

        $plugin_functions_file = PLUGINS_DIR . $plugin['plugins_slug'] . sprintf('/%s.php', $plugin['plugins_slug']);

        if(file_exists($plugin_functions_file) && $plugin['plugins_enabled'])
            require_once $plugin_functions_file;

    }

}

/**
 * Gets plugin based on slug
 *
 * @param $slug
 * @return null
 */
function get_plugin($slug){

    $sql = 'select * from plugins where plugins_slug = ' . make_safe($slug);
    return fetch_row($sql);

}