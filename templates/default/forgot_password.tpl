{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_47} <small>{$lang_141}</small></h1>
    </div>

    <div class="row">
        {if count($errors) > 0}
            {foreach $errors as $error}
                <div class="alert alert-danger">{$error}</div>
            {/foreach}
        {else}
            {if isset($smarty.post.email)}
                <div class="alert alert-success">{$lang_142}</div>
            {/if}
        {/if}
        {if $step == 1}
        <form class="form-horizontal" method="POST" action="forgot_password">
            <div class="form-group">
                <label for="inputEmail3" class="col-sm-2 control-label">{$lang_66}</label>
                <div class="col-sm-3">
                    <input type="email" class="form-control" name="email" placeholder="{$lang_66}" required>
                    <p class="help-block">{$lang_143}</p>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">{$lang_144}</button>
                </div>
            </div>
        </form>
        {else}
            <form class="form-horizontal" method="POST" action="forgot_password">
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_145}</label>
                    <div class="col-sm-3">
                        <input type="password" class="form-control" name="password" placeholder="New password" required>
                        <p class="help-block">{$lang_146|sprintf:$setting_min_pass_length}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">{$lang_147}</label>
                    <div class="col-sm-3">
                        <input type="password" class="form-control" name="password_repeat" placeholder="{$lang_147}" required>
                    </div>
                </div>
                <input type="hidden" name="reset_code" value="{$reset_code}" />
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-primary">{$lang_144}</button>
                    </div>
                </div>
            </form>
        {/if}
    </div>

</div>

{include file="./footer.tpl"}