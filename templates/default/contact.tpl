{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_61}</h1>
    </div>
    {if isset($errors)}
        {foreach $errors as $error}
            <div class="alert alert-danger">{$error}</div>
        {/foreach}
    {/if}
    {if $success}
        <div class="alert alert-success">{$lang_165}</div>
    {else}
    <div class="row">
        <div class="col-lg-12">
            <form class="form-horizontal" method="POST" action="">
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_150}</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" name="email" placeholder="{$lang_150}" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_158}</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="url" value="{if isset($smarty.post.url)}{$smarty.post.url}{/if}" placeholder="{$lang_158}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">{$lang_160}</label>
                    <div class="col-sm-4">
                        <textarea style="width:450px;height:100px" name="desc" class="form-control" placeholder="Description" required>{if isset($smarty.post.desc)}{$smarty.post.desc}{/if}</textarea>
                        <p class="help-block">{$lang_161}</p>
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
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-primary">{$lang_166}</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    {/if}
</div>

{include file="./footer.tpl"}