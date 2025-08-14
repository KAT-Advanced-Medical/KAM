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

class RscPicture;
class RscTitles
{
    class KAT_EyeShield
    {
        idd = 17101;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_EyeShield', _this select 0];";
        class controls
        {
            class EyeShieldRight: RscPicture
            {
                idc = 17102;
                text = "\x\kat\addons\ophthalmology\UI\RightEyeShield.paa";
                show = 0;
                x = QUOTE(safeZoneXAbs);
                y = QUOTE(safeZoneY);
                w = QUOTE(safeZoneWAbs);
                h = QUOTE(safeZoneH);
            };
            class EyeShieldLeft: EyeShieldRight
            {
                idc = 17103;
                text = "\x\kat\addons\ophthalmology\UI\LeftEyeShield.paa";
            };
        };
    };
};