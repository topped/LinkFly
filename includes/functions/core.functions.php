<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/* Error Reporting
 *
 * 0 = No errors/Not recommended for developing and debugging
 * E_ALL & ~E_NOTICE = Only essential errors
 * -1 = All errors
 *
 */

error_reporting(-1);

/* Sessions for login */

session_start();

/* global page ID for references */

$pid = 0;

/* Requiring basic configs */

require_once CONFIGS_DIR . 'db.configs.php';
require_once CONFIGS_DIR . 'general.configs.php';

/* Requiring basic includes - note: order required is important */

require_once FUNCS_DIR . 'db.functions.php';
require_once FUNCS_DIR . 'settings.functions.php';

require_once FUNCS_DIR . 'lang.functions.php';
require_once FUNCS_DIR . 'user.functions.php';
require_once FUNCS_DIR . 'permissions.functions.php';
require_once FUNCS_DIR . 'template.functions.php';
require_once FUNCS_DIR . 'email.functions.php';
require_once FUNCS_DIR . 'campaigns.functions.php';
require_once FUNCS_DIR . 'link.functions.php';
require_once FUNCS_DIR . 'domains.functions.php';
require_once FUNCS_DIR . 'withdrawals.functions.php';
require_once FUNCS_DIR . 'transactions.functions.php';

require_once FUNCS_DIR . 'admin.functions.php';

/* Sets timezone from database */

date_default_timezone_set(get_setting('timezone'));

/* Checking if required extensions are installed */

if(!defined('CRYPT_BLOWFISH') && !CRYPT_BLOWFISH)
    die('PHP Requirement <em>CRYPT_BLOWFISH</em> is missing');

/**
 * Redirects to the specific URL
 *
 * @param $url
 */
function redirect($url){
    header('Location: ' . $url);
}

/* Misc. functions */

/**
 * Gets months ranging from 1-12
 *
 * @return array
 */
function get_months(){
    $months = array();
    for ($m=1; $m<=12; $m++) {
        $months[] = date('F', mktime(0,0,0,$m));
    }
    return $months;
}

/**
 * Gets all years starting at 2016
 *
 * @return array
 */
function get_years(){
    $years = array();
    for ($y=2016; $y<=date('Y'); $y++) {
        $years[] = $y;
    }
    return $years;
}

/**
 * Checks if a string ends with a certain string
 *
 * @param $haystack
 * @param $needle
 * @return bool
 */
function ends_with($haystack, $needle) {
    return $needle === "" || (($temp = strlen($haystack) - strlen($needle)) >= 0 && strpos($haystack, $needle, $temp) !== FALSE);
}

/**
 * Checks if a string starts with a certain string
 *
 * @param $haystack
 * @param $needle
 * @return bool
 */
function starts_with($haystack, $needle) {
    // search backwards starting from haystack length characters from the end
    return $needle === "" || strrpos($haystack, $needle, -strlen($haystack)) !== FALSE;
}

/**
 * Generate a slug (simplified name)
 *
 * @param $text
 * @return mixed|string
 */
function slugify($text)
{
    // replace non letter or digits by -
    $text = preg_replace('~[^\\pL\d]+~u', '-', $text);

    // trim
    $text = trim($text, '-');

    // transliterate
    $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);

    // lowercase
    $text = strtolower($text);

    // remove unwanted characters
    $text = preg_replace('~[^-\w]+~', '', $text);

    if (empty($text))
    {
        return 'n-a';
    }

    return $text;
}