<!DOCTYPE html>
<html lang="{$lang_html}">
    <head>
        <title>{$setting_site_name} {$setting_header_separator} {$page_title}</title>
        {block name=extended_other_tags}{/block}
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="{$setting_meta_desc}">
        <meta name="keywords" content="{$setting_meta_keywords}">
        <meta name="author" content="{$setting_meta_author}">
        <meta charset="UTF-8">
        {block name=extended_meta_tags}{/block}
        <link href="templates/{$current_template}css/bootstrap.css" rel="stylesheet">
        <link href="templates/{$current_template}css/bootstrap-social.css" rel="stylesheet">
        <link href="templates/{$current_template}css/style.css" rel="stylesheet">
        <link href="templates/{$current_template}css/animate.css" rel="stylesheet">
        <link href="templates/{$current_template}css/font-awesome.css" rel="stylesheet">
        <link href="templates/{$current_template}css/dataTables.bootstrap.css" rel="stylesheet">
        <link rel="icon" type="image/png" href="templates/{$current_template}img/favicon.png">
        {block name=extended_style_sheets}{/block}
        {if $setting_analytics_code != ""}
        <script type="text/javascript">
            {$setting_analytics_code}
        </script>
        {/if}<script src="templates/{$current_template}js/jquery-1.11.3.min.js"></script>
        <script src="templates/{$current_template}js/jquery.dataTables.min.js"></script>
        <script src="templates/{$current_template}js/dataTables.bootstrap.js"></script>
        <script src="templates/{$current_template}js/bootstrap.min.js"></script>
        <script src="templates/{$current_template}js/Chart.min.js"></script>
        <script src="templates/{$current_template}js/clipboard.min.js"></script>
        <script src="templates/{$current_template}js/qrcode.js"></script>
        <script src="templates/{$current_template}js/jquery.qrcode.js"></script>
        {block name=extended_script_tags}{/block}
    </head>
    <body{if $pid==0} class="white-bg"{/if}>