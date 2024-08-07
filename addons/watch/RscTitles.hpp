#define KAT_WATCH_GRID_WAbs            (((safezoneW / safezoneH) min 0.7))
#define KAT_WATCH_GRID_HAbs            ((((safezoneW / safezoneH) min 1.2) / 1.6))
#define KAT_WATCH_GRID_W            ((((safeZoneW / safeZoneH) min 0.7) / 40))
#define KAT_WATCH_GRID_H            (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define KAT_WATCH_GRID_X            ((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 11))
#define KAT_WATCH_GRID_Y            ((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 0.8))

#define KAT_WATCH_GRID_CENTER_W        KAT_WATCH_GRID_W
#define KAT_WATCH_GRID_CENTER_H        KAT_WATCH_GRID_H
#define KAT_WATCH_GRID_CENTER_X        (safezoneX + (safezoneW - KAT_WATCH_GRID_WAbs)/2)
#define KAT_WATCH_GRID_CENTER_Y        (safezoneY + (safezoneH - KAT_WATCH_GRID_HAbs)/2)

#define KAT_POS_X(N) ((N) * KAT_WATCH_GRID_W + KAT_WATCH_GRID_CENTER_X)
#define KAT_POS_Y(N) ((N) * KAT_WATCH_GRID_H + KAT_WATCH_GRID_CENTER_Y)
#define KAT_POS_W(N) ((N) * KAT_WATCH_GRID_W)
#define KAT_POS_H(N) ((N) * KAT_WATCH_GRID_H)

#define ST_LEFT 0
#define ST_CENTER 2
#define ST_RIGHT 1

class RscText;
class RscPicture;
class RscButton;
class RscTitles
{
    class KAT_Garmin
    {
        idd = 19935;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_Garmin', _this select 0];";
        class controls
        {
            class GarminImage: RscPicture
            {
                idc = 19800;
                text = "\x\kat\addons\watch\UI\watch_garmin.paa";
                x = "0.0328437 * safezoneW + safezoneX";
                y = "0.622 * safezoneH + safezoneY";
                w = "0.225 * safezoneW";
                h = "0.4 * safezoneH";
            };
            class GarminCompass: GarminImage
            {
                idc = 19801;
                text = "\x\kat\addons\watch\UI\watch_garmin_direction.paa";
            };
            class GarminIcon: GarminImage
            {
                idc = 19802;
                text = "\x\kat\addons\watch\UI\watch_icon.paa";
            };
            class GarminSun: GarminImage
            {
                idc = 19803;
                text = "\x\kat\addons\watch\UI\watch_sun.paa";
                show = 0;
            };
            class GarminOvercast: GarminImage
            {
                idc = 19804;
                text = "\x\kat\addons\watch\UI\watch_overcast.paa";
                show = 0;
            };
            class GarminRain: GarminImage
            {
                idc = 19805;
                text = "\x\kat\addons\watch\UI\watch_rain.paa";
                show = 0;
            };
            class GarminTime: RscText
            {
                idc = 22000;
                style = ST_CENTER;
                shadow = 0;
                font = "PuristaBold";
                text = "12:00"; //--- ToDo: Localize;
                x = "0.104 * safezoneW + safezoneX";
                y = "0.8058 * safezoneH + safezoneY";
                w = "0.061875 * safezoneW";
                h = "0.033 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(2));
            };
            class GarminMonth: RscText
            {
                idc = 22001;
                style = ST_LEFT;
                shadow = 0;
                font = "PuristaBold";
                text = "JAN"; //--- ToDo: Localize;
                x = "0.159594 * safezoneW + safezoneX";
                y = "0.8124 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.011 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(0.8));
            };
            class GarminDay: RscText
            {
                idc = 22002;
                style = ST_RIGHT;
                shadow = 0;
                font = "PuristaBold";
                text = "01"; //--- ToDo: Localize;
                x = "0.160625 * safezoneW + safezoneX";
                y = "0.8255 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.011 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(0.8));
            };
            class GarminBaro: RscText
            {
                idc = 22003;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "760"; //--- ToDo: Localize;
                x = "0.157625 * safezoneW + safezoneX";
                y = "0.7794 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(1.1));
            };
            class GarminHR: RscText
            {
                idc = 22004;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "80"; //--- ToDo: Localize;
                x = "0.149375 * safezoneW + safezoneX";
                y = "0.8432 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(1.2));
            };
            class GarminO2: RscText
            {
                idc = 22005;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "97"; //--- ToDo: Localize;
                x = "0.119469 * safezoneW + safezoneX";
                y = "0.8432 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(1.2));
            };
            class GarminTemp: RscText
            {
                idc = 22006;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "76F"; //--- ToDo: Localize;
                x = "0.134937 * safezoneW + safezoneX";
                y = "0.7794 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(1.1));
            };
        };
    };
};