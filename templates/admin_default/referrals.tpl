{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="general" role="tab" data-toggle="tab" href="#general"><span class="glyphicon glyphicon-send" aria-hidden="true"></span> Referrals</a></li>
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
                    <div class="alert alert-success">Referrals updated!</div>
                {/if}
                {if count($errors) > 0}
                    {foreach $errors as $error}
                        <div class="alert alert-danger">{$error}</div>
                    {/foreach}
                {/if}
                <div role="tabpanel" class="tab-pane active fade in" id="general">
                <h2>Referrals</h2><hr/>
                <table id="referrals_table" class="table table-bordered table-hover table-striped">
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
                                        <input type="hidden" name="enable_referrals" value="0">
                                        <input name="enable_referrals" type="checkbox"{if isset($smarty.post.enable_referrals)}{if $smarty.post.enable_referrals == "on"} checked{/if}{else}{if $setting_enable_referrals} checked{/if}{/if}> Enable referrals
                                        <span id="helpBlock" class="help-block">Choose to enable or disable the referral system.</span>
                                    </label>
                                </div>
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
        $('#referrals_table tfoot th').each( function () {
            var title = $(this).text();
            $(this).html( '<input id="search-'+title.toLowerCase()+'" type="text" placeholder="Search '+title+'" />' );
        } );

        // DataTable
        var table = $('#referrals_table').DataTable({
                "scrollX": true
        });

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

        $(".referral-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this referral?");
            return c;
        });

    } );
</script>

{include file="./footer.tpl"}