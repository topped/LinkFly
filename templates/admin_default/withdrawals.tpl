{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="withdrawals" role="tab" data-toggle="tab" href="#withdrawals"><span class="glyphicon glyphicon-cloud-download" aria-hidden="true"></span> Withdrawals</a></li>
                <li role="presentation"><a aria-controls="transactions" role="tab" data-toggle="tab" href="#transactions"><span class="glyphicon glyphicon-list" aria-hidden="true"></span> Transactions</a></li>
                <li role="presentation"><a aria-controls="masspay" role="tab" data-toggle="tab" href="#masspay"><span class="glyphicon glyphicon-export" aria-hidden="true"></span> MassPay</a></li>
                <li role="presentation"><a aria-controls="withdrawals_settings" role="tab" data-toggle="tab" href="#withdrawals_settings"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Settings</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Withdrawals updated!</div>
                {/if}
                {if count($errors) > 0}
                    {foreach $errors as $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/foreach}
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="withdrawals">
                    <h2>Withdrawals</h2><hr/>
                    <div class="alert alert-info">Withdrawal Requests that need to be validated are highlighted. You will have to manually release and send funds through PayPal.</div>
                    <table id="withdrawals_table" class="table table-bordered table-hover table-striped">
                        <thead>
                        <th>Requested By</th>
                        <th>Funds to Pay</th>
                        <th>PayPal E-Mail</th>
                        <th>Requested</th>
                        <th>Status</th>
                        <th>Validate Withdrawal</th>
                        <th></th>
                        </thead>
                        <tfoot>
                        <th>Username</th>
                        <th>Amount</th>
                        <th>E-Mail</th>
                        <th>Request Date</th>
                        <th>Status</th>
                        <th></th>
                        <th></th>
                        </tfoot>
                        <tbody>
                        {foreach $withdrawals as $withdrawal}
                            <tr{if $withdrawal['withdrawal_requests_status']==0} class="success"{/if}>
                                <td>{$withdrawal['members_username']}</td>
                                <td>{$withdrawal['withdrawal_requests_amount']} {$withdrawal['withdrawal_requests_curr']}</td>
                                <td>{$withdrawal['withdrawal_requests_pp_email']}</td>
                                <td>{$withdrawal['withdrawal_requests_added']}</td>
                                <td>
                                    {if $withdrawal['withdrawal_requests_status'] == 0}
                                        <strong>Awaiting Validation</strong>
                                    {elseif $withdrawal['withdrawal_requests_status'] == 1}
                                        Processed
                                    {elseif $withdrawal['withdrawal_requests_status'] == 2}
                                        Delayed
                                    {elseif $withdrawal['withdrawal_requests_status'] == 3}
                                        Failed
                                    {elseif $withdrawal['withdrawal_requests_status'] == 4}
                                        Denied
                                    {/if}
                                </td>
                                <td>
                                    Pay Via <a href="https://paypal.com">PayPal</a> <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> Validate <em>OR</em> mark other
                                </td>
                                <td>
                                    <strong>Mark as:</strong><br/>
                                    <a href="{$setting_base_url}admin/withdrawals.php?withdrawal_request_id={$withdrawal['withdrawal_requests_id']}&action=1">Processed</a>
                                    <a href="{$setting_base_url}admin/withdrawals.php?withdrawal_request_id={$withdrawal['withdrawal_requests_id']}&action=2">Delayed</a>
                                    <a href="{$setting_base_url}admin/withdrawals.php?withdrawal_request_id={$withdrawal['withdrawal_requests_id']}&action=3">Failed</a>
                                    <a href="{$setting_base_url}admin/withdrawals.php?withdrawal_request_id={$withdrawal['withdrawal_requests_id']}&action=4">Denied</a>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="transactions">
                    <h2>Transactions</h2><hr/>
                    <table id="transactions_table" class="table table-bordered table-hover table-striped">
                        <thead>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Type</th>
                        <th>Gateway</th>
                        <th>Date</th>
                        <th>Value</th>
                        <th>Item Name</th>
                        <th>Status</th>
                        </thead>
                        <tbody>
                            {foreach $transactions as $transaction}
                                <tr>
                                    <td>{$transaction['transactions_id']}</td>
                                    <td>{$transaction['members_username']}</td>
                                    <td>{if $transaction['transactions_object_type']==1}Campaign Purchase{/if}</td>
                                    <td>{if $transaction['transactions_gateway']==0}PayPal{else}2Checkout{/if}</td>
                                    <td>{$transaction['transactions_added']}</td>
                                    <td>{$transaction['transactions_value']} {$transaction['transactions_curr']}</td>
                                    <td>{$transaction['transactions_item_name']}</td>
                                    <td>{if $transaction['transactions_status']==0}Not processed{else}Processed{/if}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="masspay">
                    <h2>MassPay</h2>
                    <hr/>
                    <p class="form-control-static">
                        This tool will generate a <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_batch-payment-overview-outside">MassPay</a>-compatible payment file. Once generated, you can upload your tab-delimited MassPay file to PayPal for processing.<br/>
                        All withdrawals during a selected monthly time period will be exported and automatically marked as 'Processed'.
                    </p>
                    <form class="form-inline" action="masspay.php" method="POST">
                        <div class="form-group">
                            <label class="sr-only">Month</label>
                            <select class="form-control" name="m">
                                {foreach $months as $month}
                                    <option value="{$month|date_format:"n"}"{if $m=={$month|date_format:"n"}} selected{/if}>{$month}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="sr-only">Year</label>
                            <select class="form-control"  name="y">
                                {foreach $years as $year}
                                    <option value="{$year}"{if $y==$year} selected{/if}>{$year}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-group">
                            <select class="form-control"  name="export_type">
                                <option value="0">Export only 'Processing'</option>
                                <option value="1">Export all</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-default">Export File</button>
                    </form>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="withdrawals_settings">
                    <h2>Settings</h2>
                    <hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="enable_withdrawals" value="0">
                                        <input name="enable_withdrawals" type="checkbox"{if isset($smarty.post.enable_withdrawals)}{if $smarty.post.enable_withdrawals == "on"} checked{/if}{else}{if $setting_enable_withdrawals} checked{/if}{/if}> Enable Withdrawals
                                        <span id="helpBlock" class="help-block">Determines if users can currently withdraw money.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Minimum Account Age for Withdrawal (Days)</label>
                            <div class="col-sm-3">
                                <input name="min_account_age" value="{if isset($smarty.post.min_account_age)}{$smarty.post.min_account_age}{else}{$setting_min_account_age}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The minimum age of an account, in days, required so that the user can withdraw funds.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Minimum Time Password Changed (Days)</label>
                            <div class="col-sm-3">
                                <input name="min_pass_change_time" value="{if isset($smarty.post.min_pass_change_time)}{$smarty.post.min_pass_change_time}{else}{$setting_min_pass_change_time}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">Length users have to wait in order to withdraw money after they changed their passwords, in days.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Minimum Withdrawal Amount ({$setting_site_curr})</label>
                            <div class="col-sm-3">
                                <input name="min_withdraw" value="{if isset($smarty.post.min_withdraw)}{$smarty.post.min_withdraw}{else}{$setting_min_withdraw}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The minimum amount of funds users are required to have in order to withdraw money.</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <button type="submit" class="btn btn-default">Save</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {

        // Setup - add a text input to each footer cell
        $('#withdrawals_table tfoot th').each( function () {
            var title = $(this).text();
            $(this).html( '<input id="search-'+title.toLowerCase()+'" type="text" placeholder="Search '+title+'" />' );
        } );

        // DataTable
        var table = $('#withdrawals_table').DataTable( {
            "order": [[ 3, "desc" ]],
            "scrollX": true
        } );

        var table_trans = $('#transactions_table').DataTable({
            "order": [[ 4, "desc" ]]
        } );

        // Apply the search
        table.columns().every( function () {
            var that = this;

            $( 'input', this.footer() ).on( 'keyup change', function () {
                if ( that.search() !== this.value ) {
                    that
                            .search( this.value )
                            .draw();
                }
            } );
        } );


    } );
</script>

{include file="./footer.tpl"}