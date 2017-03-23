{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/links.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Domain</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Add Domain</h2><hr/>
                    {if $success}
                        <div class="alert alert-success">Domain added!</div>
                    {/if}
                    {if count($errors) > 0}
                        {foreach $errors as $error}
                            <div class="alert alert-danger">{$error}</div>
                        {/foreach}
                    {/if}
                    <form class="form-horizontal" method="POST" action="">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Domain URL</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="domain_url" name="domain_url" value="{if isset($smarty.post.domain_url)}{$smarty.post.domain_url}{/if}" required>
                                <span id="helpBlock" class="help-block">
                                    <strong>Important:</strong> Please make sure that the domain ends with a forward slash (/).<br/><br/>
                                    <strong>Please refer to the manual on how to setup domain forwarding in order for your alternative domain to properly redirect to {$setting_base_url}.</strong>
                                </span>
                            </div>
                        </div>
                        <hr/>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-2">
                                <button type="submit" class="btn btn-primary">Add Domain</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}