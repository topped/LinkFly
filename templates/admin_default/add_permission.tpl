{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/members.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Permission</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Add Permission</h2><hr/>
                    {if $success}
                        <div class="alert alert-success">Permission added!</div>
                    {/if}
                    {if count($errors) > 0}
                        {foreach $errors as $error}
                            <div class="alert alert-danger">{$error}</div>
                        {/foreach}
                    {/if}
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Name</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="name" name="name" value="{if isset($smarty.post.name)}{$smarty.post.name}{/if}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputRequiresAccount" class="col-sm-2 control-label">Requires Account</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputRequiresAccount" name="need_account">
                                    <option value="0"{if isset($smarty.post.need_account)}{if $smarty.post.need_account == 0} selected{/if}{/if}>No</option>
                                    <option value="1"{if isset($smarty.post.need_account)}{if $smarty.post.need_account == 1} selected{/if}{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanShorten" class="col-sm-2 control-label">Can Shorten</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanShorten" name="can_shorten">
                                    <option value="0"{if isset($smarty.post.can_shorten)}{if $smarty.post.can_shorten == 0} selected{/if}{/if}>No</option>
                                    <option value="1"{if isset($smarty.post.can_shorten)}{if $smarty.post.can_shorten == 1} selected{/if}{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanAdvertise" class="col-sm-2 control-label">Can Advertise</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanAdvertise" name="can_advertise">
                                    <option value="0"{if isset($smarty.post.can_advertise)}{if $smarty.post.can_advertise == 0} selected{/if}{/if}>No</option>
                                    <option value="1"{if isset($smarty.post.can_advertise)}{if $smarty.post.can_advertise == 1} selected{/if}{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputNeedCaptcha" class="col-sm-2 control-label">Requires CAPTCHA</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputNeedCaptcha" name="need_captcha">
                                    <option value="0"{if isset($smarty.post.need_captcha)}{if $smarty.post.need_captcha == 0} selected{/if}{/if}>No</option>
                                    <option value="1"{if isset($smarty.post.need_captcha)}{if $smarty.post.need_captcha == 1} selected{/if}{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCustomAlias" class="col-sm-2 control-label">Custom Alias</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCustomAlias" name="custom_alias">
                                    <option value="0"{if isset($smarty.post.custom_alias)}{if $smarty.post.custom_alias == 0} selected{/if}{/if}>No</option>
                                    <option value="1"{if isset($smarty.post.custom_alias)}{if $smarty.post.custom_alias == 1} selected{/if}{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanChangeDomain" class="col-sm-2 control-label">Can Change Domain</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanChangeDomain" name="change_domain">
                                    <option value="0"{if isset($smarty.post.change_domain)}{if $smarty.post.change_domain == 0} selected{/if}{/if}>No</option>
                                    <option value="1"{if isset($smarty.post.change_domain)}{if $smarty.post.change_domain == 1} selected{/if}{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanChangeAdType" class="col-sm-2 control-label">Can Change Ad Type</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanChangeAdType" name="change_ad_type">
                                    <option value="0"{if isset($smarty.post.change_ad_type)}{if $smarty.post.change_ad_type == 0} selected{/if}{/if}>No</option>
                                    <option value="1"{if isset($smarty.post.change_ad_type)}{if $smarty.post.change_ad_type == 1} selected{/if}{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Link Waiting Time (seconds)</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="link_waiting_time_sec" name="link_waiting_time_sec" value="{if isset($smarty.post.link_waiting_time_sec)}{$smarty.post.link_waiting_time_sec}{/if}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Spam Waiting Time (seconds)</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="spam_waiting_time" name="spam_waiting_time" value="{if isset($smarty.post.spam_waiting_time)}{$smarty.post.spam_waiting_time}{/if}">
                                <span id="helpBlock" class="help-block">Cool down time before users can continue posting links. 0 = Unlimited</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-2">
                                <button type="submit" class="btn btn-primary">Add Permission</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}