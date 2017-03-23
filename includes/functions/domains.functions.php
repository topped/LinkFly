<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/**
 * Gets a domain based on the given $domain_id
 *
 * @param $domain_id
 * @return null
 */
function get_domain($domain_id){

    $sql = 'select * from domains where domains_id = ' . make_safe($domain_id);
    return fetch_row($sql);

}

/**
 * Inserts a domain based on the $domain_url
 *
 * @param $domain_url
 * @return bool
 */
function insert_domain($domain_url){

    global $database;

    try {

        $rs = $database->Execute('select * from domains where domains_id = -1');

        $domain = array();

        $domain['domains_url'] = $domain_url;

        $insertSQL = $database->GetInsertSQL($rs, $domain);
        $database->Execute($insertSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Deletes a domain based on the given $domain_id
 *
 * @param $domain_id
 * @return bool
 */
function delete_domain($domain_id){

    $sql = 'delete from domains where domains_id = ' . make_safe($domain_id);
    return delete_row($sql);

}

/**
 * Gets all domains
 *
 * @return mixed
 */
function get_domains() {

    $sql = 'select * from domains';
    return get_rows($sql);

}