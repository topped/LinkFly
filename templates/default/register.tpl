 +{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_24}</h1>
    </div>
    {if isset($errors)}
        {foreach $errors as $error}
            <div class="alert alert-danger">{$error}</div>
        {/foreach}
    {/if}
    {if $success}
        <div class="alert alert-success">{$lang_303}</div>
    {else}
    <div class="row">
        <div class="col-lg-9">
            {if $setting_open_registration}
            <form class="form-horizontal" method="POST" action="">
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_44}</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="name" name="username" placeholder="{$lang_44}" value="{if isset($smarty.post.username)}{$smarty.post.username}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">{$lang_66}</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" name="email" placeholder="{$lang_66}" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" required>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_45}</label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" name="password" placeholder="{$lang_45}" required>
                        <p class="help-block">{$lang_146|sprintf:$setting_min_pass_length}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_147}</label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" name="password_repeat" placeholder="{$lang_147}" required>
                    </div>
                </div>
                <hr/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_162}</label>
                    <div class="col-sm-5">
                        <img class="thumbnail" id="captcha" src="{$setting_base_url}includes/libraries/securimage/securimage_show.php" alt="CAPTCHA Image" />
                        <input type="text" class="form-control captcha-field pull-left" name="captcha" placeholder="{$lang_163}"/>
                        <a class="btn btn-primary pull-left" href="#" onclick="document.getElementById('captcha').src = '{$setting_base_url}includes/libraries/securimage/securimage_show.php?' + Math.random(); return false"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></a>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_43}</label>
                    <div class="col-sm-7">
                        <div class="checkbox">
                            <label>
                                <input name="terms" type="checkbox" required> {$lang_167} <a target="_blank" href="page_terms">{$lang_43}</a>.
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-primary">{$lang_24}</button>
                    </div>
                </div>
            </form>
            {else}
                <div class="alert alert-info">{$lang_306}</div>
            {/if}
        </div>
    </div>

    {/if}
    </div>

{include file="./footer.tpl"}