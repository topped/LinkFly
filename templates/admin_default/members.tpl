{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Members</a></li>
                <li role="presentation"><a aria-controls="permissions" role="tab" data-toggle="tab" href="#permissions"><span class="glyphicon glyphicon-lock" aria-hidden="true"></span> Permissions</a></li>
                <li role="presentation"><a aria-controls="members_settings" role="tab" data-toggle="tab" href="#members_settings"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Settings</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Members updated!</div>
                {/if}
                {if count($errors) > 0}
                    {foreach $errors as $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/foreach}
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                <h2>Members</h2><hr/>
                <table id="members_table" class="table table-bordered table-hover table-striped">
                    <thead>
                    <th>ID</th>
                    <th>Username</th>
                    <th>E-Mail</th>
                    <th>Status</th>
                    <th>Admin</th>
                    <th>Balance</th>
                    <th>Permissions</th>
                    <th>IP</th>
                    <th>Joined</th>
                    <th></th>
                    <th></th>
                    </thead>
                    <tfoot>
                    <th>ID</th>
                    <th>Username</th>
                    <th>E-Mail</th>
                    <th>Status</th>
                    <th>Admin</th>
                    <th>Balance</th>
                    <th>Permissions</th>
                    <th>IP</th>
                    <th>Joined</th>
                    <th>Delete</th>
                    <th>Edit</th>
                    </tfoot>
                    <tbody>
                    {foreach $members as $member}
                        <tr{if $member['members_status']==2} class="danger"{/if}>
                            <td>{$member['members_id']}</td>
                            <td>{$member['members_username']}</td>
                            <td><a href="mailto:{$member['members_email']}">{$member['members_email']}</a></td>
                            <td>{if $member['members_status']==0}Not activated{elseif $member['members_status']==1}Activated{else}Banned{/if}</td>
                            <td>{if $member['members_admin']==1}Admin{else}User{/if}</td>
                            <td>{format_price value=$member['members_balance']}</td>
                            <td>{$member['permissions_name']}</td>
                            <td><a target="_blank" href="http://www.ip-tracker.org/locator/ip-lookup.php?ip={$member['members_ip']}">{$member['members_ip']}</a></td>
                            <td>{$member['members_added']}</td>
                            <td>
                                {if $member['members_id'] != $smarty.session.members_id}
                                    <form id="delete_form_{$member['members_id']}" class="member-delete" method="POST" action="">
                                        <input type="hidden" name="delete_id" value="{$member['members_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
                                {else}<em>(Logged in)</em>
                                {/if}
                            </td>
                            <td>
                                <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/members_edit.php?member_id={$member['members_id']}">Edit</a>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
                <div role="tabpanel" class="tab-pane fade" id="permissions">
                    <h2>Permissions</h2>
                    <hr/>
                    <div class="button-bar">
                        <a href="{$setting_base_url}admin/add_permission.php" class="btn btn-success"><span class="glyphicon glyphicon-plus aria-hidden="true"></span> Add Permission</a>
                    </div>
                    <table id="permissions_table" class="table table-bordered table-hover table-striped">
                        <thead>
                        <th>Name</th>
                        <th>Account Required</th>
                        <th>Can Shorten</th>
                        <th>Can Advertise</th>
                        <th>Requires CAPTCHA</th>
                        <th>Custom Alias</th>
                        <th>Can Change Domain</th>
                        <th>Can Change Ad Type</th>
                        <th>Link Waiting Time</th>
                        <th>Spam Waiting Time</th>
                        <th>Delete</th>
                        </thead>
                        <tbody>
                        {foreach $permissions as $permission}
                            <tr>
                                <td>{$permission['permissions_name']}</td>
                                <td>{if $permission['permissions_need_account']==1}Yes{else}No{/if}</td>
                                <td>{if $permission['permissions_can_shorten']==1}Yes{else}No{/if}</td>
                                <td>{if $permission['permissions_can_advertise']==1}Yes{else}No{/if}</td>
                                <td>{if $permission['permissions_need_captcha']==1}Yes{else}No{/if}</td>
                                <td>{if $permission['permissions_custom_alias']==1}Yes{else}No{/if}</td>
                                <td>{if $permission['permissions_change_domain']==1}Yes{else}No{/if}</td>
                                <td>{if $permission['permissions_change_ad_type']==1}Yes{else}No{/if}</td>
                                <td>{$permission['permissions_link_waiting_time_sec']} seconds</td>
                                <td>{$permission['permissions_spam_waiting_time']} seconds</td>
                                <td>
                                    <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/permissions_edit.php?permission_id={$permission['permissions_id']}">Edit</a>
                                    <form id="delete_form_{$permission['permissions_id']}" class="permission-delete delete-form" method="POST" action="">
                                        <input type="hidden" name="delete_permission" value="{$permission['permissions_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="members_settings">
                    <h2>Settings</h2>
                    <hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="enable_ads" value="0">
                                        <input name="enable_ads" type="checkbox"{if isset($smarty.post.open_registration)}{if $smarty.post.open_registration == "on"} checked{/if}{else}{if $setting_open_registration} checked{/if}{/if}> Allow sign-ups
                                        <span id="helpBlock" class="help-block">Determines if visitors can create accounts on your LinkFly installation.</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Minimum Password Length</label>
                            <div class="col-sm-3">
                                <input name="min_pass_length" value="{if isset($smarty.post.min_pass_length)}{$smarty.post.min_pass_length}{else}{$setting_min_pass_length}{/if}" type="text" class="form-control">
                                <span id="helpBlock" class="help-block">The minimum required length for passwords for registering members.</span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <label for="inputPermissionsForFree" class="col-sm-2 control-label">Default permissions for accounts</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputPermissionsForFree" name="default_permission_user">
                                    {foreach $permissions as $permission}
                                        <option value="{$permission['permissions_id']}"{if isset($smarty.post.default_permission_user)}{if $smarty.post.default_permission_user == $permission['permissions_id']} selected{/if}{elseif $permission['permissions_id']==$setting_default_permission_user} selected{/if}>{$permission['permissions_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPermissionsForVisitor" class="col-sm-2 control-label">Default permissions for visitors</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputPermissionsForVisitor" name="default_permission_visitor">
                                    {foreach $permissions as $permission}
                                        <option value="{$permission['permissions_id']}"{if isset($smarty.post.default_permission_visitor)}{if $smarty.post.default_permission_visitor == $permission['permissions_id']} selected{/if}{elseif $permission['permissions_id']==$setting_default_permission_visitor} selected{/if}>{$permission['permissions_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-4">
                                <button type="submit" class="btn btn-default">Save</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {

        // Setup - add a text input to each footer cell
        $('#members_table tfoot th').each( function () {
            var title = $(this).text();
            $(this).html( '<input id="search-'+title.toLowerCase()+'" type="text" placeholder="Search '+title+'" />' );
        } );

        // DataTable
        var table = $('#members_table').DataTable({
                "scrollX": true
        });

        var permissionTable = $('#permissions_table').DataTable();

        // Apply the search
        table.columns().every( function () {
            var that = this;

            $( 'input', this.footer() ).on( 'keyup change', function () {
                if ( that.search() !== this.value ) {
                    that
                            .search( this.value )
                            .draw();
                }
            } );
        } );

        $(".member-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this member?");
            return c;
        });

        $(".permission-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this permission? Errors could error if users are assigned the delete permission.");
            return c;
        });


    } );
</script>

{include file="./footer.tpl"}