<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/**
 * Sends an e-mail based on a template
 *
 * @param $template_name
 * @param $template_data
 * @param $recipient_mail
 * @param $subject
 * @param bool $is_admin
 * @throws Exception
 * @throws SmartyException
 */
function send_email_template($template_name, $template_data, $recipient_mail, $subject, $is_admin = false){

    global $template;

    $template->assign('mail', $template_data);

    if($is_admin) {
        $body = $template->fetch(ADMIN_TEMPLATE . 'email/' . $template_name);
    }else{
        $body = $template->fetch(CURRENT_TEMPLATE . 'email/' . $template_name);
    }

    $headers = sprintf('From: %s', get_setting('email_from')) . '\r\n';
    $headers  .= 'MIME-Version: 1.0' . "\r\n";
    $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";

    mail($recipient_mail, $subject, $body, $headers);

}

/**
 * Checks if email exists based on given $email
 *
 * @param $email
 * @return bool
 */
function email_exists($email){

    $sql = 'select * from members where members_email = ' . make_safe($email);
    return fetch_row($sql);

}

/**
 * Updates the email code for a member based on their email
 *
 * @param $email
 * @param $email_code
 * @return bool
 */
function update_email_code($email, $email_code){

    global $database;

    try {

        $rs = $database->Execute('select * from members where members_email = ' . make_safe($email));

        $member = array();

        $member['members_email_code'] = $email_code;

        $updateSQL = $database->GetUpdateSQL($rs, $member);
        $database->Execute($updateSQL);

        return true;

    } catch (exception $e) {

        error_log($e);

        return false;

    }

}