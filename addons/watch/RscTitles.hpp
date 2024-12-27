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
#define pixelScale  0.50

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
                style = ST_LEFT;
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
                style = ST_LEFT;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "01"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(0.8));
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
    class KAT_Cavmin
    {
        idd = 20935;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_Cavmin', _this select 0];";
        class controls
        {
            class CavminImage: RscPicture
            {
                idc = 20800;
                text = "\x\kat\addons\watch\UI\watch_cavmin.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(18.5));
                w = QUOTE(FRAME_W(25));
                h = QUOTE(FRAME_H(25));
            };
            class CavminCompass: CavminImage
            {
                idc = 20802;
                text = "\x\kat\addons\watch\UI\watch_cavmin_compass.paa";
            };
            class CavminOverlay: CavminImage
            {
                idc = 20803;
                text = "\x\kat\addons\watch\UI\watch_cavmin_face.paa";
            };
            class CavminTime: RscText
            {
                idc = 20804;
                style = ST_CENTER;
                shadow = 0;
                font = "EtelkaMonospacePro";
                text = "12:00"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(6.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(5.7));
                w = QUOTE(FRAME_W(7.5));
                h = QUOTE(FRAME_H(4));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(3));
            };
            class CavminHR: RscText
            {
                idc = 20805;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "EtelkaMonospaceProBold";
                text = "80"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(7.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(9.1));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(2));
            };
            class CavminAltitude: RscText
            {
                idc = 20806;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "EtelkaMonospaceProBold";
                text = "1000";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(0.3));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(9.1));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(2));
            };
            class CavminBearing: RscText
            {
                idc = 20807;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "EtelkaMonospaceProBold";
                text = "1000";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(6.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(8.8));
                w = QUOTE(FRAME_W(7.5));
                h = QUOTE(FRAME_H(4));
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                sizeEx = QUOTE(FRAME_H(2.5));
            };
        };
    };
    class KAT_sts
    {
        idd = 21935;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_STS', _this select 0];";
        class controls
        {
            class STSImage: RscPicture
            {
                idc = 21800;
                text = "\x\kat\addons\watch\UI\watch_sts.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(18.5));
                w = QUOTE(FRAME_W(25));
                h = QUOTE(FRAME_H(25));
            };
            class StsBigAlt: STSImage
            {
                idc = 21802;
                text = "\x\kat\addons\watch\UI\watch_sts_bigAlt.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(20.65));
                w = QUOTE(FRAME_W(25));
                h = QUOTE(FRAME_H(25));
            };
            class StsSmallAlt: StsBigAlt
            {
                idc = 21803;
                text = "\x\kat\addons\watch\UI\watch_sts_smallAlt.paa";
            };
            class STSTime: RscText
            {
                idc = 21804;
                style = ST_CENTER;
                shadow = 0;
                font = "PuristaMedium";
                text = "12:00"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(6.4));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(3.6));
                w = QUOTE(FRAME_W(7.5));
                h = QUOTE(FRAME_H(4));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.7,0.7,0.7,1};
                sizeEx = QUOTE(FRAME_H(2.5));
            };
            class STSHR: RscText
            {
                idc = 21805;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaMedium";
                text = "80"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(8.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(6));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.7,0.7,0.7,1};
                sizeEx = QUOTE(FRAME_H(2));
            };
            class STSO2: RscText
            {
                idc = 21806;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaMedium";
                text = "1000";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(-0.6));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(6));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.7,0.7,0.7,1};
                sizeEx = QUOTE(FRAME_H(2));
            };
            class STSAltitude: RscText
            {
                idc = 21807;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaMedium";
                text = "1000";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(6.3));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(13.4));
                w = QUOTE(FRAME_W(7.5));
                h = QUOTE(FRAME_H(4));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.7,0.7,0.7,1};
                sizeEx = QUOTE(FRAME_H(2.2));
            };
            class STSDescent: RscText
            {
                idc = 21808;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "PuristaSemibold";
                text = "0";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(1));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(11.1));
                w = QUOTE(FRAME_W(2.5));
                h = QUOTE(FRAME_H(1.7));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.7,0.7,0.7,1};
                sizeEx = QUOTE(FRAME_H(1));
            };
        };
    };
    class KAT_Ranger
    {
        idd = 22935;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_Ranger', _this select 0];";
        class controls
        {
            class RangerImage: RscPicture
            {
                idc = 22800;
                text = "\x\kat\addons\watch\UI\RangerWatchFace.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15.07));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(20));
                w = QUOTE(FRAME_W(28));
                h = QUOTE(FRAME_H(28));
            };
            class RangerTime: RscText
            {
                idc = 22806;
                style = ST_RIGHT;
                shadow = 0;
                font = "EtelkaMonospacePro";
                text = "22:22:22"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(4.7));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(5.9));
                w = QUOTE(FRAME_W(7.5));
                h = QUOTE(FRAME_H(4));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.8,0.8,0.8,0.9};
                sizeEx = QUOTE(FRAME_H(1.9));
            };
            class RangerTimer: RscText
            {
                idc = 22807;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "EtelkaMonospacePro";
                text = ""; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(24.6));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(7.5));
                w = QUOTE(FRAME_W(3));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.8,0.8,0.8,0.9};
                sizeEx = QUOTE(FRAME_H(1.8));
            };
            class RangerAltitude: RscText
            {
                idc = 22808;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "EtelkaMonospacePro";
                text = "1000";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(5.5));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(7.5));
                w = QUOTE(FRAME_W(4));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.8,0.8,0.8,0.9};
                sizeEx = QUOTE(FRAME_H(1.8));
            };
            class RangerHR: RscText
            {
                idc = 22809;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "EtelkaMonospacePro";
                text = "111";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(4.3));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(10.1));
                w = QUOTE(FRAME_W(4));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.8,0.8,0.8,0.9};
                sizeEx = QUOTE(FRAME_H(1.4));
            };
            class RangerO2: RscText
            {
                idc = 22810;
                style = ST_CENTER;
                valign = "middle";
                shadow = 0;
                font = "EtelkaMonospacePro";
                text = "97";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(1.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(10.1));
                w = QUOTE(FRAME_W(3));
                h = QUOTE(FRAME_H(1.5));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.8,0.8,0.8,0.9};
                sizeEx = QUOTE(FRAME_H(1.4));
            };
            class RangerWatchMinute: RscPicture
            {
                idc = 22802;
                text = "\x\kat\addons\watch\UI\RangerWatchMinute.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(20));
                w = QUOTE(FRAME_W(28));
                h = QUOTE(FRAME_H(28));
            };
            class RangerWatchHour: RangerWatchMinute
            {
                idc = 22803;
                text = "\x\kat\addons\watch\UI\RangerWatchHour.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(20));
                w = QUOTE(FRAME_W(28));
                h = QUOTE(FRAME_H(28));
            };
            class RangerWatchSecond: RangerWatchMinute
            {
                idc = 22804;
                text = "\x\kat\addons\watch\UI\RangerWatchSecond.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(20));
                w = QUOTE(FRAME_W(28));
                h = QUOTE(FRAME_H(28));
            };
            class RangerWatchCaps: RangerImage
            {
                idc = 22805;
                text = "\x\kat\addons\watch\UI\RangerWatchCaps.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15.07));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(20));
                w = QUOTE(FRAME_W(28));
                h = QUOTE(FRAME_H(28));
            };
        };
    };
};