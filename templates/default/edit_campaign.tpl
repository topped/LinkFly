{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_274} <small>{$lang_275}</small></h1>
    </div>
    {if isset($errors)}
        {foreach $errors as $error}
            <div class="alert alert-danger">{$error}</div>
        {/foreach}
    {/if}
    <div class="row">
        <div class="col-lg-9">
            {if $setting_update_requires_approval}
                <div class="alert alert-warning">{$lang_276}</div>
            {/if}
            <form class="form-horizontal" id="campaign-form" method="POST" action="">
                <input type="hidden" name="csrf_token" value="{$smarty.session.csrf_token}" />
                <input type="hidden" name="campaign_id" value="{$campaign_data['campaigns_id']}" />
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_193}</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="name" name="campaign_name" placeholder="Campaign Name" value="{if isset($campaign_data['campaigns_name'])}{$campaign_data['campaigns_name']}{else}{$smarty.post.campaign_name}{/if}" required>
                        <p class="help-block">{$lang_194}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_195}</label>
                    <div class="col-sm-5">
                        <div class="input-group">
                            <span class="input-group-addon">{$setting_site_curr}</span>
                            <input type="text" class="form-control" id="daily_budget" name="daily_budget" placeholder="2.50000" value="{if isset($campaign_data['campaigns_daily_budget'])}{$campaign_data['campaigns_daily_budget']}{else}{$smarty.post.daily_budget}{/if}" required>
                        </div>
                        <p class="help-block">{$lang_196}</p>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_71}</label>
                    <div class="col-sm-5">
                        <select name="ad_type" class="form-control" required>
                            <option value="0"{if isset($campaign_data['campaigns_type'])}{if $campaign_data['campaigns_type']==0} selected{/if}{else}{if $smarty.post.ad_type==0} selected{/if}{/if}>Interstitial Ad</option>
                            <option value="1"{if isset($campaign_data['campaigns_type'])}{if $campaign_data['campaigns_type']==1} selected{/if}{else}{if $smarty.post.ad_type==1} selected{/if}{/if}>Banner Ad</option>
                        </select>
                        <p class="help-block">{$lang_198}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_199}</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="website_name" name="website_name" placeholder="{$lang_199}" value="{if isset($campaign_data['campaigns_website_name'])}{$campaign_data['campaigns_website_name']}{else}{$smarty.post.website_name}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_200}</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="website_url" name="website_url" placeholder="http://" value="{if isset($campaign_data['campaigns_website_url'])}{$campaign_data['campaigns_website_url']}{else}{$smarty.post.website_url}{/if}" required>
                        <p class="help-block">{$lang_201} <a target="_blank" href="page_terms">{$lang_43}</a>. {$lang_202}{$setting_banner_width}x{$setting_banner_height} px</p>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_208}</label>
                    <div class="col-sm-5">
                        <select name="traffic_source" class="form-control" required>
                            <option value="0"{if isset($campaign_data['campaigns_device'])}{if $campaign_data['campaigns_device']==0} selected{/if}{else}{if $smarty.post.traffic_source==0} selected{/if}{/if}>All</option>
                            <option value="1"{if isset($campaign_data['campaigns_device'])}{if $campaign_data['campaigns_device']==1} selected{/if}{else}{if $smarty.post.traffic_source==1} selected{/if}{/if}>Desktop online</option>
                            <option value="2"{if isset($campaign_data['campaigns_device'])}{if $campaign_data['campaigns_device']==2} selected{/if}{else}{if $smarty.post.traffic_source==2} selected{/if}{/if}>Mobile online</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-5">
                        <button type="submit" class="btn btn-success">{$lang_277}</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-lg-3">
        </div>
    </div>

</div>

{include file="./footer.tpl"}