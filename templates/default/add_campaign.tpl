{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_191} <small>{$lang_192}</small></h1>
    </div>
    {if isset($errors)}
        {foreach $errors as $error}
            <div class="alert alert-danger">{$error}</div>
        {/foreach}
    {/if}
    <div class="row">
        <div class="col-lg-9">
            <form class="form-horizontal" id="campaign-form" method="POST" action="">
                <input type="hidden" name="csrf_token" value="{$smarty.session.csrf_token}" />
                {if isset($campaign_id)}
                    <input type="hidden" name="campaign_id" value="{$campaign_id}" />
                {/if}
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_193}</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="name" name="campaign_name" placeholder="{$lang_193}" value="{if isset($smarty.post.campaign_name)}{$smarty.post.campaign_name}{/if}" required>
                        <p class="help-block">{$lang_194}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_195}</label>
                    <div class="col-sm-5">
                        <div class="input-group">
                            <span class="input-group-addon">{$setting_site_curr}</span>
                            <input type="text" class="form-control" id="daily_budget" name="daily_budget" placeholder="{$lang_195}" value="{if isset($smarty.post.daily_budget)}{$smarty.post.daily_budget}{/if}" required>
                        </div>
                        <p class="help-block">{$lang_196}</p>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_71}</label>
                    <div class="col-sm-5">
                        <select name="ad_type" class="form-control" required>
                            <option value="0"{if isset($smarty.post.ad_type)}{if $smarty.post.ad_type == 0} selected{/if}{/if}>{$lang_72}</option>
                            <option value="1"{if isset($smarty.post.ad_type)}{if $smarty.post.ad_type == 1} selected{/if}{/if}>{$lang_73}</option>
                        </select>
                        <p class="help-block">{$lang_198}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_199}</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="website_name" name="website_name" placeholder="{$lang_199}" value="{if isset($smarty.post.website_name)}{$smarty.post.website_name}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_200}</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" id="website_url" name="website_url" placeholder="http://" value="{if isset($smarty.post.website_url)}{$smarty.post.website_url}{/if}" required>
                        <p class="help-block">{$lang_201}<a target="_blank" href="page_terms">{$lang_43}</a> {$lang_202}{$setting_banner_width}x{$setting_banner_height} px</p>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_203}</label>
                    <div class="col-sm-10">
                        <table class="table table-bordered table-striped">
                            <tr>
                                <th>{$lang_204}</th>
                            </tr>
                            {foreach $rates as $rate}
                                <tr>
                                    <td>
                                        <label class="checkbox-inline">
                                            <input name="rate" type="radio" value="{$rate['rates_id']}"{if isset($smarty.post.rate)}{if $smarty.post.rate == $rate['rates_id']} checked{/if}{else}{if $rate@first} checked{/if}{/if}/> <strong>{$rate['rates_name']}</strong> - {format_price value=$rate['rates_cpm']}<br/>
                                            <input type="hidden" id="rates-{$rate['rates_id']}-cpm" value="{$rate['rates_cpm']}" /><em>{$rate['rates_desc']}</em><br/>
                                            {$lang_205} {if $rate['rates_location'] == null}{$lang_223}{else}{$rate['rates_location']}{/if}
                                        </label>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_206}</label>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <input type="text" class="form-control" id="quantity" name="quantity" value="{if isset($smarty.post.quantity)}{$smarty.post.quantity}{else}{$setting_min_quantity_views}{/if}" required>
                            <span class="input-group-addon">{$lang_207}</span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_208}</label>
                    <div class="col-sm-5">
                        <select name="traffic_source" class="form-control" required>
                            <option value="0"{if isset($smarty.post.traffic_source)}{if $smarty.post.traffic_source == 0} selected{/if}{/if}>{$lang_209}</option>
                            <option value="1"{if isset($smarty.post.traffic_source)}{if $smarty.post.traffic_source == 1} selected{/if}{/if}>{$lang_210}</option>
                            <option value="2"{if isset($smarty.post.traffic_source)}{if $smarty.post.traffic_source == 2} selected{/if}{/if}>{$lang_211}</option>
                        </select>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_43}</label>
                    <div class="col-sm-7">
                        <div class="checkbox">
                            <label>
                                <input name="terms" type="checkbox" required>{$lang_167} <a target="_blank" href="page_terms">{$lang_43}</a>.
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_212}</label>
                    <div class="col-sm-7">
                        <div class="checkbox">
                            <label>
                                <input name="disclaimer" type="checkbox" required>{$lang_213}
                            </label>
                        </div>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_214}</label>
                    <div class="col-sm-7">
                        <div class="checkbox">
                            <h3 id="final-cost">0.00{$setting_site_curr}</h3>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-5">
                        <button type="submit" class="btn btn-success">{$lang_197} &#187;</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-lg-3">
            <h4>{$lang_216}</h4><hr/>
            <p>
                <em>{$lang_217}</em><br/>
                {$lang_218}
            </p>
            <hr/>
            <p>
                <em>{$lang_219}</em><br/>
                {$lang_220}
            </p>
            <hr/>
            <p>
                <em>{$lang_221}</em><br/>
                {$lang_222}
            </p>
        </div>
    </div>

</div>

<script type="text/javascript">
    $(document).ready( function () {
        do_price_update();
        $("#quantity").keyup( function() {
            do_price_update();
        });
        $('input:radio').change( function() {
            do_price_update();
        });
    });
    function do_price_update(){
        var q = $("#quantity").val();
        if(!isNaN(q) && q.length > 0){
            var rates_id = $('input[name=rate]:checked', '#campaign-form').val();
            var rates_cpm = $("#rates-" + rates_id + "-cpm").val();
            var final_price = (parseFloat(rates_cpm) * parseFloat(q));
            $("#final-cost").html(final_price.toFixed(2) + "{$setting_site_curr}");
        }
    }
</script>

{include file="./footer.tpl"}