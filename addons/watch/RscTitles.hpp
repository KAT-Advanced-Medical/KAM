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

#define SAFEZONE_X_RIGHTEDGE ((safeZoneX - 1) * -1)
#define SAFEZONE_Y_LOWEDGE ((safeZoneY - 1) * -1)

#define FRAME_W(N) ((UI_GRID_W * (N)) * (1.7777 / (getResolution select 4)))
#define FRAME_H(N) ((UI_GRID_H * (N)))

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
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(18.5));
                w = QUOTE(FRAME_W(25));
                h = QUOTE(FRAME_H(25));
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
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(7.5));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(8.1));
                w = QUOTE(FRAME_W(7.5));
                h = QUOTE(FRAME_H(4));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(3.1));
            };
            class KatminMonth: RscText
            {
                idc = 22001;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "JAN"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(0.8));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(7.3));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(1.3));
            };
            class KatminDay: RscText
            {
                idc = 22002;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "01"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(6.3));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(1.3));
            };
            class KatminBaro: RscText
            {
                idc = 22003;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "760"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(1.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(8.8));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(1.4));
            };
            class KatminHR: RscText
            {
                idc = 22004;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "80"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(2.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(4.7));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(1.8));
            };
            class KatminO2: RscText
            {
                idc = 22005;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "97"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(5.5));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(4.7));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(1.8));
            };
            class KatminTemp: RscText
            {
                idc = 22006;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "76F"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(3.7));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(8.8));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(1.4));
            };
            class KatminAltitude: RscText
            {
                idc = 22007;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "1000";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(6.4));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(8.8));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(1.4));
            };
        };
    };
};