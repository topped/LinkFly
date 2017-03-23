{*{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="reports" role="tab" data-toggle="tab" href="#plugins"><span class="glyphicon glyphicon-hdd" aria-hidden="true"></span> Plugins</a></li>
                <li role="presentation"><a aria-controls="activate_plugin" role="tab" data-toggle="tab" href="#activate_plugin"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Activate Plugin</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active fade in" id="plugins">
                    <h2>Plugins</h2><hr/>
                    {if $success}
                        <div class="alert alert-success">Plugins updated!</div>
                    {/if}
                    {if count($errors) > 0}
                        {foreach $errors as $error}
                            <div class="alert alert-danger">{$error}</div>
                        {/foreach}
                    {/if}
                    <table id="plugins_table" class="table table-bordered table-hover table-striped" style="width:750px;">
                        <thead>
                            <th>Name</th>
                            <th>Slug</th>
                            <th>Status</th>
                            <th></th>
                        </thead>
                        <tbody>
                            {foreach $plugins as $plugin}
                                <tr>
                                    <td>
                                        <img src="{$plugin['plugins_thumb']}" style="width:80px;height:80px"/> <strong>{$plugin['plugins_name']}</strong>
                                    </td>
                                    <td>{$plugin['plugins_slug']}</td>
                                    <td>{if $plugin['plugins_enabled']==0}Disabled{else}Enabled{/if}</td>
                                    <td>
                                        {if $plugin['plugins_enabled']==0}
                                            <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/plugins.php?enable_plugin={$plugin['plugins_id']}">Enable</a>
                                        {else}
                                            <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/plugins.php?disable_plugin={$plugin['plugins_id']}">Disable</a>
                                        {/if}
                                        <form id="delete_form_{$plugin['plugins_id']}" class="plugin-delete delete-form" method="POST" action="">
                                            <input type="hidden" name="delete_id" value="{$plugin['plugins_id']}" />
                                            <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Uninstall</button>
                                        </form>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="activate_plugin">
                    <h2>Activate Plugin</h2><hr/>
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Plugin Name</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="slug" name="slug" value="{if isset($smarty.post.slug)}{$smarty.post.slug}{/if}">
                                <span id="helpBlock" class="help-block">
                                    <strong>Installing a plugin:</strong>
                                    <ol>
                                        <li>Extract the plugin folder and place it into the 'plugins' folder in the root directory of your LinkFly installation</li>
                                        <li>On this page, enter the slug of the plugin. The slug is the name of the plugin folder.</li>
                                        <li>Click 'Activate' to activate the plugin. The database will be updated, and your plugin should be installed.</li>
                                        <li>To configure the plugin, you can edit the plugin's settings.php file.</li>
                                    </ol>
                                    <strong>IMPORTANT: Only install plugins from trusted sources - unknown plugins could potentially harm your LinkFly installation.</strong>
                                </span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-2">
                                <button type="submit" class="btn btn-primary">Activate Plugin</button>
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

        // DataTable
        var table = $('#plugins_table').DataTable( {
            "order": [[ 0, "asc" ]]
        } );

        $(".plugin-delete").submit(function() {
            var c = confirm("Are you sure you want to uninstall this plugin? All data associated with this plugin will be lost and not recoverable.");
            return c;
        });

    } );
</script>

{include file="./footer.tpl"}*}