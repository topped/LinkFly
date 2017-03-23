{include file="./header.tpl"}
{include file="./navbar.tpl"}
{include file="./banner.tpl"}

<div class="container main-container">
    <hr/>
    <div class="row home-stats">
        <div class="col-sm-4 text-center">
            <h1>{$usercount}</h1>
            <strong>{$lang_299}</strong>
        </div>
        <div class="col-sm-4 text-center">
            <h1>{$linkcount}</h1>
            <strong>{$lang_300}</strong>
        </div>
        <div class="col-sm-4 text-center">
            <h1>{$viewcount}</h1>
            <strong>{$lang_301}</strong>
        </div>
    </div>
    <hr/>
    <div class="row">
        <div class="col-sm-4">
            <div class="panel panel-primary">
                <div class="panel-heading">{$lang_12}</div>
                <div class="panel-body">
                    <div class="text-center large-icon"><img src="templates/{$current_template}img/icons/fast.png" alt="Fast Speeds"/></div>
                    <p>{$lang_21}</p>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="panel panel-primary">
            <div class="panel-heading">{$lang_13}</div>
            <div class="panel-body">
                <div class="text-center large-icon"><img src="templates/{$current_template}img/icons/fair.png" alt="Fast Speeds"/></div>
                <p>{$lang_22}</p>
            </div>
        </div>
        </div>
        <div class="col-sm-4">
            <div class="panel panel-primary">
            <div class="panel-heading">{$lang_14}</div>
            <div class="panel-body">
                <div class="text-center large-icon"><img src="templates/{$current_template}img/icons/powerful.png" alt="Fast Speeds"/></div>
                <p>{$lang_23}</p>
            </div>
        </div>
        </div>
    </div>

</div>

{include file="./footer.tpl"}