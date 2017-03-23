{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_27} <small>{$lang_63}</small></h1>
    </div>
    {if $setting_enable_ads}<div class="row text-center">{$setting_ad_publisher}</div>{/if}
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
            <strong>{$lang_66}</strong><br/>
            {$member_data['members_email']}
        </div>
        <div class="col-sm-4 pull-right text-right" id="account-settings">
            <a class="btn btn-success" href="add_wallet"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span> {$lang_326}</a>
            <a class="btn btn-primary" href="my_account"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> {$lang_68}</a>
        </div>
    </div>
    {if $current_permission['permissions_can_shorten']}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-warning panel-primary">
                <div class="panel-heading">{$lang_69}</div>
                <div class="panel-body">
                    {include file="./shorten_widget.tpl"}
                </div>
            </div>
        </div>
    </div>
    {/if}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">{$lang_78}</div>
                <div class="panel-body">
                    <div class="row well member-info stats">
                        <div class="col-sm-3">
                            <strong>{$lang_79}</strong><br/>
                            <h3>{if empty($total_earnings)}0{/if}{format_price value=$total_earnings}</h3>
                        </div>
                        <div class="col-sm-2">
                            <strong>{$lang_80}</strong><br/>
                            <h3>{$total_views}</h3>
                        </div>
                        <div class="col-sm-1">
                            <strong>{$lang_81}</strong>
                            <h3>{$links|count}</h3>
                        </div>
                        <div class="col-sm-3">
                            <strong>{$lang_82}</strong><br/>
                            <h3>{format_price value=$average_cpm}</h3>
                        </div>
                        <div class="col-sm-3">
                            <strong>{$lang_83}</strong><br/>
                            <h3>{format_price value=$average_view}</h3>
                        </div>
                    </div>
                    <div class="row" id="stats">
                        <div class="col-md-3">
                            <ul class="nav nav-pills nav-stacked" role="tablist">
                                <li role="presentation" class="active"><a href="#monthly" aria-controls="monthly_views" role="tab" data-toggle="tab">{$lang_84}</a></li>
                                <li role="presentation"><a href="#top_countries" aria-controls="top_countries" role="tab" data-toggle="tab">{$lang_85}</a></li>
                                <li role="presentation"><a href="#top_refs" aria-controls="top_refs" role="tab" data-toggle="tab">{$lang_86}</a></li>
                            </ul>
                        </div>
                        <div class="col-md-9">
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane active fade in" id="monthly">
                                    <form class="form-inline" action="dashboard" method="GET">
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
                                <div role="tabpanel" class="tab-pane fade" id="top_countries">
                                    {if count($top_countries) > 0}
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>{$lang_90}</th>
                                                <th>{$lang_91}</th>
                                                <th>{$lang_92}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                    {foreach $top_countries as $country}
                                        <tr>
                                            <td>{$country['occurences']}</td>
                                            <td>{$country['views_country']}</td>
                                            <td>{format_price value=$country['profit']}</td>
                                        </tr>
                                    {/foreach}
                                        </tbody>
                                    </table>
                                    {else}
                                        <div class="text-center subtle">{$lang_94}</div>
                                    {/if}
                                </div>
                                <div role="tabpanel" class="tab-pane fade" id="top_refs">
                                    {if count($top_refs) > 0}
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>{$lang_90}</th>
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
                <div class="panel-heading">{$lang_95}</div>
                <div class="panel-body">
                    {if count($links) > 0}
                    <div class="table-responsive">
                        <table id="links_table" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th class="col-sm-2">{$lang_96}</th>
                                    <th class="col-sm-5">{$lang_97}</th>
                                    <th class="col-sm-1">{$lang_98}</th>
                                    <th class="col-sm-1">{$lang_99}</th>
                                    <th class="col-sm-1">{$lang_100}</th>
                                    <th class="col-sm-1 no-sort"></th>
                                    <th class="col-sm-1 no-sort"></th>
                                </tr>
                            </thead>
                            <tbody>
                            {foreach $links as $link}
                                <tr>
                                    <td><a target="_blank" href="{$link['links_short']}">{$link['links_short']}</a></td>
                                    <td><a target="_blank" href="{$link['links_long_url']}">{$link['links_long_url']}</a></td>
                                    <td>
                                        {if $link['links_ad_type'] == 0}
                                            {$lang_38}
                                        {elseif $link['links_ad_type'] == 1}
                                            {$lang_39}
                                        {else}
                                            {$lang_40}
                                        {/if}
                                    </td>
                                    <td>{$link['ViewCount']}</td>
                                    <td>{format_price value=$link['links_profit']}</td>
                                    <td>
                                        <a target="_blank" class="btn btn-default btn-sm btn-block" href="stats?link_id={$link['links_id']}"><span class="glyphicon glyphicon-cloud" aria-hidden="true"></span> {$lang_78}</a>
                                    </td>
                                    <td>
                                        <form id="delete_form_{$link['links_id']}" class="link-delete" method="POST" action="">
                                            <input type="hidden" name="delete_id" value="{$link['links_id']}" />
                                            <button type="submit" class="btn btn-danger btn-sm btn-block"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> {$lang_101}</button>
                                        </form>
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                    {else}
                        <div class="text-center subtle">{$lang_102}</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    {if count($announcements) > 0}
        <h3 id="announcements">{$lang_104}</h3><hr/>
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
        $(".link-delete").submit(function() {
            var c = confirm("{$lang_103}");
            return c;
        });
    });
</script>

{include file="./footer.tpl"}