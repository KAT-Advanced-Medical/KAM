#define KAT_WATCH_GRID_WAbs            (((safezoneW / safezoneH) min 0.7))
#define KAT_WATCH_GRID_HAbs            ((((safezoneW / safezoneH) min 1.2) / 1.6))
#define KAT_WATCH_GRID_W            ((((safeZoneW / safeZoneH) min 0.7) / 40))
#define KAT_WATCH_GRID_H            (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define KAT_WATCH_GRID_X            ((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 11))
#define KAT_WATCH_GRID_Y            ((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 0.8))

#define KAT_POS_H(N) ((N) * KAT_WATCH_GRID_H)

#define ST_LEFT 0
#define ST_CENTER 2
#define ST_RIGHT 1

class RscText;
class RscPicture;
class RscButton;
class RscTitles
{
    class KAT_Katmin
    {
        idd = 19935;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_Katmin', _this select 0];";
        class controls
        {
            class KatminImage: RscPicture
            {
                idc = 19800;
                text = "\x\kat\addons\watch\UI\watch_katmin.paa";
                x = "0.0328437 * safezoneW + safezoneX";
                y = "0.652 * safezoneH + safezoneY";
                w = "0.225 * safezoneW";
                h = "0.4 * safezoneH";
            };
            class KatminIcon: KatminImage
            {
                idc = 19802;
                text = "\x\kat\addons\watch\UI\watch_icon.paa";
            };
            class KatminSun: KatminImage
            {
                idc = 19803;
                text = "\x\kat\addons\watch\UI\watch_sun.paa";
                show = 0;
            };
            class KatminOvercast: KatminImage
            {
                idc = 19804;
                text = "\x\kat\addons\watch\UI\watch_overcast.paa";
                show = 0;
            };
            class KatminRain: KatminImage
            {
                idc = 19805;
                text = "\x\kat\addons\watch\UI\watch_rain.paa";
                show = 0;
            };
            class KatminCompass: KatminImage
            {
                idc = 19806;
                text = "\x\kat\addons\watch\UI\watch_katmin_direction.paa";
            };
            class KatminTime: RscText
            {
                idc = 22000;
                style = ST_CENTER;
                shadow = 0;
                font = "PuristaBold";
                text = "12:00"; //--- ToDo: Localize;
                x = "0.104 * safezoneW + safezoneX";
                y = "0.8328 * safezoneH + safezoneY";
                w = "0.061875 * safezoneW";
                h = "0.033 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(2));
            };
            class KatminMonth: RscText
            {
                idc = 22001;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "JAN"; //--- ToDo: Localize;
                x = "0.157316 * safezoneW + safezoneX";
                y = "0.8394 * safezoneH + safezoneY";
                w = "0.0257812 * safezoneW";
                h = "0.013 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(0.8));
            };
            class KatminDay: RscText
            {
                idc = 22002;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "01"; //--- ToDo: Localize;
                x = "0.157316 * safezoneW + safezoneX";
                y = "0.8525 * safezoneH + safezoneY";
                w = "0.0257812 * safezoneW";
                h = "0.013 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(0.8));
            };
            class KatminBaro: RscText
            {
                idc = 22003;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "760"; //--- ToDo: Localize;
                x = "0.158625 * safezoneW + safezoneX";
                y = "0.80844 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(0.95));
            };
            class KatminHR: RscText
            {
                idc = 22004;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "80"; //--- ToDo: Localize;
                x = "0.149375 * safezoneW + safezoneX";
                y = "0.8732 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(1.2));
            };
            class KatminO2: RscText
            {
                idc = 22005;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "97"; //--- ToDo: Localize;
                x = "0.118469 * safezoneW + safezoneX";
                y = "0.8732 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(1.2));
            };
            class KatminTemp: RscText
            {
                idc = 22006;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "76F"; //--- ToDo: Localize;
                x = "0.134937 * safezoneW + safezoneX";
                y = "0.8094 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(KAT_POS_H(1));
            };
            class KatminAltitude: RscText
            {
                idc = 22007;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "1000";
                x = "0.111219 * safezoneW + safezoneX";
                y = "0.80844 * safezoneH + safezoneY";
                w = "0.020625 * safezoneW";
                h = "0.022 * safezoneH";
                sizeEx = QUOTE(KAT_POS_H(0.95));
            };
        };
    };
};