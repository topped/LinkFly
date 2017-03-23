{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/campaigns.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit Campaign</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Campaign updated!</div>
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Edit Campaign</h2><hr/>
                    {if $campaign}
                    <form class="form-horizontal" method="POST" action="">
                        <input type="hidden" class="form-control" id="campaign_id" name="campaign_id" value="{$campaign['campaigns_id']}">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Name</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="name" name="name" value="{$campaign['campaigns_name']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Website Name</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="website_name" name="website_name" value="{$campaign['campaigns_website_name']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Website URL</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="website_url" name="website_url" value="{$campaign['campaigns_website_url']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Daily Budget</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="daily_budget" name="daily_budget" value="{$campaign['campaigns_daily_budget']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Current Budget</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="current_budget" name="current_budget" value="{$campaign['campaigns_current_budget']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Budget Used Today</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="budget_used_today" name="budget_used_today" value="{$campaign['campaigns_budget_used_today']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Last Budget Reset</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="last_budget_reset" name="last_budget_reset" value="{$campaign['campaigns_last_budget_reset']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Campaign Started</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="campaign_started" name="campaigns_started" value="{$campaign['campaigns_started']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputRates" class="col-sm-2 control-label">Rates</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputRates" name="rates_id">
                                    {foreach $rates as $rate}
                                        <option value="{$rate['rates_id']}"{if $rate['rates_id']==$campaign['campaigns_rates_id']} selected{/if}>{$rate['rates_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Ordered Views</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="ordered_views" name="ordered_views" value="{$campaign['campaigns_ordered_views']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputApprovalStatus" class="col-sm-2 control-label">Approval Status</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputApprovalStatus" name="approved">
                                    <option value="0"{if $campaign['campaigns_approved']==0} selected{/if}>Awaiting Approval</option>
                                    <option value="1"{if $campaign['campaigns_approved']==1} selected{/if}>Approved</option>
                                    <option value="2"{if $campaign['campaigns_approved']==2} selected{/if}>Rejected</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Reject Reason</label>
                            <div class="col-sm-3">
                                <textarea class="form-control" name="reject_reason" id="reject_reason" style="height: 110px;">{$campaign['campaigns_reject_reason']}</textarea>
                                <span id="help-block" class="help-block">If you have choosen to reject this campaign, please let the user know the reason for the rejection so the issue can be addressed.</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputStatus" class="col-sm-2 control-label">Status</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputStatus" name="status">
                                    <option value="0"{if $campaign['campaigns_status']==0} selected{/if}>Running</option>
                                    <option value="1"{if $campaign['campaigns_status']==1} selected{/if}>Stopped</option>
                                    <option value="2"{if $campaign['campaigns_status']==2} selected{/if}>Ended</option>
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputType" class="col-sm-2 control-label">Type</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputType" name="type">
                                    <option value="0"{if $campaign['campaigns_type']==0} selected{/if}>Interstitial</option>
                                    <option value="1"{if $campaign['campaigns_type']==1} selected{/if}>Banner</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputDevice" class="col-sm-2 control-label">Device</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputDevice" name="device">
                                    <option value="0"{if $campaign['campaigns_device']==0} selected{/if}>Both</option>
                                    <option value="1"{if $campaign['campaigns_device']==1} selected{/if}>Desktop</option>
                                    <option value="2"{if $campaign['campaigns_device']==2} selected{/if}>Mobile</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPaymentAccepted" class="col-sm-2 control-label">Payment accepted?</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputPaymentAccepted" name="payment_accepted">
                                    <option value="0"{if $campaign['campaigns_payment_accepted']==0} selected{/if}>No</option>
                                    <option value="1"{if $campaign['campaigns_payment_accepted']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-2">
                                <button type="submit" class="btn btn-primary">Update Campaign</button>
                            </div>
                        </div>
                    </form>
                    {else}
                    <div class="alert alert-danger">Invalid campaign</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}