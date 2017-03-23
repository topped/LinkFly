{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_28} <small>{$lang_131}</small></h1>
    </div>
    {if $setting_enable_ads}<div class="row text-center">{$setting_ad_advertiser}</div>{/if}
    <div class="row well member-info">
        <div class="col-sm-2">
            <strong>{$lang_64}</strong><br/>
            {$smarty.session.members_username}
        </div>
        <div class="col-sm-2">
            <strong>{$lang_65}</strong><br/>
            {format_price value=$member_data['members_balance']}
        </div>
        <div class="col-sm-2">
            <strong>{$lang_112}</strong><br/>
            {$campaigns|count} {$lang_115}
        </div>
        <div class="col-sm-4 text-right pull-right">
            <a class="btn btn-success" href="add_wallet"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span> {$lang_326}</a>
            <a class="btn btn-primary" href="add_campaign"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> {$lang_191}</a>
        </div>
    </div>
    {if count($campaigns) > 0}
        {if $setting_campaigns_need_approval}
            {foreach $campaigns as $campaign}
                {if $campaign['campaigns_approved'] == 2}
                    <div class="alert alert-danger">
                        {$lang_133|sprintf:$campaign['campaigns_name']}
                        <div class="reject">{if {$campaign['campaigns_reject_reason']|strlen} > 0}{$campaign['campaigns_reject_reason']}{else}{$lang_134}{/if}</div>
                    </div>
                {/if}
                {if $campaign['campaigns_payment_accepted'] == 0}
                    <div class="alert alert-danger">
                        {$lang_135|sprintf:$campaign['campaigns_name']}
                    </div>
                {/if}
                {if $campaign['campaigns_status'] == 2}
                    <div class="alert alert-warning">
                        {$lang_136|sprintf:$campaign['campaigns_name']}
                    </div>
                {/if}
            {/foreach}
        {/if}
    {/if}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">Statistics</div>
                <div class="panel-body">
                    <div class="col-md-3">
                        <ul class="nav nav-pills nav-stacked" role="tablist">
                            <li role="presentation" class="active"><a href="#monthly" aria-controls="home" role="tab" data-toggle="tab">{$lang_84}</a></li>
                            <li role="presentation"><a href="#top-countries" aria-controls="cost" role="tab" data-toggle="tab">{$lang_85}</a></li>
                            <li role="presentation"><a href="#top-refs" aria-controls="cost" role="tab" data-toggle="tab">{$lang_86}</a></li>
                            <li role="presentation"><a href="#top-devices" aria-controls="cost" role="tab" data-toggle="tab">{$lang_116}</a></li>
                        </ul>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active fade in" id="monthly">
                                <form class="form-inline" action="" method="GET">
                                    <div class="form-group">
                                        <label class="sr-only">{$lang_87}</label>
                                        <select class="form-control" name="m">
                                            {foreach $months as $month}
                                                <option value="{$month|date_format:"n"}"{if $m=={$month|date_format:"n"}} selected{/if}>{$month}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="sr-only">{$lang_88}</label>
                                        <select class="form-control"  name="y">
                                            {foreach $years as $year}
                                                <option value="{$year}"{if $y==$year} selected{/if}>{$year}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-default">{$lang_89}</button>
                                </form><hr/>
                                <canvas id="monthly_chart" width="800" height="400"></canvas>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="top-countries">
                                {if count($top_countries) > 0}
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>{$lang_99}</th>
                                            <th>{$lang_91}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $top_countries as $country}
                                            <tr>
                                                <td>{$country['occurences']}</td>
                                                <td>{$country['views_country']}</td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                {else}
                                    <div class="text-center subtle">{$lang_94}</div>
                                {/if}
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="top-refs">
                                {if count($top_refs) > 0}
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>{$lang_99}</th>
                                            <th>{$lang_93}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $top_refs as $refs}
                                            <tr>
                                                <td>{$refs['occurences']}</td>
                                                <td>{if empty($refs['views_referral'])}{$lang_337}{else}<a target="_blank" href="{$refs['views_referral']}">{$refs['views_referral']}</a>{/if}</td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                {else}
                                    <div class="text-center subtle">{$lang_94}</div>
                                {/if}
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="top-devices">
                                {if count($top_devices) > 0}
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>{$lang_99}</th>
                                            <th>{$lang_132}</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {foreach $top_devices as $device}
                                            <tr>
                                                <td>{$device['occurences']}</td>
                                                <td>
                                                    {if $device['views_mobile_device']==0}Unknown{elseif $device['views_mobile_device'] == 1}<span class="glyphicon glyphicon-hdd" aria-hidden="true"></span> Desktop{else} <span class="glyphicon glyphicon-phone" aria-hidden="true"></span>Mobile{/if}
                                                </td>
                                            </tr>
                                        {/foreach}
                                        </tbody>
                                    </table>
                                {else}
                                    <div class="text-center subtle">{$lang_94}</div>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">{$lang_117}</div>
                <div class="panel-body">
                    {if count($campaigns) > 0}
                        <div class="table-responsive">
                            <table id="campaigns_table" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="col-sm-2">{$lang_118}</th>
                                        <th class="col-sm-2">{$lang_119}</th>
                                        <th class="col-sm-1">{$lang_120}</th>
                                        <th class="col-sm-1">{$lang_121}</th>
                                        <th class="col-sm-1">{$lang_122}</th>
                                        <th class="col-sm-2">{$lang_123}</th>
                                        <th class="col-sm-1">{$lang_124}</th>
                                        <th class="col-sm-1">{$lang_125}</th>
                                        <th class="col-sm-1">{$lang_126}</th>
                                        <th class="col-sm-1 no-sort"></th>
                                        <th class="col-sm-1 no-sort"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $campaigns as $campaign}
                                    <tr class="{if $campaign['campaigns_approved']==0}info{elseif $campaign['campaigns_approved']==2}danger{elseif $campaign['campaigns_status']==1}warning{elseif $campaign['campaigns_status']==2}warning{/if}">
                                        <td>
                                            {if $setting_campaigns_need_approval}
                                                {if $campaign['campaigns_approved']==0}<span class="label label-default">{$lang_128}</span>{/if}
                                                {if $campaign['campaigns_approved']==2}<span class="label label-danger">{$lang_129}</span>{/if}
                                            {/if}
                                            <strong>{$campaign['campaigns_name']}</strong></td>
                                        <td><a target="_blank" href="{$campaign['campaigns_website_url']}">{$campaign['campaigns_website_name']}</a></td>
                                        <td>{format_price value=$campaign['campaigns_current_budget']}</td>
                                        <td>{format_price value=$campaign['campaigns_daily_budget']}</td>
                                        <td>{format_price value=$campaign['campaigns_budget_used_today']}</td>
                                        <td>{$campaign['campaigns_started']}</td>
                                        <td>{$campaign['rates_name']}</td>
                                        <td>{$campaign['campaigns_ordered_views']*1000}</td>
                                        <td>{$campaign['ViewCount']}</td>
                                        <td>
                                            <a class="btn btn-default btn-sm btn-block" href="edit_campaign?id={$campaign['campaigns_id']}"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> {$lang_127}</a>
                                        </td>
                                        <td>
                                            <form id="delete_form_{$campaign['campaigns_id']}" class="campaign-delete" method="POST" action="">
                                                <input type="hidden" name="delete_id" value="{$campaign['campaigns_id']}" />
                                                <button type="submit" class="btn btn-danger btn-sm btn-block"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> {$lang_101}</button>
                                            </form>
                                        </td>
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                        <div class="legend">
                            <span class="label label-warning">{$lang_130}</span>
                        </div>
                    {else}
                        <div class="text-center subtle">{$lang_137}</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    {if count($announcements) > 0}
        <h3>{$lang_104}</h3><hr/>
        {foreach $announcements as $announcement}
            {assign var="type" value="info"}
            {if $announcement['announcements_type'] == 1}
                {assign var="type" value="warning"}
            {elseif $announcement['announcements_type'] == 2}
                {assign var="type" value="danger"}
            {elseif $announcement['announcements_type'] == 3}
                {assign var="type" value="success"}
            {/if}
            <div class="alert alert-{$type}">{$announcement['announcements_added']}: <strong>{$announcement['announcements_message']}</strong></div>
        {/foreach}
    {/if}
</div>

<script>
    $(document).ready(function () {
        var ctx = $("#monthly_chart").get(0).getContext("2d");
        var data =
                {$chart_code};
        options = {
            barDatasetSpacing : 15,
            barValueSpacing: 10,
            bezierCurve: false,
            scaleShowVerticalLines: false,
            responsive: true,
            maintainAspectRatio: true
        };
        ctx = new Chart(ctx).Line(data, options);
        $(".campaign-delete").submit(function() {
            var c = confirm("{$lang_138}");
            return c;
        });
    });
</script>

{include file="./footer.tpl"}