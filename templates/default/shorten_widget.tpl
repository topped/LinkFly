{if $current_permission['permissions_can_shorten']}
    {if empty($setting_base_url)}
        <div class="alert alert-warning">
            <strong>Site Warning</strong> In order for this script to function properly, the base URL has to be set in the <a href="admin">admin panel</a>.
        </div>
    {/if}
    <form class="form-inline" id="shorten-form">
        <div class="alert alert-danger" id="shorten-error" style="display:none;">
            <button type="button" class="close">×</button><p id="error-msg"></p>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="form-group full-width">
                    <input class="form-control input-lg shorten-input" type="text" id="long_url" name="long_url" placeholder="http://" required>
                </div>
            </div>
        </div>
        <div class="row collapse" id="collapseMore">
            {if $current_permission['permissions_custom_alias']}
            <div class="col-sm-4">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span> {$lang_316}</div>
                        <input type="text" class="form-control" id="custom-alias-input" name="custom_alias" placeholder="{$lang_322}">
                    </div>
                </div>
            </div>
            {/if}
            {if $current_permission['permissions_change_domain'] && count($domains) > 0}
            <div class="col-sm-4">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><span class="glyphicon glyphicon-link" aria-hidden="true"></span> {$lang_75}</div>
                        <select class="form-control" id="domain-select" name="domain-select">
                            <option value="0">{$setting_base_url}</option>
                            {foreach $domains as $domain}
                                <option value="{$domain['domains_id']}">{$domain['domains_url']}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
            {/if}
            {if $current_permission['permissions_change_ad_type']}
            <div class="col-sm-4">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon"><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span> {$lang_98}</div>
                        <select id="ad-type-select" name="ad_type" class="form-control">
                            <option value="0">{$lang_72} ({$setting_interstitial_ad_percentage}%)</option>
                            <option value="1">{$lang_73} ({$setting_banner_ad_percentage}%)</option>
                            <option value="2">{$lang_74} ({$setting_no_ad_percentage}%)</option>
                        </select>
                    </div>
                </div>
            </div>
            {/if}
        </div>
        <div class="row" id="toolbar">
            {if empty($smarty.session.members_id) && $setting_anon_link_captcha || $current_permission['permissions_need_captcha']}
                <div id="captcha-form">
                    <div class="col-sm-3">
                        <img class="thumbnail small-captcha" id="captcha" src="{$setting_base_url}includes/libraries/securimage/securimage_show.php" alt="CAPTCHA Image" />
                    </div>
                    <div class="col-sm-3">
                        <input class="form-control input-sm shorten-element" type="text" class="form-control" id="captcha-smaller-input" name="captcha" placeholder="{$lang_162}" required>
                    </div>
                </div>
            {/if}
            <div class="col-sm-3">
                <button id="shorten_button" class="btn btn-primary btn-block btn-md{if empty($smarty.session.members_id) && $setting_anon_link_captcha || $current_permission['permissions_need_captcha']} custom-margin-captcha{/if}">
                    <span id="spinner" class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> {$lang_15}
                </button>
                <button type="button" data-clipboard-target="#long_url" class="btn btn-success btn-md" style="display:none;" id="copy_button">{$lang_29}</button>
                <button type="button" class="btn btn-default btn-md" style="display:none;" id="reset_button">{$lang_338}</button>
            </div>
            {if $current_permission['permissions_custom_alias'] || $current_permission['permissions_change_domain'] || $current_permission['permissions_change_ad_type']}
            <div class="col-sm-1 extend-col{if empty($smarty.session.members_id) && $setting_anon_link_captcha || $current_permission['permissions_need_captcha']} custom-margin-captcha{/if}">
                <a id="extend_button" role="button" data-toggle="collapse" href="#collapseMore" aria-expanded="false" aria-controls="collapseMore" class="btn btn-default btn-md">
                    <span id="extend_button_chevron" class="glyphicon glyphicon-chevron-down"></span>
                </a>
            </div>
            {/if}
        </div>
        <div class="row" id="social-sharing" style="display:none;">
            <div class="col-sm-12">
                <div class="social-well">
                    <div class="row">
                        <div class="col-sm-10">
                            <h5>{$lang_295}</h5>
                            <a href="https://www.facebook.com/sharer/sharer.php?u=" target="_blank" class="btn btn-social btn-facebook">
                                <i class="fa fa-facebook"></i> {$lang_296}
                            </a>
                            <a href="https://twitter.com/home?status=" target="_blank" class="btn btn-social btn-twitter">
                                <i class="fa fa-twitter"></i> {$lang_297}
                            </a>
                            <div class="form-group">
                                <label class="html-share" for="html-code">HTML Link:</label>
                                <input type="text" class="form-control input-sm" id="html-code" value='<a href="{$setting_base_url}">{$setting_base_url}</a>'>
                            </div>
                        </div>
                        <div class="col-sm-2 text-center">
                            <div id="qrcode"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    {if empty($smarty.session.members_id)}
    <div class="subtle">{$lang_2} <a href="page_get-paid">{$lang_3}</a></div>
    <div class="text-center promo-links">
        <a href="page_about"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span> {$lang_4}</a> |
        <a href="page_start-advertising"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> {$lang_5}</a> |
        <a href="page_get-paid"><span class="glyphicon glyphicon-certificate" aria-hidden="true"></span> {$lang_6}</a>
        {if $setting_enable_ads && $pid == 0}{$setting_ad_home}{/if}
    </div>
    {/if}
{else}
    <div class="alert alert-info">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> {$lang_19}
    </div>
{/if}
<script type="text/javascript">
    $(document).ready(function() {
        var clipboard = new Clipboard('#copy_button');
        clipboard.on('success', function(e) {
            $('#copy_button').html('<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> {$lang_324}');
            e.clearSelection();
        });
        $('#copy_button,#spinner').hide();
        $('#shorten-form').submit(function(e) {
            $.ajax({
                type: 'POST',
                url: 'api.php',
                data: "long_url=" + $("#long_url").val(){if empty($smarty.session.members_id) && $setting_anon_link_captcha || $current_permission['permissions_need_captcha']} + "&captcha=" + $("#captcha-smaller-input").val(){/if}{if $current_permission['permissions_custom_alias']} + "&alias=" + $("#custom-alias-input").val(){/if}{if $current_permission['permissions_change_domain']} + "&domain=" + $("#domain-select").val(){/if}{if $current_permission['permissions_change_ad_type']} + "&ad_type=" + $("#ad-type-select").val(){/if},
                dataType: 'json',
                beforeSend: function() {
                    $('#shorten-error').hide();
                    $('#spinner').show();
                },
                complete: function() {
                    $("#spinner").hide();
                },
                success: function(data) {
                    $('#long_url').val(data.short_url);
                    $('#shorten_button,#captcha-form').fadeOut().hide();
                    $('#copy_button,#social-sharing,#reset_button').fadeIn().show();
                    $('.btn-facebook').attr("href", $(".btn-facebook").attr("href") + data.short_url);
                    $('#html-code').val('<a href="' + data.short_url + '">Click here</a>');
                    $('.btn-twitter').attr("href", $(".btn-twitter").attr("href")+"{$lang_298}" + data.short_url);
                    {literal}$('#qrcode').qrcode({width: 80,height: 80,text: data.short_url});{/literal}
                },
                error: function (response) {
                    var msg = JSON.parse(response.responseText).msg;
                    $('#error-msg').html('<span class="glyphicon glyphicon-exclamation-sign"></span> ' + msg);
                    $('#shorten-error').fadeIn();
                    $('#captcha').attr('src', '{$setting_base_url}includes/libraries/securimage/securimage_show.php');
                    $('#captcha-smaller-input').val('');
                }
            });
            e.preventDefault();
        });
        $('#reset_button').on('click', function(e) {
            $('#copy_button').html('{$lang_29}');
            $('#shorten_button,#captcha-form').fadeIn().show();
            $('#social-sharing,#reset_button,#copy_button').fadeOut().hide();
            $('#long_url,#captcha-smaller-input').val('');
            $('#qrcode').empty();
            $('#captcha').attr('src', '{$setting_base_url}includes/libraries/securimage/securimage_show.php');
        });
        $('#long_url,#html-code').focus(function() {
            var $this = $(this);
            $this.select();
            $this.mouseup(function() {
                $this.unbind('mouseup');
                return false;
            });
        });
        $('.alert .close').on('click', function(e) {
            $(this).parent().hide();
        });
        $('#collapseMore').on('shown.bs.collapse', function () {
            $("#extend_button_chevron").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
        });
        $('#collapseMore').on('hidden.bs.collapse', function () {
            $("#extend_button_chevron").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
        });
    });
</script>