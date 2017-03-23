{include file="./header.tpl"}

<div class="container">

    <form class="form-signin panel panel-default margin-15" method="POST" action="login">
        <div class="text-center">
            {if empty($setting_logo_url_alt)}
                <strong>{$setting_site_name}</strong>
            {else}
                <a href="home"><img class="logo-alt" src="{$smarty.const.CURRENT_TEMPLATE_NAME|string_format:$setting_logo_url_alt}" alt="{$setting_site_name} Logo" /></a>
            {/if}
            <hr/>
            <h3 class="page-header">{$lang_25}</h3>
        </div>
        <div class="panel-body">
            {if $login_error_code != false}
                <div class="alert alert-danger">{if $login_error_code == 2}{$lang_16}{else}{$lang_17}{/if}</div>
            {/if}
            {if isset($smarty.get.pr)}
                <div class="alert alert-success">{$lang_48}</div>
            {/if}
            {if $activated}
                <div class="alert alert-success">{$lang_139}</div>
            {/if}
            <label for="inputUsername" class="sr-only">{$lang_44}</label>
            <input type="text" name="username" id="inputUsername" class="form-control" placeholder="{$lang_44}" required autofocus>
            <label for="inputPassword" class="sr-only">{$lang_45}</label>
            <input type="password" name="password" id="inputPassword" class="form-control" placeholder="{$lang_45}" required>
           <!-- <div class="checkbox">
                <label>
                    <input name="remember_me" id="rememberMeCheckbox" type="checkbox"> {$lang_46}
                </label>
            </div> -->
            <button class="btn btn-md btn-primary btn-block" type="submit">{$lang_25}</button>
            <a href="{$setting_base_url}register" class="btn btn-md btn-default btn-block">{$lang_140}</a>
            <div class="text-center margin-15">
                <a href="forgot_password">{$lang_47}</a>
            </div>
        </div>
    </form>

</div>

{include file="./footer.tpl"}