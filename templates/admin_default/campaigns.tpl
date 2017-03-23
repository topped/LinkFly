{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span> Campaigns</a></li>
                <li role="presentation"><a aria-controls="rates" role="tab" data-toggle="tab" href="#rates"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span> Rates</a></li>
                <li role="presentation"><a aria-controls="campaigns_settings" role="tab" data-toggle="tab" href="#campaigns_settings"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Settings</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Campaigns updated!</div>
                {/if}
                {if count($errors) > 0}
                    {foreach $errors as $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/foreach}
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Campaigns</h2><hr/>
                    <div class="button-bar">
                        <a href="{$setting_base_url}admin/add_campaign.php" class="btn btn-success"><span class="glyphicon glyphicon-plus aria-hidden="true"></span> Add Campaign</a>
                    </div>
                    <table id="campaigns_table" class="table table-bordered table-hover table-striped">
                        <thead>
                        <th>ID</th>
                        <th>Name</th>
                        <th>User</th>
                        <th>Website</th>
                        <th>URL</th>
                        <th>Ordered Views</th>
                        <th>Current Budget</th>
                        <th>Created</th>
                        <th>Rate</th>
                        <th>Payment Accepted</th>
                        <th></th>
                        <th></th>
                        </thead>
                        <tfoot>
                        <th>ID</th>
                        <th>Name</th>
                        <th>User</th>
                        <th>Name</th>
                        <th>URL</th>
                        <th>Ordered Views</th>
                        <th>Current Budget</th>
                        <th>Created</th>
                        <th>Rate</th>
                        <th>Payment Accepted</th>
                        <th>Delete</th>
                        <th>Edit</th>
                        </tfoot>
                        <tbody>
                        {foreach $campaigns as $campaign}
                            <tr>
                                <td>{$campaign['campaigns_id']}</td>
                                <td>
                                    {if $setting_campaigns_need_approval}{if $campaign['campaigns_approved'] == 0}
                                        <span class="label label-warning">Awaiting approval</span>
                                    {elseif $campaign['campaigns_approved'] == 1}
                                        <span class="label label-success">Approved</span>
                                    {else}
                                        <span class="label label-danger">Rejected</span>
                                    {/if}{/if}
                                    {$campaign['campaigns_name']}
                                    ({if $campaign['campaigns_status']==0}Running{elseif $campaign['campaigns_status']==1}<strong>Stopped</strong>{else}Ended{/if})
                                </td>
                                <td>{$campaign['members_username']}</td>
                                <td>{$campaign['campaigns_website_name']}</td>
                                <td><a target="_blank" href="{$campaign['campaigns_website_url']}">{$campaign['campaigns_website_url']}</a></td>
                                <td>{$campaign['campaigns_ordered_views']}K</td>
                                <td>{format_price value=$campaign['campaigns_current_budget']}</td>
                                <td>{$campaign['campaigns_started']}</td>
                                <td>{$campaign['rates_name']}</td>
                                <td>{if $campaign['campaigns_payment_accepted']==1}
                                        Yes{else}No
                                {/if}</td>
                                <td>
                                    {if $setting_campaigns_need_approval}
                                        {if $campaign['campaigns_approved'] == 0}
                                            <a class="btn btn-action btn-success btn-block btn-sm" href="{$setting_base_url}admin/campaigns.php?approve_campaign_id={$campaign['campaigns_id']}">Approve</a>
                                            <a class="btn btn-action btn-danger btn-block btn-sm" href="{$setting_base_url}admin/campaigns.php?reject_campaign_id={$campaign['campaigns_id']}">Reject</a>
                                        {elseif $campaign['campaigns_approved']==1}
                                            Approved
                                        {/if}
                                    {/if}
                                </td>
                                <td>
                                    <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/campaigns_edit.php?campaign_id={$campaign['campaigns_id']}">Edit</a>
                                    <form id="delete_form_{$campaign['campaigns_id']}" class="campaign-delete delete-form" method="POST" action="">
                                        <input type="hidden" name="delete_id" value="{$campaign['campaigns_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="campaigns_settings">
                    <h2>Settings</h2><hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="campaigns_need_approval" value="0">
                                        <input name="campaigns_need_approval" type="checkbox"{if isset($smarty.post.campaigns_need_approval)}{if $smarty.post.campaigns_need_approval == "on"} checked{/if}{else}{if $setting_campaigns_need_approval} checked{/if}{/if}> Campaigns need to be manually approved by admins
                                        <span id="helpBlock" class="help-block">It is recommended to leave this checked - unsupervised ads could potential be harmful to your users.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="update_requires_approval" value="0">
                                        <input name="update_requires_approval" type="checkbox"{if isset($smarty.post.update_requires_approval)}{if $smarty.post.update_requires_approval == "on"} checked{/if}{else}{if $setting_update_requires_approval} checked{/if}{/if}> Update to campaigns requires re-approval by admins
                                        <span id="helpBlock" class="help-block">Determines if an updated campaign needs to be re-approved by an admin. It is recommended to leave this checked.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Interstitial Ad Percentage</label>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input name="interstitial_ad_percentage" value="{if isset($smarty.post.interstitial_ad_percentage)}{$smarty.post.interstitial_ad_percentage}{else}{$setting_interstitial_ad_percentage}{/if}" type="text" class="form-control">
                                    <div class="input-group-addon">%</div>
                                </div>
                                <span id="helpBlock" class="help-block">Percentage of profits that publishers get to keep for interstitial ads</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Banner Ad Percentage</label>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input name="banner_ad_percentage" value="{if isset($smarty.post.banner_ad_percentage)}{$smarty.post.banner_ad_percentage}{else}{$setting_banner_ad_percentage}{/if}" type="text" class="form-control">
                                    <div class="input-group-addon">%</div>
                                </div>
                                <span id="helpBlock" class="help-block">Percentage of profits that publishers get to keep for banner ads</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">No Ad Percentage</label>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input name="no_ad_percentage" value="{if isset($smarty.post.no_ad_percentage)}{$smarty.post.no_ad_percentage}{else}{$setting_no_ad_percentage}{/if}" type="text" class="form-control">
                                    <div class="input-group-addon">%</div>
                                </div>
                                <span id="helpBlock" class="help-block">Percentage of profits that publishers get to keep for no ads</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Minimum Daily Budget ({$setting_site_curr})</label>
                            <div class="col-sm-3">
                                <input name="min_daily_budget" value="{if isset($smarty.post.min_daily_budget)}{$smarty.post.min_daily_budget}{else}{$setting_min_daily_budget}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The minimum daily budget amount for advertisers.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Minimum Quantity Views (Thousands)</label>
                            <div class="col-sm-3">
                                <input name="min_quantity_views" value="{if isset($smarty.post.min_quantity_views)}{$smarty.post.min_quantity_views}{else}{$setting_min_quantity_views}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The minimum amount of views that advetisers have to purchase in order to create a campaign.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Maximum Quantity Views (Thousands)</label>
                            <div class="col-sm-3">
                                <input name="max_quantity_views" value="{if isset($smarty.post.max_quantity_views)}{$smarty.post.max_quantity_views}{else}{$setting_max_quantity_views}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The maxmimum amount of views that advertisers can purchase.</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Default Campaign</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="default_campaign">
                                    <option value="0"{if isset($smarty.post.default_campaign)}{if $smarty.post.default_campaign==0} selected{/if}{else}{if $setting_default_campaign == 0} selected{/if}{/if}>No default (Direct link)</option>
                                    {foreach $campaigns as $campaign}
                                        <option value="{$campaign['campaigns_id']}"{if isset($smarty.post.default_campaign)}{if $smarty.post.default_campaign==$campaign['campaigns_id']} selected{/if}{else}{if $setting_default_campaign==$campaign['campaigns_id']} selected{/if}{/if}>{$campaign['campaigns_name']} (ID: {$campaign['campaigns_id']})</option>
                                    {/foreach}
                                </select>
                                <span id="helpBlock" class="help-block">The campaign that should be displayed if no other campaign is found valid.</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Banner Width (px)</label>
                            <div class="col-sm-3">
                                <input name="banner_width" value="{if isset($smarty.post.banner_width)}{$smarty.post.banner_width}{else}{$setting_banner_width}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The horizontal dimension of the banner ad type.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Banner Height (px)</label>
                            <div class="col-sm-3">
                                <input name="banner_height" value="{if isset($smarty.post.banner_height)}{$smarty.post.banner_height}{else}{$setting_banner_height}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The vertical dimension of the banner ad type.</span>
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
                <div role="tabpanel" class="tab-pane fade" id="rates">
                    <h2>Rates</h2>
                    <hr/>
                    <div class="button-bar">
                        <a href="{$setting_base_url}admin/add_rate.php" class="btn btn-success"><span class="glyphicon glyphicon-plus aria-hidden="true"></span> Add Rate</a>
                    </div>
                    <table id="rates_table" class="table table-bordered table-hover table-striped">
                        <thead>
                        <th>Name</th>
                        <th>Description</th>
                        <th>CPM</th>
                        <th>Location</th>
                        <th>Delete</th>
                        </thead>
                        <tbody>
                        {foreach $rates as $rate}
                            <tr>
                                <td>{$rate['rates_name']}</td>
                                <td>{$rate['rates_desc']}</td>
                                <td>{format_price value=$rate['rates_cpm']}</td>
                                <td>{if $rate['rates_location'] == null}Anywhere{else}{$rate['rates_location']}{/if}</td>
                                <td>
                                    <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/rates_edit.php?rate_id={$rate['rates_id']}">Edit</a>
                                    <form id="delete_form_{$rate['rates_id']}" class="rate-delete delete-form" method="POST" action="">
                                        <input type="hidden" name="delete_rate" value="{$rate['rates_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {

        // Setup - add a text input to each footer cell
        $('#campaigns_table tfoot th').each( function () {
            var title = $(this).text();
            $(this).html( '<input id="search-'+title.toLowerCase()+'" type="text" placeholder="Search '+title+'" />' );
        } );

        // DataTable
        var table = $('#campaigns_table').DataTable({
            "scrollX": true
        });

        var rateTable = $('#rates_table').DataTable();

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

        $(".campaign-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this campaign?");
            return c;
        });

        $(".rate-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this rate?");
            return c;
        });

    } );
</script>

{include file="./footer.tpl"}