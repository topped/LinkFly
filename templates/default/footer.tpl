    <div class="container footer{if $pid==0} invert-footer{/if}">
        <hr/>
        <div class="row">
            <div class="col-sm-4 copyright">
               <p class="subtle">{$setting_footer_copyright}
                {if $pid==0}<br/><br/>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> are licensed under <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a>{/if}
               </p>
            </div>
            <div class="col-sm-4 text-center">
                {if $setting_enable_branding}
                    {include file="./branding.tpl"}
                {/if}
            </div>
            <div class="col-sm-4 text-right pages">
                <a href="report">{$lang_42}</a> &#8226;
                <a href="page_terms">{$lang_43}</a> &#8226;
                <a href="page_about">{$lang_11}</a> &#8226;
                <a href="page_advertising-rates">{$lang_307}</a> &#8226;
                <a href="contact">{$lang_61}</a>
            </div>
        </div>
        {if $setting_show_language_picker}
        <div class="row lang-picker">
            <div class="col-sm-2 col-sm-offset-5">
                <form id="lang_form" class="form" action="" method="POST">
                    <input type="hidden" name="callback" value="{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}" />
                    <select id="lang" class="form-control input-sm" name="lang">
                        {foreach $all_langs as $language}
                            <option value="{$language}"{if $curr_lang == $language} selected{/if}>{$language|capitalize}</option>
                        {/foreach}
                    </select>
                </form>
            </div>
        </div>
        {/if}
    </div>
    {if $pid == 7 || $pid == 8}
        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                $('#links_table,#campaigns_table').dataTable({
                    language: {
                        search: "{$lang_105}",
                        paginate: {
                            first:      "{$lang_106}",
                            previous:   "{$lang_107}",
                            next:       "{$lang_108}",
                            last:       "{$lang_109}"
                        },
                        emptyTable: "{$lang_94}",
                        info: "{$lang_110}",
                        lengthMenu: "{$lang_111}"
                    }
                } );
            });
        </script>
    {/if}
    {if $setting_show_language_picker}
    <script type="text/javascript">
        $(document).ready(function() {
            $("#lang").on('change', function() {
                $( "#lang_form" ).submit();
            });
        });
    </script>
    {/if}
</body>
</html>