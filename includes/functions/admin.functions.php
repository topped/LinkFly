<?php
/*/**************************************************************************************************
  * | LinkFly | AdFly Clone PHP Script
  * | Support: http://scriptastic.co / support@scriptastic.co
  * | By using this software you agree that you have read and acknowledged our End-User License
  * | agreement available at http://scriptastic.co/linkfly/eula and to be bound by it.
  * | Copyright (c) Scriptastic All rights reserved.
 **************************************************************************************************/

/**
 * Saves $_POST-based settings. Ensures that they are valid first
 *
 * @return bool
 */
function save_settings(){

    if(count($_POST) > 0){

        $settings_ = $_POST;

        foreach($settings_ as $setting_slug => $setting_value){

            //Check if setting exists
            if(exist_setting($setting_slug)){

                if($setting_value == 'on')
                    $setting_value = '1';

                update_setting($setting_slug, $setting_value);

            }

        }

        return true;

    }

    return false;

}