<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/* Template Settings */

//Fallback template, in case database is not accessible
define('CURRENT_TEMPLATE_NAME', 'default');
define('CURRENT_TEMPLATE', CURRENT_TEMPLATE_NAME . '/');

define('ADMIN_TEMPLATE_NAME', 'admin_default');
define('ADMIN_TEMPLATE', '../templates/' . ADMIN_TEMPLATE_NAME . '/');

define('PLUGINS_TEMPLATE_NAME', 'plugins');
define('PLUGINS_TEMPLATE', PLUGINS_TEMPLATE_NAME . '/');