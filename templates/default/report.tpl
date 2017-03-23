{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_51} <small>{$lang_148}</small></h1>
    </div>
    {if isset($errors)}
        {foreach $errors as $error}
            <div class="alert alert-danger">{$error}</div>
        {/foreach}
    {/if}
    {if $success}
        <div class="alert alert-success">{$lang_149}</div>
    {else}
    <div class="row">
        <div class="col-lg-12">
            <form class="form-horizontal" method="POST" action="">
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_150}</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" name="email" placeholder="{$lang_150}" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" required>
                        <p class="help-block">{$lang_151}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">{$lang_152}</label>
                    <div class="col-sm-4">
                        <select name="topic" class="form-control">
                            <option value="0"{if isset($smarty.post.topic) && $smarty.post.topic == 0} selected{/if}>{$lang_153}</option>
                            <option value="1"{if isset($smarty.post.topic) && $smarty.post.topic == 1} selected{/if}>{$lang_154}</option>
                            <option value="2"{if isset($smarty.post.topic) && $smarty.post.topic == 2} selected{/if}>{$lang_155}</option>
                            <option value="3"{if isset($smarty.post.topic) && $smarty.post.topic == 3} selected{/if}>{$lang_156}</option>
                            <option value="4"{if isset($smarty.post.topic) && $smarty.post.topic == 4} selected{/if}>{$lang_157}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_158}</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="url" value="{if isset($smarty.post.url)}{$smarty.post.url}{/if}" placeholder="{$lang_158}">
                        <p class="help-block">{$lang_159}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">{$lang_160}</label>
                    <div class="col-sm-4">
                        <textarea name="desc" class="form-control" required>{if isset($smarty.post.desc)}{$smarty.post.desc}{/if}</textarea>
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
                        <button type="submit" class="btn btn-primary">{$lang_164}</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    {/if}
</div>

{include file="./footer.tpl"}