<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

define('IS_ADMIN', false);

define('PAGE_TITLE', 'page_title');
define('PAGE_ID', 'pid');

define('INCLUDES_DIR', 'includes/');

define('LANGS_PREFIX', '');

define('CONFIGS_DIR', INCLUDES_DIR. 'configs/');
define('FUNCS_DIR', INCLUDES_DIR. 'functions/');
define('LIBS_DIR', INCLUDES_DIR. 'libraries/');

define('PLUGINS_DIR', 'plugins/');

define('SMARTY_DIR', LIBS_DIR . 'Smarty/');
define('ADODB_DIR', LIBS_DIR . 'adodb5/');

$flag_login = false;