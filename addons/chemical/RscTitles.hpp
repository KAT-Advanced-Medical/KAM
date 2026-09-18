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
    class KAT_M8Paper
    {
        idd = 18840;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn = 0.3;
        fadeOut = 1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_M8Paper', _this select 0];";

        // Bottom-center anchor. Card is FRAME_W(54) wide × FRAME_H(19) tall.
        // CARD_X = horizontal center minus half width.
        // CARD_Y = bottom edge minus card height minus small margin.
        #define KAT_M8_CARD_X (safeZoneX + safeZoneW * 0.5 - FRAME_W(27))
        #define KAT_M8_CARD_Y (SAFEZONE_Y_LOWEDGE - FRAME_H(23))

        class controls
        {
            // Paper background — cream texture fills the card.
            class KatM8PaperBg: RscPicture
            {
                idc = 18841;
                shadow = 0;
                text = "\x\kat\addons\chemical\ui\m8paper_blank.paa";
                x = QUOTE(KAT_M8_CARD_X);
                y = QUOTE(KAT_M8_CARD_Y);
                w = QUOTE(FRAME_W(54));
                h = QUOTE(FRAME_H(19));
                colorText[] = {1, 1, 1, 1};
            };
            // "M8 DETECTION PAPER" header (top of card).
            class KatM8PaperHeader: RscText
            {
                idc = 18842;
                style = ST_CENTER;
                shadow = 0;
                font = "PuristaBold";
                text = "$STR_KAT_Chemical_M8_Header";
                x = QUOTE(KAT_M8_CARD_X);
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(0.7));
                w = QUOTE(FRAME_W(54));
                h = QUOTE(FRAME_H(2.3));
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {0.20, 0.15, 0.08, 1};
                sizeEx = QUOTE(FRAME_H(1.5));
            };
            // Stain — left side of card, color tint set at runtime.
            class KatM8PaperStain: RscPicture
            {
                idc = 18843;
                shadow = 0;
                text = "\x\kat\addons\chemical\ui\m8paper_stain.paa";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(3.3));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(4));
                w = QUOTE(FRAME_W(17));
                h = QUOTE(FRAME_H(13));
                colorText[] = {1, 1, 1, 0}; // alpha 0 by default = invisible (negative)
            };
            // Legend swatches + labels — right side of card.
            // Yellow (G-series nerve)
            class KatM8PaperLegendYellow: RscText
            {
                idc = 18850;
                shadow = 0;
                text = "";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(25));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(4.7));
                w = QUOTE(FRAME_W(2.7));
                h = QUOTE(FRAME_H(2));
                colorBackground[] = {0.95, 0.85, 0.15, 1};
            };
            class KatM8PaperLegendYellowText: RscText
            {
                idc = 18851;
                style = ST_LEFT;
                shadow = 0;
                font = "PuristaBold";
                text = "$STR_KAT_Chemical_M8_Legend_G";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(29));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(4.7));
                w = QUOTE(FRAME_W(23));
                h = QUOTE(FRAME_H(2));
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {0.20, 0.15, 0.08, 1};
                sizeEx = QUOTE(FRAME_H(1.2));
            };
            // Green (V-series nerve)
            class KatM8PaperLegendGreen: RscText
            {
                idc = 18852;
                shadow = 0;
                text = "";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(25));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(7.7));
                w = QUOTE(FRAME_W(2.7));
                h = QUOTE(FRAME_H(2));
                colorBackground[] = {0.20, 0.40, 0.15, 1};
            };
            class KatM8PaperLegendGreenText: RscText
            {
                idc = 18853;
                style = ST_LEFT;
                shadow = 0;
                font = "PuristaBold";
                text = "$STR_KAT_Chemical_M8_Legend_V";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(29));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(7.7));
                w = QUOTE(FRAME_W(23));
                h = QUOTE(FRAME_H(2));
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {0.20, 0.15, 0.08, 1};
                sizeEx = QUOTE(FRAME_H(1.2));
            };
            // Red (Blister / mustard)
            class KatM8PaperLegendRed: RscText
            {
                idc = 18854;
                shadow = 0;
                text = "";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(25));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(10.7));
                w = QUOTE(FRAME_W(2.7));
                h = QUOTE(FRAME_H(2));
                colorBackground[] = {0.70, 0.10, 0.10, 1};
            };
            class KatM8PaperLegendRedText: RscText
            {
                idc = 18855;
                style = ST_LEFT;
                shadow = 0;
                font = "PuristaBold";
                text = "$STR_KAT_Chemical_M8_Legend_H";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(29));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(10.7));
                w = QUOTE(FRAME_W(23));
                h = QUOTE(FRAME_H(2));
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {0.20, 0.15, 0.08, 1};
                sizeEx = QUOTE(FRAME_H(1.2));
            };
            // Footer — "no mark = clean" hint.
            class KatM8PaperFooter: RscText
            {
                idc = 18856;
                style = ST_CENTER;
                shadow = 0;
                text = "$STR_KAT_Chemical_M8_Footer_Clean";
                x = QUOTE(KAT_M8_CARD_X + FRAME_W(25));
                y = QUOTE(KAT_M8_CARD_Y + FRAME_H(14.7));
                w = QUOTE(FRAME_W(27));
                h = QUOTE(FRAME_H(2));
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {0.35, 0.30, 0.20, 1};
                sizeEx = QUOTE(FRAME_H(1.1));
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

    class KAT_Dosimeter
    {
        idd = 18836;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn = 0;
        fadeOut = 1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_Dosimeter', _this select 0];";
        class controls
        {
            // "DOSIMETER" header, bottom-right corner stack.
            class KatDosiHeader: RscText
            {
                idc = 18813;
                style = ST_RIGHT;
                shadow = 1;
                font = "PuristaBold";
                text = "$STR_KAT_Chemical_Dosimeter_Header";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(22));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(11));
                w = QUOTE(FRAME_W(20));
                h = QUOTE(FRAME_H(3));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.55,0.85,0.35,0.9};
                sizeEx = QUOTE(FRAME_H(2));
            };
            // Current dose-rate (Gy/h).
            class KatDosiRate: RscText
            {
                idc = 18814;
                style = ST_RIGHT;
                shadow = 1;
                font = "PuristaMedium";
                text = "0.000 Gy/h";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(22));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(8));
                w = QUOTE(FRAME_W(20));
                h = QUOTE(FRAME_H(3));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.3,0.3,0.3,0.9};
                sizeEx = QUOTE(FRAME_H(2.2));
            };
            // Accumulated whole-body dose (Gy).
            class KatDosiDose: RscText
            {
                idc = 18815;
                style = ST_RIGHT;
                shadow = 1;
                font = "PuristaMedium";
                text = "0.000 Gy";
                x = QUOTE(SAFEZONE_X_RIGHTEDGE - FRAME_W(22));
                y = QUOTE(SAFEZONE_Y_LOWEDGE - FRAME_H(5));
                w = QUOTE(FRAME_W(20));
                h = QUOTE(FRAME_H(3));
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.3,0.3,0.3,0.9};
                sizeEx = QUOTE(FRAME_H(2.2));
            };
        };
    };
};
