<div class="wide">
    <div class="logo">

        <h1 class="animated fadeIn">{$setting_site_name|string_format:$lang_0}</h1>
        <h2 class="animated fadeIn spacing">{$lang_1}</h2>

        <div class="row no-margin">
            <div class="well shorten-well col-lg-6 col-lg-offset-3">
                {if $setting_enable_ads}<div class="row text-center">{$setting_ad_home}</div>{/if}
                {include file="./shorten_widget.tpl"}
            </div>
        </div>

    </div>
</div>