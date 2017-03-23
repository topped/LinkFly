{include file="./header.tpl"}
{include file="./navbar.tpl"}
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li role="presentation" class="active"><a aria-controls="reports" role="tab" data-toggle="tab" href="#reports"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Reports</a></li>
                <li role="presentation"><a aria-controls="contacts" role="tab" data-toggle="tab" href="#contacts"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> Contact Requests</a></li>
                <li role="presentation"><a aria-controls="announcements" role="tab" data-toggle="tab" href="#announcements"><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span> Announcements</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active fade in" id="reports">
                    <h2>Reports</h2><hr/>
                    <table id="reports_table" class="table table-bordered table-hover table-striped">
                        <thead>
                            <th>Topic</th>
                            <th>URL</th>
                            <th>Sender E-Mail</th>
                            <th>Description</th>
                            <th>Added</th>
                            <th></th>
                        </thead>
                        <tbody>
                            {foreach $reports as $report}
                                <tr>
                                    <td>
                                        {if $report['reports_topic']==0}
                                            Malicious Ad
                                        {elseif $report['reports_topic']==1}
                                            Pornographic Content
                                        {elseif $report['reports_topic']==2}
                                            Illegal Content
                                        {elseif $report['reports_topic']==3}
                                            Payment Issue
                                        {elseif $report['reports_topic']==4}
                                            Other
                                        {/if}
                                    </td>
                                    <td><a target="_blank" href="{$report['reports_url']}">{$report['reports_url']}</a></td>
                                    <td>{$report['reports_email']}</td>
                                    <td>{$report['reports_desc']}</td>
                                    <td>{$report['reports_timestamp']}</td>
                                    <td>
                                        <form id="delete_form_{$report['reports_id']}" class="report-delete" method="POST" action="">
                                            <input type="hidden" name="delete_report_id" value="{$report['reports_id']}" />
                                            <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="contacts">
                    <h2>Contact Requests</h2><hr/>
                    <table id="contacts_table" class="table table-bordered table-hover table-striped">
                        <thead>
                        <th>Username</th>
                        <th>URL</th>
                        <th>Sender E-Mail</th>
                        <th>Description</th>
                        <th>Added</th>
                        <th></th>
                        </thead>
                        <tbody>
                        {foreach $contacts as $contact}
                            <tr>
                                <td>{$contact['members_username']}</td>
                                <td><a target="_blank" href="{$contact['contacts_url']}">{$contact['contacts_url']}</a></td>
                                <td>{$contact['contacts_email']}</td>
                                <td>{$contact['contacts_desc']}</td>
                                <td>{$contact['contacts_added']}</td>
                                <td>
                                    <form id="delete_form_{$contact['contacts_id']}" class="contact-delete" method="POST" action="">
                                        <input type="hidden" name="delete_contact_id" value="{$contact['contacts_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="announcements">
                    <h2>Announcements</h2><hr/>
                    <div class="button-bar">
                        <a href="{$setting_base_url}admin/add_announcement.php" class="btn btn-success"><span class="glyphicon glyphicon-plus aria-hidden="true"></span> Add Announcement</a>
                    </div>
                    <table id="announcements_table" class="table table-bordered table-hover table-striped">
                        <thead>
                        <th>Message</th>
                        <th>Type</th>
                        <th>Added</th>
                        <th></th>
                        </thead>
                        <tbody>
                        {foreach $announcements as $announcement}
                            <tr>
                                <td>{$announcement['announcements_message']}</td>
                                <td>
                                    {if $announcement['announcements_type']==0}
                                        Info
                                    {elseif $announcement['announcements_type']==1}
                                        Warning
                                    {elseif $announcement['announcements_type']==2}
                                        Error
                                    {elseif $announcement['announcements_type']==3}
                                        Success
                                    {/if}
                                </td>
                                <td>{$announcement['announcements_added']}</td>
                                <td>
                                    <a class="btn btn-action btn-default btn-block btn-sm" href="{$setting_base_url}admin/announcements_edit.php?announcement_id={$announcement['announcements_id']}">Edit</a>
                                    <form id="delete_form_{$announcement['announcements_id']}" class="announcement-delete" method="POST" action="">
                                        <input type="hidden" name="delete_announcement_id" value="{$announcement['announcements_id']}" />
                                        <button class="btn btn-action btn-default btn-block btn-sm" type="submit">Delete</button>
                                    </form>
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
        var table = $('#reports_table,#contacts_table').DataTable( {
            "order": [[ 4, "desc" ]]
        } );

        var table_announcement = $('#announcements_table').DataTable( {
            "order": [[ 2, "desc" ]]
        } );

        $(".report-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this report?");
            return c;
        });

        $(".contact-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this contact request?");
            return c;
        });

        $(".announcement-delete").submit(function() {
            var c = confirm("Are you sure you want to delete this announcement?");
            return c;
        });

    } );
</script>

{include file="./footer.tpl"}