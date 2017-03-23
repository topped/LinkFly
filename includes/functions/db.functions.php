<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once LIBS_DIR . 'adodb5/adodb-exceptions.inc.php';
require_once LIBS_DIR . 'adodb5/adodb.inc.php';

$database = NewADOConnection(DB_DRIVER);

try {

    $database->Connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

} catch (exception $e) {

    error_log($e);

    die('<h1>Connection to database failed.</h1>');

}

/**
 * Takes a string and escapes it using the ADoDB qstr function
 *
 * @param $string
 * @return mixed
 */
function make_safe($string){

    global $database;
    return $database->qstr($string);

}

/**
 * Fetches a row using the given SQL
 *
 * @param $sql
 * @return bool
 */
function fetch_row($sql){

    global $database;

    try {

        $rs = $database->Execute($sql);

        return $rs->FetchRow();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets rows using the given SQL
 *
 * @param $sql
 * @return bool
 */
function get_rows($sql){

    global $database;

    try {

        $rs = $database->Execute($sql);

        return $rs->GetRows();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Counts the rows using the given SQL
 *
 * @param $sql
 * @return bool
 */
function record_count($sql) {

    global $database;

    try {

        $rs = $database->Execute($sql);

        return $rs->RecordCount();

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Deletes a row using the given SQL
 *
 * @param $sql
 * @return bool
 */
function delete_row($sql){

    global $database;

    try {

        $rs = $database->Execute($sql);

        return $rs;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}
