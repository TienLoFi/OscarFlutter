<?php

class Ultils {

    public static function generateOTP()
    {
        $otp = rand(100000, 999999);
        return $otp;
    }

    public static function getTimeAfterHours($hours)
    {
        if($hours!=null || $hours !=0)
        {
            return  date('Y-m-d H:i:s', strtotime($hours.' hour'));
        }
        else 
        {
            $hours=24; //setting default time
            return  date('Y-m-d H:i:s', strtotime($hours.' hour'));
        } 
    }
}