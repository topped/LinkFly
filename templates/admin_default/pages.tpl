{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="pages" role="tab" data-toggle="tab" href="#pages"><span class="glyphicon glyphicon-file" aria-hidden="true"></span> Pages</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                {if $success}
                    <div class="alert alert-success">Pages updated!</div>
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="pages">
                    <h2>Pages</h2><hr/>
                    <div class="button-bar">
                        <a href="{$setting_base_url}admin/add_page.php" class="btn btn-success"><span class="glyphicon glyphicon-plus aria-hidden="true"></span> Add Page</a>
                    </div>
                    <table id="pages_table" class="table table-bordered table-hover table-striped">
                        <thead>
                            <th>Title</th>
                            <th>Slug</th>
                            <th>Language</th>
                            <th>Content</th>
                            <th></th>
                            <th></th>
                        </thead>
                        <tbody>
                        {foreach $pages as $page}
                            <tr>
                                <td>{$page['pages_title']}</td>
                                <td>{$page['pages_slug']}</td>
                                <td>{$page['pages_lang']}</td>
                                <td>{$page['pages_content']}</td>
                                <td>
                                    <form id="delete_form_{$page['pages_id']}" class="page-delete" method="POST" action="">
                                        <input type="hidden" name="delete_id" value="{$page['pages_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
                                </td>
                                <td>
                                    <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/pages_edit.php?page_id={$page['pages_id']}">Edit</a>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {

        // DataTable
        var table = $('#pages_table').DataTable( {
            "order": [[ 0, "asc" ]]
        } );

        $(".page-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this page?");
            return c;
        });

    } );
</script>

{include file="./footer.tpl"}