{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container-fluid main-container">
    <div class="row">
        <div class="col-lg-12 well">
            <h2>Dashboard</h2><hr/>
            <div class="row">
                            <div class="col-lg-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Link Stats</div>
                                    <div class="panel-body stat-body">
                                        <table class="table table-condensed table-striped">
                                            <tr><th>Summary</th><th>Result</th></tr>
                                            <tr><td>Total Links</td><td>{$total_links}</td></tr>
                                            <tr><td>Total Views</td><td>{$total_views}</td></tr>
                                            <tr><td>Total Earnings</td><td>{format_price value=$total_earnings}</td></tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">Campaign Stats</div>
                                    <div class="panel-body stat-body">
                                        <table class="table table-condensed table-striped">
                                            <tr><th>Summary</th><th>Result</th></tr>
                                            <tr><td>Campaigns Awaiting Approval</td><td>{$campaigns_count}</td></tr>
                                            <tr><td>Total Campaigns</td><td>{$total_campaigns}</td></tr>
                                            <tr><td>Rejected Campaigns</td><td>{$rejected_campaigns}</td></tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Withdrawal Stats</div>
                                    <div class="panel-body stat-body">
                                        <table class="table table-condensed table-striped">
                                            <tr><th>Summary</th><th>Result</th></tr>
                                            <tr><td>Withdrawals Awaiting Processing</td><td>{$withdrawals_count}</td></tr>
                                            <tr><td>Total Withdrawals</td><td>{$total_withdrawals}</td></tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">Report Stats</div>
                                    <div class="panel-body stat-body">
                                        <table class="table table-condensed table-striped">
                                            <tr><th>Summary</th><th>Result</th></tr>
                                            <tr><td>Total Reports</td><td>{$total_reports}</td></tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">Member Stats</div>
                                    <div class="panel-body stat-body">
                                        <table class="table table-condensed table-striped">
                                            <tr><th>Summary</th><th>Result</th></tr>
                                            <tr><td>Total Members</td><td>{$total_members}</td></tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Last 10 Members</div>
                                    <div class="panel-body stat-body">
                                        <table class="table table-condensed table-striped">
                                            <tr><th>Username</th><th>E-Mail</th></tr>
                                            {foreach $last_members as $lmember}
                                                <tr>
                                                    <td>{$lmember['members_username']}</td>
                                                    <td>{$lmember['members_email']}</td>
                                                </tr>
                                            {/foreach}
                                        </table>
                                    </div>
                                </div>
                            </div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">Last 10 Campaigns</div>
                        <div class="panel-body stat-body">
                            <table class="table table-condensed table-striped">
                                <tr><th>Name</th><th>Added</th></tr>
                                {foreach $last_campaigns as $lcampaign}
                                    <tr>
                                        <td>{$lcampaign['campaigns_name']}</td>
                                        <td>{$lcampaign['campaigns_started']}</td>
                                    </tr>
                                {/foreach}
                            </table>
                        </div>
                    </div>
                </div>
            </div>
                        </div>
        </div>
    </div>
</div>

{include file="./footer.tpl"}