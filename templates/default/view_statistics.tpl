{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_56} <small><a href="{$link_data['links_short']}">{$link_data['links_short']}</a> - {$link_data['ViewCount']} {$lang_90} - {$lang_185} {$link_data['links_added']}</small></h1>
    </div>
    {if $setting_enable_ads}<div class="row text-center">{$setting_ad_stats}</div>{/if}
    <div class="row">
        <div class="col-lg-6">
            <h3>{$lang_84}</h3>
            <hr/>
            <form class="form-inline" action="" method="GET">
                <input type="hidden" name="link_id" value="{$smarty.get.link_id}" />
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
            <canvas id="monthly_chart" width="585" height="400"></canvas>
        </div>
        <div class="col-lg-3">
            <h3>{$lang_85}</h3>
            <hr/>
            {if count($top_countries) > 0}
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>{$lang_90}</th>
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
        <div class="col-lg-3">
            <h3>{$lang_86}</h3>
            <hr/>
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
    });
</script>

{include file="./footer.tpl"}