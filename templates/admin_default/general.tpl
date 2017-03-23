{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> General</a></li>
                <li role="presentation"><a aria-controls="payment" role="tab" data-toggle="tab" href="#payment"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span> Payment</a></li>
                <li role="presentation"><a aria-controls="meta" role="tab" data-toggle="tab" href="#meta"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Meta</a></li>
                <li role="presentation"><a aria-controls="analytics" role="tab" data-toggle="tab" href="#analytics"><span class="glyphicon glyphicon-tasks" aria-hidden="true"></span> Analytics</a></li>
                <li role="presentation"><a aria-controls="ads" role="tab" data-toggle="tab" href="#ads"><span class="glyphicon glyphicon-certificate" aria-hidden="true"></span> Ads</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid">
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
                    <h2>General</h2><hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Site Name</label>
                            <div class="col-sm-3">
                                <input name="site_name" value="{if isset($smarty.post.site_name)}{$smarty.post.site_name}{else}{$setting_site_name}{/if}" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Base URL</label>
                            <div class="col-sm-3">
                                <input name="base_url" value="{if isset($smarty.post.base_url)}{$smarty.post.base_url}{else}{$setting_base_url}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">Directory where index.php is located. Ensure it ends with a trailing slash (<em>/</em>)!</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="show_language_picker" value="0">
                                        <input name="show_language_picker" type="checkbox"{if isset($smarty.post.show_language_picker)}{if $smarty.post.show_language_picker == "on"} checked{/if}{else}{if $setting_show_language_picker} checked{/if}{/if}> Show language picker
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Default Language</label>
                            <div class="col-sm-3">
                                <select name="site_lang" class="form-control">
                                    {foreach $all_langs as $language}
                                        <option value="{$language}"{if isset($smarty.post.site_lang)}{if $smarty.post.site_lang == $language} selected{/if}{else}{if $setting_site_lang==$language} selected{/if}{/if}>{$language|capitalize}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Timezone</label>
                            <div class="col-sm-3">
                                <input name="timezone" value="{if isset($smarty.post.timezone)}{$smarty.post.timezone}{else}{$setting_timezone}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The global timezone used on the site. Refer to <a href="http://php.net/manual/en/timezones.php">this</a> to find the correct PHP-supported timezone (example: <em>America/Chicago</em>).</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Template</label>
                            <div class="col-sm-3">
                                <select name="template" class="form-control">
                                    {foreach $templates as $ttemplate}
                                        <option value="{$ttemplate}"{if isset($smarty.post.template)}{if $smarty.post.template == $ttemplate} selected{/if}{else}{if $setting_template==$ttemplate} selected{/if}{/if}>{$ttemplate|capitalize}</option>
                                    {/foreach}
                                </select>
                                <span id="helpBlock" class="help-block">The main appearance of your LinkFly installation. Templates placed in the 'templates' folder can be selected here.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Logo URL</label>
                            <div class="col-sm-3">
                                <input name="logo_url" value="{if isset($smarty.post.logo_url)}{$smarty.post.logo_url}{else}{$setting_logo_url}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">%s = Current template name</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Logo URL - Alternative</label>
                            <div class="col-sm-3">
                                <input name="logo_url_alt" value="{if isset($smarty.post.logo_url_alt)}{$smarty.post.logo_url_alt}{else}{$setting_logo_url_alt}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">Alternative logo used on the login page</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Statistics Graph - Fill Color (Hex)</label>
                            <div class="col-sm-3">
                                <input name="graph_fill_color" value="{if isset($smarty.post.graph_fill_color)}{$smarty.post.graph_fill_color}{else}{$setting_graph_fill_color}{/if}" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Statistics Graph - Stroke Color (Hex)</label>
                            <div class="col-sm-3">
                                <input name="graph_stroke_color" value="{if isset($smarty.post.graph_stroke_color)}{$smarty.post.graph_stroke_color}{else}{$setting_graph_stroke_color}{/if}" type="text" class="form-control">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">E-Mail 'From' Header</label>
                            <div class="col-sm-3">
                                <input name="email_from" value="{if isset($smarty.post.email_from)}{$smarty.post.email_from}{else}{$setting_email_from}{/if}" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Title Separator</label>
                            <div class="col-sm-3">
                                <input name="header_separator" value="{if isset($smarty.post.header_separator)}{$smarty.post.header_separator}{else}{$setting_header_separator}{/if}" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Copyright Footer</label>
                            <div class="col-sm-3">
                                <textarea name="footer_copyright" class="form-control">{if isset($smarty.post.footer_copyright)}{$smarty.post.footer_copyright}{else}{$setting_footer_copyright}{/if}</textarea>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="is_maintenance" value="0">
                                        <input name="is_maintenance" type="checkbox"{if isset($smarty.post.is_maintenance)}{if $smarty.post.is_maintenance == "on"} checked{/if}{else}{if $setting_is_maintenance} checked{/if}{/if}> Maintenance mode
                                        <span id="helpBlock" class="help-block">If checked, the main site will be in maintenance mode. Admins will still have full access to the site.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="show_recent_announcement" value="0">
                                        <input name="show_recent_announcement" type="checkbox"{if isset($smarty.post.show_recent_announcement)}{if $smarty.post.show_recent_announcement == "on"} checked{/if}{else}{if $setting_show_recent_announcement} checked{/if}{/if}> Show most recent announcement
                                        <span id="helpBlock" class="help-block">If checked, the most recent announcement will be displayed in the top navigation bar.</span>
                                    </label>
                                </div>
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
                <div role="tabpanel" class="tab-pane fade" id="payment">
                    <h2>Payment</h2><hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="payment_allow_paypal" value="0">
                                        <input name="payment_allow_paypal" type="checkbox"{if isset($smarty.post.payment_allow_paypal)}{if $smarty.post.payment_allow_paypal == "on"} checked{/if}{else}{if $setting_payment_allow_paypal} checked{/if}{/if}> Use PayPal
                                    </label>
                                </div>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="payment_test_mode" value="0">
                                        <input name="payment_test_mode" type="checkbox"{if isset($smarty.post.payment_test_mode)}{if $smarty.post.payment_test_mode == "on"} checked{/if}{else}{if $setting_payment_test_mode} checked{/if}{/if}> Payment Test Mode/Sandbox Mode
                                        <span id="helpBlock" class="help-block">Activates PayPal's sandbox mode.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Site Currency</label>
                            <div class="col-sm-3">
                                <select name="site_curr" id="site_curr" class="form-control">
                                    <option value="AUD">Australian Dollar</option>
                                    <option value="BRL">Brazilian Real </option>
                                    <option value="CAD">Canadian Dollar</option>
                                    <option value="CZK">Czech Koruna</option>
                                    <option value="DKK">Danish Krone</option>
                                    <option value="EUR">Euro</option>
                                    <option value="HKD">Hong Kong Dollar</option>
                                    <option value="HUF">Hungarian Forint </option>
                                    <option value="ILS">Israeli New Sheqel</option>
                                    <option value="JPY">Japanese Yen</option>
                                    <option value="MYR">Malaysian Ringgit</option>
                                    <option value="MXN">Mexican Peso</option>
                                    <option value="NOK">Norwegian Krone</option>
                                    <option value="NZD">New Zealand Dollar</option>
                                    <option value="PHP">Philippine Peso</option>
                                    <option value="PLN">Polish Zloty</option>
                                    <option value="GBP">Pound Sterling</option>
                                    <option value="SGD">Singapore Dollar</option>
                                    <option value="SEK">Swedish Krona</option>
                                    <option value="CHF">Swiss Franc</option>
                                    <option value="TWD">Taiwan New Dollar</option>
                                    <option value="THB">Thai Baht</option>
                                    <option value="TRY">Turkish Lira</option>
                                    <option value="USD"">U.S. Dollar</option>
                                </select>
                                <span id="helpBlock" class="help-block"><strong>IMPORTANT:</strong> Changing the currency will not convert any values, but only change the labeling.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Currency Code Position</label>
                            <div class="col-sm-3">
                                <select name="curr_code_pos" id="curr_code_pos" class="form-control">
                                    <option value="0">Before (e.g. USD $20)</option>
                                    <option value="1">After (e.g. $20 USD)</option>
                                    <option value="2">Hide</option>
                                </select>
                                <span id="helpBlock" class="help-block">Position of the currency code.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Currency Symbol Position</label>
                            <div class="col-sm-3">
                                <select name="curr_symbol_pos" id="curr_symbol_pos" class="form-control">
                                    <option value="0">Before (e.g. $20)</option>
                                    <option value="1">After (e.g. 20‎€)</option>
                                    <option value="2">Hide</option>
                                </select>
                                <span id="helpBlock" class="help-block">Position of the currency symbol.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Currency Symbol</label>
                            <div class="col-sm-3">
                                <input name="curr_symbol" value="{if isset($smarty.post.curr_symbol)}{$smarty.post.curr_symbol}{else}{$setting_curr_symbol}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The symbol for your currency (e.g. $).</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">PayPal E-Mail</label>
                            <div class="col-sm-3">
                                <input name="paypal_email" value="{if isset($smarty.post.paypal_email)}{$smarty.post.paypal_email}{else}{$setting_paypal_email}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The PayPal e-mail address through which payments are processed.</span>
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
                <div role="tabpanel" class="tab-pane fade" id="meta">
                    <h2>Meta</h2><hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Meta Description</label>
                            <div class="col-sm-3">
                                <textarea name="meta_desc" class="form-control">{if isset($smarty.post.meta_desc)}{$smarty.post.meta_desc}{else}{$setting_meta_desc}{/if}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Meta Author</label>
                            <div class="col-sm-3">
                                <textarea name="meta_author" class="form-control">{if isset($smarty.post.meta_author)}{$smarty.post.meta_author}{else}{$setting_meta_author}{/if}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Meta Keywords</label>
                            <div class="col-sm-3">
                                <textarea name="meta_keywords" class="form-control">{if isset($smarty.post.meta_keywords)}{$smarty.post.meta_keywords}{else}{$setting_meta_keywords}{/if}</textarea>
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
                <div role="tabpanel" class="tab-pane fade" id="analytics">
                    <h2>Analytics</h2><hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Analytics Code</label>
                            <div class="col-sm-3">
                                <textarea name="analytics_code" class="form-control">{if isset($smarty.post.analytics_code)}{$smarty.post.analytics_code}{else}{$setting_analytics_code}{/if}</textarea>
                                <span id="helpBlock" class="help-block">Place your JavaScript analytics code here - e.g. Google Analytics code.</span>
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
                <div role="tabpanel" class="tab-pane fade" id="ads">
                    <h2>Ads</h2><hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="enable_ads" value="0">
                                        <input name="enable_ads" type="checkbox"{if isset($smarty.post.enable_ads)}{if $smarty.post.enable_ads == "on"} checked{/if}{else}{if $setting_enable_ads} checked{/if}{/if}> Enable ads
                                        <span id="helpBlock" class="help-block">Choose to display ads on your site.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Home Ad</label>
                            <div class="col-sm-3">
                                <textarea name="ad_home" class="form-control">{if isset($smarty.post.ad_home)}{$smarty.post.ad_home}{else}{$setting_ad_home}{/if}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Publisher Ad</label>
                            <div class="col-sm-3">
                                <textarea name="ad_publisher" class="form-control">{if isset($smarty.post.ad_publisher)}{$smarty.post.ad_publisher}{else}{$setting_ad_publisher}{/if}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Advertiser Ad</label>
                            <div class="col-sm-3">
                                <textarea name="ad_advertiser" class="form-control">{if isset($smarty.post.ad_advertiser)}{$smarty.post.ad_advertiser}{else}{$setting_ad_advertiser}{/if}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Statistics Ad</label>
                            <div class="col-sm-3">
                                <textarea name="ad_stats" class="form-control">{if isset($smarty.post.ad_stats)}{$smarty.post.ad_stats}{else}{$setting_ad_stats}{/if}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">View Link Ad</label>
                            <div class="col-sm-3">
                                <textarea name="ad_view_link" class="form-control">{if isset($smarty.post.ad_view_link)}{$smarty.post.ad_view_link}{else}{$setting_ad_view_link}{/if}</textarea>
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

<script type="text/javascript">
    $(document).ready(function() {
        $("#site_curr").val("{if isset($smarty.post.site_curr)}{$smarty.post.site_curr}{else}{$setting_site_curr}{/if}");
        $("#curr_symbol_pos").val("{if isset($smarty.post.curr_symbol_pos)}{$smarty.post.curr_symbol_pos}{else}{$setting_curr_symbol_pos}{/if}");
        $("#curr_code_pos").val("{if isset($smarty.post.curr_code_pos)}{$smarty.post.curr_code_pos}{else}{$setting_curr_code_pos}{/if}");
    });
</script>

{include file="./footer.tpl"}