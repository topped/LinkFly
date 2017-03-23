{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_325} <small>{$lang_327}</small></h1>
    </div>

    {if $setting_enable_referrals}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">{$lang_325}</div>
                <div class="panel-body">

                </div>
            </div>
        </div>
    </div>

    {else}
        <div class="alert alert-danger">{$lang_328}</div>
    {/if}

</div>

{include file="./footer.tpl"}