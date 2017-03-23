<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once LIBS_DIR . 'Smarty/Smarty.class.php';
require_once LIBS_DIR . '/securimage/securimage.php';

$template = get_setting('template');
$current_template = $template . '/';

if(!is_dir(LANGS_PREFIX . 'templates/' . $template))
    die(sprintf('Template "<em>%s</em>" could not be loaded because it does not exist.', $template));

/* Creating the template object */

$template = new Smarty();

/* Sets the compiled smarty templates directory, in our case cache */

$template->setCompileDir('cache');

/* Assigning primary setting variables for use in every template */

foreach($settings as $setting)
    $template->assign('setting_' . $setting['settings_slug'], $setting['settings_value']);

$template->assign('current_template', $current_template);

/* Permissions */

$template->assign('current_permission', $current_permission);

/* Member Data */

$template->assign('member_data', $member_data);

/* Language picker */

$template->assign('curr_lang', $language);

$lang_files = scandir(LANGS_PREFIX . 'langs');

$all_langs = array();

foreach($lang_files as $lang_file) {

    if(ends_with($lang_file, 'lang.php'))

        $all_langs[] = explode('.', $lang_file)[0];

    }

$template->assign('all_langs', $all_langs);

$template->assign('lang_html', $lang_html);

/* Assigns translations */

$i = 0;
foreach($langs as $lang){
    $template->assign('lang_' . $i, $lang);
    $i++;
}

/* Announcements */

$announcements = get_announcements();
$template->assign('announcements', $announcements);

if(count($announcements) > 0) {

    $last_announcement = $announcements[0]['announcements_message'];

    /* If the announcement is longer than 60 letters, we cut it */

    if (strlen($last_announcement) > 60)
        $last_announcement = strip_tags(substr($last_announcement, 0, 60) . '...');

}else{
    $last_announcement = $langs[0];
}

$template->assign('last_announcement',$last_announcement);

if(get_setting('is_maintenance') && IS_ADMIN == false && $flag_login == false && $member_data['members_admin'] == 0)
    show_maintenance();

/* Template Functions */

/**
 * Gets all templates
 *
 * @return array
 */
function get_all_templates(){

    $templates = array();

    foreach(glob('../templates/*', GLOB_ONLYDIR) as $dir) {
        $dir = str_replace('../templates/', '', $dir);
        if(starts_with($dir, 'admin_') == false)
            $templates[] = $dir;
    }

    return $templates;

}

/**
 * Gets all announcements
 *
 * @return mixed
 */
function get_announcements(){

    $sql = 'select * from announcements order by announcements_added desc limit 0,10 ';
    return get_rows($sql);

}

/**
 * Inserts announcement using the given $announcement_data
 *
 * @param $announcement_data
 * @return bool
 */
function insert_announcement($announcement_data){

    global $database;

    try {

        $rs = $database->Execute('select * from announcements where announcements_id = -1');

        $insertSQL = $database->GetInsertSQL($rs, $announcement_data);
        $database->Execute($insertSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Updates announcement using $announcement_id and given $update_data
 *
 * @param $announcement_id
 * @param $update_data
 * @return bool
 */
function update_announcement($announcement_id, $update_data){

    global $database;

    try {

        $rs = $database->Execute('select * from announcements where announcements_id = ' . make_safe($announcement_id));

        $updateSQL = $database->GetUpdateSQL($rs, $update_data);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets announcement data based on $announcement_id
 *
 * @param $announcement_id
 * @return null
 */
function get_announcement($announcement_id){

    $sql = 'select * from announcements where announcements_id = ' . make_safe($announcement_id);
    return fetch_row($sql);

}

/**
 * Gets all announcements
 *
 * @return mixed
 */
function get_all_announcements(){

    $sql = 'select * from announcements';
    return get_rows($sql);

}

/**
 * Gets all ads
 *
 * @return mixed
 */
function get_ads(){

    $sql = 'select * from ads';
    return get_rows($sql);

}

/**
 * Inserts page using given $page_data
 *
 * @param $page_data
 * @return bool
 */
function insert_page($page_data){

    global $database;

    global $member_data;

    try {

        $rs = $database->Execute('select * from pages');

        $insertSQL = $database->GetInsertSQL($rs, $page_data);

        $database->Execute($insertSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Deletes page based on $page_id
 *
 * @param $page_id
 * @return bool
 */
function delete_page($page_id){

    $sql = 'delete from pages where pages_id = ' . make_safe($page_id);
    return delete_row($sql);

}

/**
 * Deletes announcement based on $announcement_id
 *
 * @param $announcement_id
 * @return bool
 */
function delete_announcement($announcement_id){

    $sql = 'delete from announcements where announcements_id = ' . make_safe($announcement_id);
    return delete_row($sql);

}

/**
 * Updates page based on $page_id and $upate_data
 *
 * @param $page_id
 * @param $update_data
 * @return bool
 */
function update_page($page_id, $update_data){

    global $database;

    try {

        $rs = $database->Execute('select * from pages where pages_id = ' . make_safe($page_id));

        $updateSQL = $database->GetUpdateSQL($rs, $update_data);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}

/**
 * Gets all pages
 *
 * @return mixed
 */
function get_all_pages() {

    $sql = 'select * from pages';
    return get_rows($sql);


}

/**
 * Gets page by $page_id
 *
 * @param $page_id
 * @return bool
 */
function get_page_by_id($page_id){

    $sql = 'select * from pages where pages_id = ' . make_safe($page_id);
    return fetch_row($sql);

}

/**
 * Gets page based on $page_slug
 *
 * @param $page_slug
 * @return bool
 */
function get_page($page_slug){

    global $language;

    $sql = 'select * from pages where pages_slug = ' . make_safe($page_slug) . ' and pages_lang = ' . make_safe($language);
    return fetch_row($sql);

}

/**
 * Smarty function to format price
 *
 * @param $params
 * @param $template
 * @return string
 */
function smarty_function_format_price($params, &$template){

    global $langs;

    $value = $params['value'];

    $currency_symbol = get_setting('curr_symbol');
    $currency_symbol_position = get_setting('curr_symbol_pos');
    $currency_code_position = get_setting('curr_code_pos');
    $site_curr = get_setting('site_curr');

    $return_value = $value;

    if($currency_symbol_position == 0)
        $return_value = sprintf('%s%.05f', $currency_symbol, $value);
    if($currency_symbol_position == 1)
        $return_value = sprintf('%.05f%s', $value, $currency_symbol);
    if($currency_code_position == 0)
        $return_value = sprintf('%s %s', $site_curr, $return_value);
    if($currency_code_position == 1)
        $return_value = sprintf('%s %s', $return_value, $site_curr);

    return $return_value;

}

/**
 * Shows a 404 page
 */
function show_404(){

    global $template, $current_template;

    $template->assign('pid', 404);
    $template->assign('page_title', '404');

    $template->display($current_template . '404.tpl');

    die();

}

/**
 * Shows a maintenance page
 */
function show_maintenance(){

    global $template, $langs, $current_template;

    $template->assign('pid', 501);
    $template->assign('page_title', $langs[304]);

    $template->display($current_template . 'maintenance.tpl');

    die();

}