{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-link" aria-hidden="true"></span> Links</a></li>
                <li role="presentation"><a aria-controls="domains" role="tab" data-toggle="tab" href="#domains"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span> Domains</a></li>
                <li role="presentation"><a aria-controls="links_settings" role="tab" data-toggle="tab" href="#links_settings"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Settings</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Settings updated!</div>
                {/if}
                {if count($errors) > 0}
                    {foreach $errors as $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/foreach}
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Links</h2><hr/>
                    <table id="links_table" class="table table-bordered table-hover table-striped">
                        <thead>
                            <th>Short URL</th>
                            <th>Long URL</th>
                            <th>User</th>
                            <th>IP</th>
                            <th>Published</th>
                            <th>Ad Type</th>
                            <th>Views</th>
                            <th>Actions</th>
                        </thead>
                        <tbody>
                            {foreach $links as $link}
                                <tr{if $link['links_enabled']==0} class="danger"{/if}>
                                    <td><a target="_blank" href="{$link['links_short']}">{$link['links_short']}</a></td>
                                    <td><a target="_blank" href="{$link['links_long_url']}">{$link['links_long_url']}</a></td>
                                    <td>{if $link['links_members_id'] == 0}Anonymous{else}{$link['members_username']}{/if}</td>
                                    <td><a target="_blank" href="http://www.ip-tracker.org/locator/ip-lookup.php?ip={$link['links_ip']}">{$link['links_ip']}</a></td>
                                    <td>{$link['links_added']}</td>
                                    <td>{if $link['links_ad_type'] == 0}Interstitial{elseif $link['links_ad_type'] == 1}Banner{else}Direct Link{/if}</td>
                                    <td>{$link['ViewCount']}</td>
                                    <td>{if $link['links_enabled']}<a href="?disable_link={$link['links_id']}">Disable</a>{else}<strong><a href="?enable_link={$link['links_id']}">Enable</a></strong>{/if} <a href="?delete_link={$link['links_id']}">Delete</a> <a href="{$setting_base_url}stats?link_id={$link['links_id']}">Stats</a></td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="domains">
                    <h2>Domains</h2>
                    <hr/>
                    <div class="button-bar">
                        <a href="{$setting_base_url}admin/add_domain.php" class="btn btn-success"><span class="glyphicon glyphicon-plus aria-hidden="true"></span> Add Domain</a>
                    </div>
                    <table id="domains_table" class="table table-bordered table-hover table-striped" style="width:450px;">
                            <thead>
                            <th>URL</th>
                            <th>Delete</th>
                        </thead>
                        <tbody>
                        {foreach $domains as $domain}
                            <tr>
                                <td>{$domain['domains_url']}</td>
                                <td>
                                    <form id="delete_form_{$domain['domains_id']}" class="domain-delete delete-form" method="POST" action="">
                                        <input type="hidden" name="delete_domain" value="{$domain['domains_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="links_settings">
                    <h2>Settings</h2>
                    <hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="anon_link_captcha" value="0">
                                        <input name="anon_link_captcha" type="checkbox"{if isset($smarty.post.anon_link_captcha)}{if $smarty.post.anon_link_captcha == "on"} checked{/if}{else}{if $setting_anon_link_captcha} checked{/if}{/if}> Anonymous links require CAPTCHA verification
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="disallow_proxies" value="0">
                                        <input name="disallow_proxies" type="checkbox"{if isset($smarty.post.disallow_proxies)}{if $smarty.post.disallow_proxies == "on"} checked{/if}{else}{if $setting_disallow_proxies} checked{/if}{/if}> Disallow proxies from viewing links
                                        <span id="helpBlock" class="help-block">If checked, disallows any users with HTTP_X_FORWARDED_FOR header set to view shortened links.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Disallowed Domains</label>
                            <div class="col-sm-3">
                                <textarea class="form-control" name="disallowed_domains">{if isset($smarty.post.disallowed_domains)}{$smarty.post.disallowed_domains}{else}{$setting_disallowed_domains}{/if}</textarea>
                                <span id="helpBlock" class="help-block">Disallow links with certain domains from being shortened. Separate by comma, no spaces.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Blocked Views IPs</label>
                            <div class="col-sm-3">
                                <textarea class="form-control" name="blocked_ips">{if isset($smarty.post.blocked_ips)}{$smarty.post.blocked_ips}{else}{$setting_blocked_ips}{/if}</textarea>
                                <span id="helpBlock" class="help-block">On each new line, put an IP that if the IP views a link, it will not be counted as a view.</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Suffix Length</label>
                            <div class="col-sm-3">
                                <input name="suffix_length" value="{if isset($smarty.post.suffix_length)}{$smarty.post.suffix_length}{else}{$setting_suffix_length}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">Length of the random generated URL suffix used to open shortened links.</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Custom Alias Min. Length</label>
                            <div class="col-sm-3">
                                <input name="custom_alias_min_length" value="{if isset($smarty.post.custom_alias_min_length)}{$smarty.post.custom_alias_min_length}{else}{$setting_custom_alias_min_length}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">Minimum length for custom aliases.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Custom Alias Max. Length</label>
                            <div class="col-sm-3">
                                <input name="custom_alias_max_length" value="{if isset($smarty.post.custom_alias_max_length)}{$smarty.post.custom_alias_max_length}{else}{$setting_custom_alias_max_length}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">Maxmimum length for custom aliases.</span>
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

        $('#links_table').dataTable({
            "pageLength": 25,
            "lengthMenu": [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
            "order": [[ 4, "desc" ]],
            "scrollX": true
        });

        $('#domains_table').dataTable({
            "searching": false
        });

        $(".domain-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this domain?");
            return c;
        });

    });
</script>

{include file="./footer.tpl"}