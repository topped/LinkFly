{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/members.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit Permission</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Permission updated!</div>
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Edit Permission</h2><hr/>
                    {if $permission}
                    <form class="form-horizontal" method="POST" action="">
                        <input type="hidden" class="form-control" id="permission_id" name="permission_id" value="{$permission['permissions_id']}">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Name</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="name" name="name" value="{$permission['permissions_name']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputRequiresAccount" class="col-sm-2 control-label">Requires Account</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputRequiresAccount" name="need_account">
                                    <option value="0"{if $permission['permissions_need_account']==0} selected{/if}>No</option>
                                    <option value="1"{if $permission['permissions_need_account']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanShorten" class="col-sm-2 control-label">Can Shorten</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanShorten" name="can_shorten">
                                    <option value="0"{if $permission['permissions_can_shorten']==0} selected{/if}>No</option>
                                    <option value="1"{if $permission['permissions_can_shorten']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanAdvertise" class="col-sm-2 control-label">Can Advertise</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanAdvertise" name="can_advertise">
                                    <option value="0"{if $permission['permissions_can_advertise']==0} selected{/if}>No</option>
                                    <option value="1"{if $permission['permissions_can_advertise']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputNeedCaptcha" class="col-sm-2 control-label">Requires CAPTCHA</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputNeedCaptcha" name="need_captcha">
                                    <option value="0"{if $permission['permissions_need_captcha']==0} selected{/if}>No</option>
                                    <option value="1"{if $permission['permissions_need_captcha']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCustomAlias" class="col-sm-2 control-label">Custom Alias</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCustomAlias" name="custom_alias">
                                    <option value="0"{if $permission['permissions_custom_alias']==0} selected{/if}>No</option>
                                    <option value="1"{if $permission['permissions_custom_alias']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanChangeDomain" class="col-sm-2 control-label">Can Change Domain</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanChangeDomain" name="change_domain">
                                    <option value="0"{if $permission['permissions_change_domain']==0} selected{/if}>No</option>
                                    <option value="1"{if $permission['permissions_change_domain']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputCanChangeAdType" class="col-sm-2 control-label">Can Change Ad Type</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputCanChangeAdType" name="change_ad_type">
                                    <option value="0"{if $permission['permissions_change_ad_type']==0} selected{/if}>No</option>
                                    <option value="1"{if $permission['permissions_change_ad_type']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Link Waiting Time (seconds)</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="link_waiting_time_sec" name="link_waiting_time_sec" value="{$permission['permissions_link_waiting_time_sec']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Spam Waiting Time (seconds)</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="spam_waiting_time" name="spam_waiting_time" value="{$permission['permissions_spam_waiting_time']}">
                                <span id="helpBlock" class="help-block">Cool down time before users can continue posting links. 0 = Unlimited</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-2">
                                <button type="submit" class="btn btn-primary">Update Permission</button>
                            </div>
                        </div>
                    </form>
                    {else}
                    <div class="alert alert-danger">Invalid permission</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}