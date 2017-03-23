{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_41} <small>{$lang_169}</small></h1>
    </div>
    <div class="row">
        <div class="col-lg-3">
            <ul class="nav nav-pills nav-stacked" role="tablist">
                <li role="presentation" class="active"><a href="#account_settings" aria-controls="account_settings" role="tab" data-toggle="tab">{$lang_170}</a></li>
                <li role="presentation"><a href="#transactions" aria-controls="transactions" role="tab" data-toggle="tab">{$lang_171}</a></li>
                <li role="presentation"><a href="#api" aria-controls="api" role="tab" data-toggle="tab">{$lang_329}</a></li>
             </ul>
        </div>
        <div class="col-lg-9">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active fade in" id="account_settings">
                    {if isset($errors)}
                        {foreach $errors as $error}
                            <div class="alert alert-danger">{$error}</div>
                        {/foreach}
                    {/if}
                    {if $success}
                        <div class="alert alert-success">{$lang_172}</div>
                    {/if}
                    <form class="form-horizontal" method="POST" action="">
                        <input type="hidden" name="csrf_token" value="{$smarty.session.csrf_token}" />
                        <div class="form-group">
                            <label class="col-sm-2 control-label">{$lang_45}</label>
                            <div class="col-sm-4">
                                <input type="password" class="form-control" name="password" placeholder="{$lang_45}" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">{$lang_66}</label>
                            <div class="col-sm-4">
                                <input type="email" class="form-control" name="email" placeholder="{$lang_66}" value="{if isset($smarty.post.email)}{$smarty.post.email}{else}{$member_data['members_email']}{/if}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">{$lang_44}</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="username" placeholder="{$lang_44}" value="{if isset($smarty.post.username)}{$smarty.post.username}{else}{$member_data['members_username']}{/if}">
                                <p class="help-block">{$lang_332}</p>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">{$lang_145}</label>
                            <div class="col-sm-4">
                                <input type="password" class="form-control" name="new_password" placeholder="{$lang_145}">
                                <p class="help-block">{$lang_146|sprintf:$setting_min_pass_length}</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">{$lang_147}</label>
                            <div class="col-sm-4">
                                <input type="password" class="form-control" name="new_password_repeat" placeholder="{$lang_147}">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-primary">{$lang_173}</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="transactions">
                    {if count($transactions) > 0}
                        <table class="table table-striped">
                            <thead>
                                <th>{$lang_174}</th>
                                <th>{$lang_175}</th>
                                <th>{$lang_176}</th>
                                <th>{$lang_177}</th>
                                <th>{$lang_178}</th>
                                <th>{$lang_179}</th>
                            </thead>
                            <tbody>
                            {foreach $transactions as $transaction}
                                <tr>
                                    <td>{$transaction['transactions_id']}</td>
                                    <td>
                                        {if $transaction['transactions_object_type'] == 1}
                                            {$lang_180}
                                        {else}
                                            {$lang_181}
                                        {/if}
                                    </td>
                                    <td>
                                        {if $transaction['transactions_gateway'] == 0}
                                            PayPal
                                            {else}
                                            2Checkout
                                        {/if}
                                    </td>
                                    <td>{$transaction['transactions_value']} {$transaction['transactions_curr']}</td>
                                    <td>{$transaction['transactions_item_name']}</td>
                                    <td>{if $transaction['transactions_status'] == 0}{$lang_182}{else}{$lang_183}{/if}</td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    {else}
                        <div class="subtle">{$lang_184}</div>
                    {/if}
                </div>
                {if $setting_enable_api}
                    <div role="tabpanel" class="tab-pane fade" id="api">
                        <p>{$lang_341}</p>
                        <code>{if empty($member_data['members_api_key']==false)}{$member_data['members_api_key']}{else}{$lang_342}{/if}</code>
                        <br/><br/>
                        <p>
                            {$lang_343}
                        </p>
                        <code>{$setting_base_url}api.php?key={$member_data['members_api_key']}&long_url=YOUR_URL{if $current_permission['permissions_change_domain']}&domain=0{/if}{if $current_permission['permissions_change_ad_type']}&ad_type=0{/if}{if $current_permission['permissions_custom_alias']}&custom_alias=CUSTOM_ALIAS{/if}</code>
                        <br/><br/>
                        {if count($domains) > 0 && $current_permission['permissions_change_domain']}
                            <p>
                                {$lang_344}
                            </p>
                            <table class="table table-bordered table-striped">
                                <tr>
                                    <th>ID</th>
                                    <th>Domain</th>
                                </tr>
                                {foreach $domains as $domain}
                                    <tr>
                                        <td>{$domain['domains_id']}</td>
                                        <td>{$domain['domains_url']}</td>
                                    </tr>
                                {/foreach}
                            </table>
                        {/if}
                        {if $current_permission['permissions_change_ad_type']}
                    <p>
                       {$lang_345}
                        <ul>
                            <li>0 = {$lang_38}</li>
                            <li>1 = {$lang_39}</li>
                            <li>2 = {$lang_40}</li>
                        </ul>
                    </p>
                    {/if}
                        {if $current_permission['permissions_custom_alias']}
                            <p>
                                {$lang_347}<br/><br/>
                                {$lang_330} {$setting_custom_alias_min_length}<br/>
                                {$lang_331} {$setting_custom_alias_max_length}
                            </p>
                        {/if}
                        <p>
                            <strong>{$lang_333}</strong> {if $setting_api_limit_daily == 0}{$lang_334}{else}{$setting_api_limit_daily}{/if}
                        </p>
                    </div>
                {/if}
            </div>
        </div>
    </div>

</div>

{include file="./footer.tpl"}