<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

require_once '../includes/admins.definitions.php';
require_once FUNCS_DIR . 'core.functions.php';

if($member_data['members_admin']) {

    stream_filter_register('crlf', 'crlf_filter');

    $m = $_POST['m'];
    $y = $_POST['y'];

    $export_type = $_POST['export_type'];

    if(empty($m) == false || empty($y) == false){

        $withdrawals = get_masspay_withdrawals($m, $y, $export_type);

        if(count($withdrawals) > 0) {

            $filename = date("Y_m_d") . "_masspay_export_" . date("M", $m) . "_" . $y . "_" . $export_type . ".txt";

            header("Content-Type: application/octet-stream");
            header("Content-Disposition: attachment; filename=$filename");
            header("Pragma: no-cache");
            header("Expires: 0");

            $handle = fopen("php://output", "w");
            stream_filter_append($handle, 'crlf');

            foreach($withdrawals as $withdrawal){

                $withdrawal_id = 'wid_' . $withdrawal['withdrawal_requests_id'] . '_uid_' . $withdrawal['members_id'] . '-' . $withdrawal['members_username'];

                update_withdrawal_request_status($withdrawal['withdrawal_requests_id'], 1);

                fputcsv($handle, array($withdrawal['withdrawal_requests_pp_email'], $withdrawal['withdrawal_requests_amount'], $withdrawal['withdrawal_requests_curr'], substr($withdrawal_id, 0, 30)), "\t");

            }

            fclose($handle);

        }else{

            redirect(get_setting('base_url').'admin/withdrawals.php?mp_error=1');

        }

    }

}

class crlf_filter extends php_user_filter
{
    function filter($in, $out, &$consumed, $closing)
    {
        while ($bucket = stream_bucket_make_writeable($in)) {
            // make sure the line endings aren't already CRLF
            $bucket->data = preg_replace("/(?<!\r)\n/", "\r\n", $bucket->data);
            $consumed += $bucket->datalen;
            stream_bucket_append($out, $bucket);
        }
        return PSFS_PASS_ON;
    }
}

?>