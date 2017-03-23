{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_31} <small>{$lang_228}</small></h1>
    </div>

    {if $setting_enable_withdrawals}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">{$lang_229}</div>
                <div class="panel-body">
                    {if isset($errors)}
                        {foreach $errors as $error}
                            <div class="alert alert-danger">{$error}</div>
                        {/foreach}
                    {/if}
                    {if isset($success)}
                        <div class="alert alert-success">
                            {$lang_230}
                        </div>
                    {else}
                        {if $has_min_earnings && $has_required_age && $has_not_changed_pass}
                            <form class="form-horizontal" method="POST" action="">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">{$lang_231}</label>
                                    <div class="col-sm-4">
                                        <input type="email" class="form-control" name="pp_email" placeholder="{$lang_231}" value="{if isset($smarty.post.pp_email)}{$smarty.post.pp_email}{/if}" required>
                                        <p class="help-block">{$lang_232}</p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">{$lang_233}</label>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                             <input type="text" class="form-control" name="amount" placeholder="{$lang_233}" value="{if isset($smarty.post.amount)}{$smarty.post.amount}{/if}" required>
                                             <div class="input-group-addon">{$setting_site_curr}</div>
                                        </div>
                                        <p class="help-block">{$lang_234}<strong>{format_price value=$member_data['members_balance']}</strong>.</p>
                                    </div>
                                </div><hr/>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">{$lang_162}</label>
                                    <div class="col-sm-5">
                                        <img class="thumbnail" id="captcha" src="{$setting_base_url}includes/libraries/securimage/securimage_show.php" alt="CAPTCHA Image" />
                                        <input type="text" class="form-control captcha-field pull-left" name="captcha" placeholder="{$lang_163}" required>
                                        <a class="btn btn-primary pull-left" href="#" onclick="document.getElementById('captcha').src = '{$setting_base_url}includes/libraries/securimage/securimage_show.php?' + Math.random(); return false"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></a>
                                    </div>
                                </div><hr/>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="submit" class="btn btn-primary">{$lang_235}</button>
                                    </div>
                                </div>
                            </form>
                        {else}
                            {$lang_239}
                            <ul>
                            {if $has_min_earnings == false}
                                <li>{$lang_236|sprintf:$setting_min_withdraw:$setting_site_curr}</li>
                            {/if}
                            {if $has_required_age == false}
                                <li>{$lang_237|sprintf:$setting_min_account_age}</li>
                            {/if}
                            {if $has_not_changed_pass == false}
                                <li>{$lang_238}</li>
                            {/if}
                            </ul>
                        {/if}
                    {/if}
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">{$lang_240}</div>
                <div class="panel-body">
                    {if count($withdrawals) > 0}
                        <table class="table table-bordered">
                            <thead>
                                <th>{$lang_241}</th>
                                <th>{$lang_242}</th>
                                <th>{$lang_243}</th>
                                <th>{$lang_244}</th>
                            </thead>
                            <tbody>
                                {foreach $withdrawals as $request}
                                    <tr>
                                        <td>{$request['withdrawal_requests_pp_email']}</td>
                                        <td>{$request['withdrawal_requests_amount']} {$request['withdrawal_requests_curr']}</td>
                                        <td>{$request['withdrawal_requests_added']}</td>
                                        <td>
                                            {assign var="status" value=$request['withdrawal_requests_status']}
                                            {if $status == 0}
                                                <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> {$lang_245}
                                            {elseif $status == 1}
                                                <span class="success"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> {$lang_246}</span>
                                            {elseif $status == 2}
                                                <span class="delay"><span class="glyphicon glyphicon-time" aria-hidden="true"></span> {$lang_247}</span>
                                            {else}
                                                <span class="fail"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> {$lang_248} <small>(<a href="{$setting_base_url}page_withdrawals">{$lang_302}</a>)</small></span>
                                            {/if}
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    {else}
                        <div class="subtle">{$lang_249}</div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
    {else}
        <div class="alert alert-danger">{$lang_311}</div>
    {/if}

</div>

{include file="./footer.tpl"}