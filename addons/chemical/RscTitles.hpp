#define KAT_CHEM_GRID_WAbs            (((safezoneW / safezoneH) min 0.7))
#define KAT_CHEM_GRID_HAbs            ((((safezoneW / safezoneH) min 1.2) / 1.6))
#define KAT_CHEM_GRID_W            ((((safeZoneW / safeZoneH) min 0.7) / 40))
#define KAT_CHEM_GRID_H            (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define KAT_CHEM_GRID_X            ((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 11))
#define KAT_CHEM_GRID_Y            ((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 0.8))

#define KAT_CHEM_POS_H(N) ((N) * KAT_CHEM_GRID_H)

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

class RscTitles
{
    class KAT_GasmaskOverlay {
        idd = -1;
        duration = 10e10;
        fadeIn = 0;
        fadeOut = 0;
        name = "KAT_GasmaskOverlay";
        onLoad = "uiNamespace setVariable ['CBRN_GasmaskOverlay', _this select 0];";
        onUnload = "uiNamespace setVariable ['CBRN_GasmaskOverlay', displayNull];";
        class controls {
            class KAT_GasmaskOverlay_Picture: RscPicture {
                idc = -1;
                text = "x\kat\addons\chemical\UI\overlay_style_m50.paa";
                x = QUOTE(safeZoneX);
                y = QUOTE(safeZoneY);
                w = QUOTE(safeZoneW);
                h = QUOTE(safeZoneH);
                style = 48; // ST_PICTURE
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {1, 1, 1, 1};
            };
        };
    };
    class KAT_GasmaskOverlay_m04 {
        idd = -1;
        duration = 10e10;
        fadeIn = 0;
        fadeOut = 0;
        name = "KAT_GasmaskOverlay";
        onLoad = "uiNamespace setVariable ['CBRN_GasmaskOverlay', _this select 0];";
        onUnload = "uiNamespace setVariable ['CBRN_GasmaskOverlay', displayNull];";
        class controls {
            class KAT_GasmaskOverlay_Picture: RscPicture {
                idc = -1;
                text = "x\kat\addons\chemical\UI\m04_overlay_ca.paa";
                x = QUOTE(safeZoneX);
                y = QUOTE(safeZoneY);
                w = QUOTE(safeZoneW);
                h = QUOTE(safeZoneH);
                style = 48; // ST_PICTURE
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {1, 1, 1, 1};
            };
        };
    };

    class KAT_ChemicalDetector
    {
        idd = 18835;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_ChemicalDetector', _this select 0];";
        class controls
        {
            class KatChemIcon: RscPicture
            {
                idc = 18801;
                text = "\x\kat\addons\chemical\UI\kat_chemicalDet.paa";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(15));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(25));
                w = QUOTE(FRAME_W(25));
                h = QUOTE(FRAME_H(25));
            };
            class Background: RscText
            {
                idc = 18802;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(6.5));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(7.3));
                w = QUOTE(FRAME_W(9.8));
                h = QUOTE(FRAME_H(5));
                colorBackground[] = {0, 0, 0, 0};
            };
            class KatChemTime: RscText
            {
                idc = 18804;
                style = ST_CENTER;
                shadow = 0;
                font = "PuristaBold";
                text = "12:00"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(7.2));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(6));
                w = QUOTE(FRAME_W(7.5));
                h = QUOTE(FRAME_H(4));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.3,0.3,0.3,0.8};
                sizeEx = QUOTE(FRAME_H(2));
            };
            class KatChemStrength: RscText
            {
                idc = 18805;
                style = ST_RIGHT;
                valign = "middle";
                shadow = 0;
                font = "PuristaBold";
                text = "0"; //--- ToDo: Localize;
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(25) - FRAME_W(2.1));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(7.5));
                w = QUOTE(FRAME_W(5));
                h = QUOTE(FRAME_H(3));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.3,0.3,0.3,0.8};
                sizeEx = QUOTE(FRAME_H(2.2));
            };
        };
    };
};
