<nav class="navbar navbar-default top-nav">
    <div class="container">
        <div id="top-nav">
            <ul class="nav navbar-nav navbar nav-announcement">
                {if $setting_show_recent_announcement}
                <li>
                    <a href="{$setting_base_url}dashboard#announcements">
                        <strong>{$lang_314}: </strong>{$last_announcement}
                    </a>
                </li>
                {/if}
            </ul>
        </div>
    </div>
</nav>
<nav class="navbar navbar-default main-nav gradient-bg">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-nav" aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand logo-font" href="home">
                {if empty($setting_logo_url)}
                    <strong>{$setting_site_name}</strong>
                {else}
                    <img id="logo" src="{$smarty.const.CURRENT_TEMPLATE_NAME|string_format:$setting_logo_url}" alt="{$setting_site_name} Logo" />
                {/if}
            </a>
        </div>
        <div class="collapse navbar-collapse" id="main-nav">
            <ul class="nav navbar-nav">
                <li{if $pid==0} class="active"{/if}><a href="home"><span class="glyphicon glyphicon-link" aria-hidden="true"></span><br/> {$lang_8}</a></li>
                {if empty($smarty.session.members_id)}
                    <li{if $pid==18} class="active"{/if}><a href="page_get-paid"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span><br/> {$lang_9}</a></li>
                    <li{if $pid==17} class="active"{/if}><a href="page_start-advertising"><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span><br/> {$lang_10}</a></li>
                    <li{if $pid==16} class="active"{/if}><a href="page_about"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span><br/> {$lang_11}</a></li>
                {else}
                    <li{if $pid==7} class="active"{/if}><a href="dashboard"><span class="glyphicon glyphicon-share" aria-hidden="true"></span><br/> {$lang_27}</a></li>
                    {if $current_permission['permissions_can_advertise']}<li{if $pid==8||$pid==9||$pid==15} class="active"{/if}><a href="advertiser"><span class="glyphicon glyphicon-bell" aria-hidden="true"></span><br/> {$lang_28}</a></li>{/if}
                    <li{if $pid==10} class="active"{/if}><a href="withdrawals"><span class="glyphicon glyphicon-download" aria-hidden="true"></span><br/> {$lang_31}</a></li>
                    {if $setting_enable_referrals}<li{if $pid==16} class="active"{/if}><a href="referrals"><span class="glyphicon glyphicon-send" aria-hidden="true"></span><br/> {$lang_325}</a></li>{/if}
                {/if}
            </ul>
            <ul class="nav navbar-nav navbar-right">
                {if isset($smarty.session.members_id)}
                    {if $member_data['members_admin']}<li><a href="admin"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span><br/> {$lang_168}</a></li>{/if}
                    <li{if $pid==12} class="active"{/if}><a href="my_account"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span><br/> {$smarty.session.members_username}</a></li>
                    <li><a href="logout"><span class="glyphicon glyphicon-off" aria-hidden="true"></span><br/> {$lang_26}</a></li>
                {else}
                    <li><a href="login"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span><br/> {$lang_25}</a></li>
                    <li{if $pid==5} class="active"{/if}><a href="register"><span class="glyphicon glyphicon-user" aria-hidden="true"></span><br/> {$lang_24}</a></li>
                {/if}
            </ul>
        </div>
    </div>
</nav>