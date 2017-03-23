<div id="header" class="container-fluid">
    <div class="row">
        <div class="col-sm-2">
            <h1 id="logo-heading">
                <a href="index.php" id="logo">
                    LinkFly <span class="subtext">v{$setting_site_version} Admin Panel</span>
                </a>
            </h1>
        </div>
        <div class="col-sm-3 pull-right admin-link">
            Logged in as {$smarty.session.members_username} | <a href="{$setting_base_url}"><span class="glyphicon glyphicon-home" aria-hidden="true"></span> View Site</a> | <a href="{$setting_base_url}logout"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Logout</a>
        </div>
    </div>
</div>
<nav class="navbar navbar-default" id="main-nav">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li{if $pid==0} class="active"{/if}><a href="{$setting_base_url}admin/index.php"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span> Dashboard &#187;</a></li>
                <li{if $pid==1} class="active"{/if}><a href="{$setting_base_url}admin/general.php"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> General &#187;</a></li>
                <li{if $pid==2} class="active"{/if}><a href="{$setting_base_url}admin/links.php"><span class="glyphicon glyphicon-link" aria-hidden="true"></span> Links &#187;</a></li>
                <li{if $pid==3} class="active"{/if}><a href="{$setting_base_url}admin/members.php"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Members &#187;</a></li>
                <li{if $pid==4} class="active"{/if}><a href="{$setting_base_url}admin/campaigns.php"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span> Campaigns{if $campaigns_count>0} <span class="label label-danger">{$campaigns_count}</span>{/if} &#187;</a></li>
                <li{if $pid==5} class="active"{/if}><a href="{$setting_base_url}admin/withdrawals.php"><span class="glyphicon glyphicon-cloud-download" aria-hidden="true"></span> Withdrawals{if $withdrawals_count>0} <span class="label label-danger">{$withdrawals_count}</span>{/if} &#187;</a></li>
                <li{if $pid==6} class="active"{/if}><a href="{$setting_base_url}admin/pages.php"><span class="glyphicon glyphicon-book" aria-hidden="true"></span> Pages &#187;</a></li>
                <li{if $pid==7} class="active"{/if}><a href="{$setting_base_url}admin/miscellaneous.php"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Misc. &#187;</a></li>
                <li{if $pid==9} class="active"{/if}><a href="{$setting_base_url}admin/about.php"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> About &#187;</a></li>
            </ul>
        </div>
    </div>
</nav>