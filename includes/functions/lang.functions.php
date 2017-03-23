<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

$language = get_setting('site_lang');

/** Checking and validating language items */

if(get_setting('show_language_picker'))
{

    /* Setting the language */

    if(isset($_POST['lang'])){

        $tlang = $_POST['lang'];

        if(file_exists(LANGS_PREFIX . 'langs/' . $tlang . '.lang.php')){

            setcookie('sitelang', $tlang);
            $language = $tlang;

        }

    }else{

        /* Check if the cookie exists and then use the cookie's language */

        if(isset($_COOKIE['sitelang'])){

            $tlang = $_COOKIE['sitelang'];

            if(file_exists(LANGS_PREFIX . 'langs/' . $tlang . '.lang.php')){

                $language = $tlang;

            }

        }

    }

}

if($language == null)
    die('Language file needs to be set.');

$language_file = sprintf(LANGS_PREFIX . 'langs/%s.lang.php', $language);

if(!file_exists($language_file))
    die(sprintf('Language file (<em>"%s"</em>) does not exist.', $language_file));

require_once $language_file;