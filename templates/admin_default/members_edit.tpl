{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/members.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit Member</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Member updated!</div>
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Edit Member</h2><hr/>
                    {if $member}
                    <form class="form-horizontal" method="POST" action="">
                        <input type="hidden" class="form-control" id="member_id" name="member_id" value="{$member['members_id']}">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Username</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="username" name="username" value="{$member['members_username']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">E-Mail</label>
                            <div class="col-sm-3">
                                <input type="email" class="form-control" name="email" value="{$member['members_email']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Balance</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="balance" name="balance" value="{$member['members_balance']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Activation Code</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="activation_code" name="activation_code" value="{$member['members_activation_code']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Reset E-Mail Code</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="email_code" name="email_code" value="{$member['members_email_code']}">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">IP</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="ip" name="ip" value="{$member['members_ip']}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Status</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="status">
                                    <option value="0"{if $member['members_status']==0} selected{/if}>Not activated</option>
                                    <option value="1"{if $member['members_status']==1} selected{/if}>Activated</option>
                                    <option value="2"{if $member['members_status']==2} selected{/if}>Banned</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Administrator?</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="admin">
                                    <option value="0"{if $member['members_admin']==0} selected{/if}>No</option>
                                    <option value="1"{if $member['members_admin']==1} selected{/if}>Yes</option>
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputPermissions" class="col-sm-2 control-label">Permissions</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputPermissions" name="permissions_id">
                                    {foreach $permissions as $permission}
                                        <option value="{$permission['permissions_id']}"{if $permission['permissions_id']==$member['members_permissions_id']} selected{/if}>{$permission['permissions_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">New Password</label>
                            <div class="col-sm-3">
                                <input type="password" class="form-control" name="password">
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-2">
                                <button type="submit" class="btn btn-primary">Update Member</button>
                            </div>
                        </div>
                    </form>
                    {else}
                    <div class="alert alert-danger">Invalid member</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}