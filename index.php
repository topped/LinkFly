<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

#region Definitions

require_once 'includes/definitions.php';

#endregions

/* Loading the core include.
 *      The core include loads the template engine, and also initializes the database
 *      amongst other things.
 * */

require_once FUNCS_DIR . 'core.functions.php';

/* Page Identifier */

$pid = 0;

/** Rendering Section */

/* Assigning page title */

$template->assign(PAGE_TITLE, $langs[53]);
$template->assign(PAGE_ID, $pid);

/*  Small stats on main page are assigned here */

$template->assign('domains', get_domains());

$template->assign('usercount', get_all_member_count());
$template->assign('linkcount', get_all_link_count());
$template->assign('viewcount', get_all_view_count());

/* Rendering template */

$template->display($current_template . 'index.tpl');

