<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>{$setting_site_name} - Withdrawal Denied</title>
    <style>
        body {
            font-family: 'Verdana', sans-serif;
            font-size: 12px;
        }
    </style>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable">
    <tr>
        <td align="center" valign="top">
            <table border="0" cellpadding="20" cellspacing="0" width="600" id="emailContainer">
                <tr bgcolor="#23689a">
                    <td>
                        {if empty($setting_logo_url)}
                            <strong>{$setting_site_name}</strong>
                        {else}
                            <img width="100px" src="{$setting_base_url}{$smarty.const.CURRENT_TEMPLATE_NAME|string_format:$setting_logo_url}" alt="{$setting_site_name} Logo" />
                        {/if}
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <b>Hi,</b><br/><br/>
                        your requested withdrawal of <strong>{$mail['withdrawal_requests_amount']}{$mail['withdrawal_requests_curr']}</strong> has been denied by our administration team.<br/><br/>
                        The PayPal recipient e-mail was <strong>{$mail['withdrawal_requests_pp_email']}</strong>.
                        <br/>You can contact our support team to find out the reason as to why your request was denied.
                        <br/><br/>If you did not initiate this request, or the e-mail is unknown to you or incorrect,<br/>
                        do not hesitate to contact us immediately.

                        <i>- The {$setting_site_name} team</i><hr/>
                        <i>This is an automated response, please do not reply.</i>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>