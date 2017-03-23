{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/miscellaneous.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit Announcement</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Announcement updated!</div>
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Edit Announcement</h2><hr/>
                    {if $announcement}
                        <form class="form-horizontal" method="POST" action="">
                            <input type="hidden" class="form-control" id="announcement_id" name="announcement_id" value="{$announcement['announcements_id']}">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Message</label>
                                <div class="col-sm-3">
                                    <textarea class="form-control" name="message" id="message" style="height: 90px;">{$announcement['announcements_message']}</textarea>
                                    <span id="help-block" class="help-block">HTML is allowed. Message used to display in the announcement.</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputType" class="col-sm-2 control-label">Type</label>
                                <div class="col-sm-3">
                                    <select class="form-control" id="inputType" name="type">
                                        <option value="0"{if $announcement['announcements_type']==0} selected{/if}>Info</option>
                                        <option value="1"{if $announcement['announcements_type']==1} selected{/if}>Warning</option>
                                        <option value="2"{if $announcement['announcements_type']==2} selected{/if}>Error</option>
                                        <option value="3"{if $announcement['announcements_type']==3} selected{/if}>Success</option>
                                    </select>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-2">
                                    <button type="submit" class="btn btn-primary">Edit Announcement</button>
                                </div>
                            </div>
                        </form>
                    {else}
                    <div class="alert alert-danger">Invalid announcement</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}