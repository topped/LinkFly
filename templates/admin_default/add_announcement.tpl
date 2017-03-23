{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/miscellaneous.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Announcement</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Add Announcement</h2><hr/>
                    {if $success}
                        <div class="alert alert-success">Announcement added!</div>
                    {/if}
                    {if count($errors) > 0}
                        {foreach $errors as $error}
                            <div class="alert alert-danger">{$error}</div>
                        {/foreach}
                    {/if}
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Message</label>
                            <div class="col-sm-3">
                                <textarea class="form-control" name="message" id="message" style="height: 90px;">{if isset($smarty.post.message)}{$smarty.post.message}{/if}</textarea>
                                <span id="help-block" class="help-block">HTML is allowed. Message used to display in the announcement.</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputType" class="col-sm-2 control-label">Type</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="inputType" name="type">
                                    <option value="0"{if isset($smarty.post.type)}{if $smarty.post.type == 0} selected{/if}{/if}>Info</option>
                                    <option value="1"{if isset($smarty.post.type)}{if $smarty.post.type == 1} selected{/if}{/if}>Warning</option>
                                    <option value="2"{if isset($smarty.post.type)}{if $smarty.post.type == 2} selected{/if}{/if}>Error</option>
                                    <option value="3"{if isset($smarty.post.type)}{if $smarty.post.type == 3} selected{/if}{/if}>Success</option>
                                </select>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-2">
                                <button type="submit" class="btn btn-primary">Add Announcement</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}