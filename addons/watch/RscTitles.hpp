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

#define pixelW  (1 / (getResolution select 2))
#define pixelH  (1 / (getResolution select 3))
#define pixelScale	0.50

// pixel grids macros
#define UI_GRID_W (pixelW * pixelGridBase)
#define UI_GRID_H (pixelH * pixelGridBase)
#define UI_GUTTER_W (pixelW * 2)	
#define UI_GUTTER_H (pixelH * 2)

// sizes for our control
#define BOX_W (UI_GRID_W * 24)
#define BOX_H (UI_GRID_H * 24)

#define KAT_WATCH_RESOLUTION_W (getResolution select 0)
#define KAT_WATCH_RESOLUTION_H (getResolution select 1)

class RscText;
class RscPicture;
class RscButton;
class RscPictureKeepAspect;
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W - 300) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H - 300) / KAT_WATCH_RESOLUTION_H);
                w = QUOTE(BOX_W * (1.7777 / (getResolution select 4)));
                h = QUOTE(BOX_H);
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 28) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 58) / KAT_WATCH_RESOLUTION_H);
                w = QUOTE((UI_GRID_W * 7) * (1.7777 / (getResolution select 4)));
                h = QUOTE(UI_GRID_W * 2.5);
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE((UI_GRID_W * 4) * (1.7777 / (getResolution select 4)));
            };
            class KatminMonth: RscText
            {
                idc = 22001;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "JAN"; //--- ToDo: Localize;
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 274.8) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 65.2) / KAT_WATCH_RESOLUTION_H);
                w = "0.0257812 * safezoneW / ((getResolution select 5) * 1.7777)";
                h = "0.013 * safezoneH / ((getResolution select 5) * 1.7777)";
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 274.8) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 97.84) / KAT_WATCH_RESOLUTION_H);
                w = "0.0257812 * safezoneW / ((getResolution select 5) * 1.7777)";
                h = "0.013 * safezoneH / ((getResolution select 5) * 1.7777)";
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 283.2) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 10.4) / KAT_WATCH_RESOLUTION_H);
                w = "0.020625 * safezoneW / ((getResolution select 5) * 1.7777)";
                h = "0.022 * safezoneH / ((getResolution select 5) * 1.7777)";
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 240.8) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 131.8) / KAT_WATCH_RESOLUTION_H);
                w = "0.020625 * safezoneW / ((getResolution select 5) * 1.7777)";
                h = "0.022 * safezoneH / ((getResolution select 5) * 1.7777)";
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 100.2) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 131.8) / KAT_WATCH_RESOLUTION_H);
                w = "0.020625 * safezoneW / ((getResolution select 5) * 1.7777)";
                h = "0.022 * safezoneH / ((getResolution select 5) * 1.7777)";
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 174.2) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 10.4) / KAT_WATCH_RESOLUTION_H);
                w = "0.020625 * safezoneW / ((getResolution select 5) * 1.7777)";
                h = "0.022 * safezoneH / ((getResolution select 5) * 1.7777)";
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
                x = QUOTE((KAT_WATCH_RESOLUTION_W + 67.2) / KAT_WATCH_RESOLUTION_W);
                y = QUOTE((KAT_WATCH_RESOLUTION_H + 10.4) / KAT_WATCH_RESOLUTION_H);
                w = "0.020625 * safezoneW / ((getResolution select 5) * 1.7777)";
                h = "0.022 * safezoneH / ((getResolution select 5) * 1.7777)";
                sizeEx = QUOTE(KAT_POS_H(0.95));
            };
        };
    };
};