{include file="./header.tpl"}
{include file="./navbar.tpl"}

<div class="container with-bg">

    <div class="page-header">
        <h1>{$lang_224}</h1>
    </div>
    <div class="row">
        <div class="col-lg-9">
            {if $completed == false}
            <form name="_xclick" action="{if $setting_payment_test_mode}https://www.sandbox.paypal.com/cgi-bin/webscr{else}https://www.paypal.com/cgi-bin/webscr{/if}" method="post">
                <input type="hidden" name="cmd" value="_xclick">
                <input type="hidden" name="business" value="{$setting_paypal_email}">
                <input type="hidden" name="currency_code" value="{$setting_site_curr}">
                <input type="hidden" name="item_name" value="{$transaction['transactions_item_name']}">
                <input type="hidden" name="amount" value="{$value}">
                <input type="hidden" name="return" value="{$setting_base_url}payment_page?completed=1&tid={$transaction['transactions_id']}">
                <input type="hidden" name="notify_url" value="{$setting_base_url}paypal_ipn.php">
                <input type="hidden" name="custom" value="{$transaction['transactions_object_id']}|{$transaction['transactions_members_id']}">
                <input type="image" src="https://www.paypalobjects.com/webstatic/en_US/btn/btn_checkout_pp_142x27.png" border="0" name="submit" alt="Make payments with PayPal - it's fast,free and secure!">
            </form>
            {else}
                <div class="alert alert-success">
                    {$transaction['transactions_item_name']}: {$lang_251}
                </div>
            {/if}

        </div>
    </div>
</div>