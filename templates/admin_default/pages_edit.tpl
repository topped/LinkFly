{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation"><a href="{$setting_base_url}admin/pages.php"><span class="glyphicon glyphicon-circle-arrow-left" aria-hidden="true"></span> Back</a></li>
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Edit Page</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Page updated!</div>
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                    <h2>Edit Page</h2><hr/>
                    {if $page}
                        <form class="form-horizontal" method="POST" action="">
                            <input type="hidden" class="form-control" id="page_id" name="page_id" value="{$page['pages_id']}">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Title</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="title" name="title" value="{$page['pages_title']}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Slug</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="slug" name="slug" value="{$page['pages_slug']}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Content</label>
                                <div class="col-sm-3">
                                    <textarea class="form-control" name="content" id="content" style="height: 260px;width:700px;">{$page['pages_content']}</textarea>
                                    <span id="help-block" class="help-block">HTML is allowed. You can utilize Smarty template functions, e.g.: {literal}{$setting_site_name}{/literal}</span>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Language</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="lang" name="lang" value="{$page['pages_lang']}" placeholder="english">
                                    <span id="help-block" class="help-block">This has to be equal to the name of a language file, e.g. 'english' or 'german'.</span>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-2">
                                    <button type="submit" class="btn btn-primary">Edit Page</button>
                                </div>
                            </div>
                    </form>
                    {else}
                    <div class="alert alert-danger">Invalid page</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $("#location").val("{$rate['rates_location']}");
    });
</script>

{include file="./footer.tpl"}