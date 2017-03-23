{include file="./header.tpl"}
<style type="text/css">.logo-font img { margin-top:-20px;width:120px !important; } .banner-campaign {  width: {$setting_banner_width}px !important;  height: {$setting_banner_height}px !important; margin-top:10%; }</style>
<nav class="navbar navbar-default navbar-fixed-top campaign-bar" role="navigation">
    <div class="container-fixed">
        <div class="navbar-header pull-left">
            <a class="navbar-brand logo-font" href="home">
                {if empty($setting_logo_url)}
                    <strong>{$setting_site_name}</strong>
                {else}
                    <img id="logo" src="{$smarty.const.CURRENT_TEMPLATE_NAME|string_format:$setting_logo_url}" alt="{$setting_site_name} Logo" />
                {/if}
            </a>
            <ul class="nav navbar-nav navbar">
                <li><a href="{$setting_base_url}">{$lang_7}</a></li>
                <li>
                    {if $setting_enable_ads}<div class="text-center">{$setting_ad_view_link}</div>{/if}
                </li>
            </ul>
        </div>
        <div class="navbar-header pull-right">
            <ul class="nav navbar-nav navbar-right">
                <input type="hidden" id="suffix" value="{$smarty.get.s}" />
                <li id="button-bar">
                    <noscript><strong>To continue, please turn on JavaScript in your browser and refresh this page.</strong></noscript>
                    <a id="wait_button" role="button" type="button" class="btn btn-continue btn-warning navbar-btn fixed-height-btn">{$lang_37}</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid campaign-container text-center">
    <iframe id="iframe-campaign" class="interstitial-iframe{if $campaign_data['campaigns_type']==1} banner-campaign{/if}" src="{$campaign_data['campaigns_website_url']}">
    </iframe>
</div>
<script type="text/javascript">{literal}$(document).ready(function(){(new Countdown({seconds:{/literal}{$current_permission['permissions_link_waiting_time_sec']}{literal},onUpdateStatus:function(a){$("#wait_button").text({/literal}"{$lang_35}... "{literal}+a)},onCounterEnd:function(){$("#wait_button").remove();$.ajax({type:"POST",url:"api.php",data:"suffix="+$("#suffix").val(),dataType:"json",error:function(b){var msg = JSON.parse(b.responseText).msg;alert(msg);},success:function(a){a=a.long_url;$("#button-bar").html('<a id="skip_button" href="'+a+'" role="button" type="button" class="btn btn-default btn-skip navbar-btn fixed-height-btn">{/literal}{$lang_36}{literal} &#187; </a>')}})}})).start()}); function Countdown(a){function d(){e(b);0===b&&(f(),g.stop());b--}var c,g=this,b=a.seconds,e=a.onUpdateStatus||function(){},f=a.onCounterEnd||function(){};this.start=function(){clearInterval(c);c=0;b=a.seconds;c=setInterval(d,1E3)};this.stop=function(){clearInterval(c)}};{/literal}</script>
{include file="./footer.tpl"}