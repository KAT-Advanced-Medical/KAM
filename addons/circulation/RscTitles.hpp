#include "defines.hpp"

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
class RscTitles
{
    class CPR_PulseOx
    {
        idd = 22835;
        enableSimulation = 1;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['kat_pulseox', _this select 0];";
        class controls
        {
            class KatPulseOxIcon: RscPicture
            {
                idc = 22801;
                text = "\x\kat\addons\circulation\UI\kat_pulseox.paa";
                x = QUOTE(0.5 - (FRAME_W(25) / 2));
                y = QUOTE(0.5 - (FRAME_H(45) / 2));
                w = QUOTE(FRAME_W(30));
                h = QUOTE(FRAME_H(30));
            };
            class KatPulseOxSpo2: RscText
            {
                idc = 22802;
                x = QUOTE(0.5 - (FRAME_W(1) / 2));
                y = QUOTE(0.5 - (FRAME_H(25) / 2));
                w = QUOTE(FRAME_W(10));
                h = QUOTE(FRAME_H(10));
                type = 0;
                style = 0;
                font = "RobotoCondensed";
                sizeEx = QUOTE(KAT_GRID_H * 1.7 * (0.55 / (getResolution select 5)));
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.8,0.8,0,1};
                text = "O2";
            };
            class KatPulseOxHR: KatPulseOxSpo2
            {
                idc = 22803;
                x = QUOTE(0.5 + (FRAME_W(7) / 2));
                text = "HR";
            };
        };
    };

    class CPR_AED_X
    {
        idd = IDC_AEDX_MONITOR_TITLE;
        movingEnable = 0;
        fadeIn=0;
        fadeOut=1;
        duration = 10e10;
        onLoad = "uiNamespace setVariable ['KAT_Circulation_AEDX_Monitor_Display', _this select 0];";
        objects[] = {};

        class ControlsBackground {
            class BlackBackground_Title: RscText {
                idc = -1;
                x = QUOTE(KAT_pxToScreen_X(450));
                y = QUOTE(KAT_pxToScreen_Y(290));
                w = QUOTE(KAT_pxToScreen_W(1062));
                h = QUOTE(KAT_pxToScreen_H(824));
                type = 0;
                style = 80;
                colorBackground[] = {0,0,0,1};
                colorText[] = {0,0,0,1};
                text = "";
            };
            class Background: BlackBackground_Title {};
            class EKG_Title: RscPicture {
                idc = IDC_EKG_DISPLAY_TITLE;
                x = QUOTE(KAT_pxToScreen_X(475));
                y = QUOTE(KAT_pxToScreen_Y(234));
                w = QUOTE(KAT_pxToScreen_W(1024));
                h = QUOTE(KAT_pxToScreen_H(1024));
                type = 0;
                style = 48;
                size = 0;
                colorBackground[] = {0,0,0,1};
                colorText[] = {1,1,1,1};
                text = QPATHTOF(ui\ekg_off.paa);
            };
            class EKGSlider_Title: RscPicture {
                idc = IDC_EKG_SLIDER_TITLE;
                x = QUOTE(KAT_pxToScreen_X(250));
                y = QUOTE(KAT_pxToScreen_Y(426));
                w = QUOTE(KAT_pxToScreen_W(256));
                h = QUOTE(KAT_pxToScreen_H(256));
                type = 0;
                style = 48;
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                text = QPATHTOF(ui\ekg_slider.paa);
            };
            class HeartRateVitalsDisplayBackground_Title: RscText {
                idc = IDC_DISPLAY_HEARTRATE_TEXT_TITLE;
                x = QUOTE(KAT_pxToScreen_X(552));
                y = QUOTE(KAT_pxToScreen_Y(866));
                w = QUOTE(KAT_pxToScreen_W(190));
                h = QUOTE(KAT_pxToScreen_H(30));
                type = 0;
                style = 0;
                font = "RobotoCondensed";
                sizeEx = QUOTE(KAT_GRID_H * 0.6 * (0.55 / (getResolution select 5)));
                shadow = 0;
                colorBackground[] = {0.77,0.96,0.32,1};
                colorText[] = {0,0,0,1};
                text = "HR";
            };
            class HeartRateVitalsDisplayBackgroundText_Title: HeartRateVitalsDisplayBackground_Title {
                idc = -1;
                style = 1;
                colorBackground[] = {0,0,0,0};
                font = "RobotoCondensedLight";
                text = "bpm";
            };
            class BloodPressureVitalsDisplayBackground_Title: HeartRateVitalsDisplayBackground_Title {
                idc = -1;
                x = QUOTE(KAT_pxToScreen_X(746));
                w = QUOTE(KAT_pxToScreen_W(260));
                colorBackground[] = {0.04,0.96,0.98,1};
                colorText[] = {0,0,0,1};
                text = "NIBP";
            };
            class BloodPressureVitalsDisplayBackgroundText_Title: BloodPressureVitalsDisplayBackground_Title {
                idc = -1;
                style = 1;
                colorBackground[] = {0,0,0,0};
                font = "RobotoCondensedLight";
                text = "mmHg";
            };
            class BloodPressureVitalsDisplayLine_Title: RscText
            {
                idc = -1;
                style = 2;
                x = QUOTE(KAT_pxToScreen_X(760));
                y = QUOTE(KAT_pxToScreen_Y(979));
                w = QUOTE(KAT_pxToScreen_W(120));
                h = QUOTE(KAT_pxToScreen_H(3));
                colorBackground[] = {0.04,0.96,0.98,1};
                colorText[] = {1,1,1,1};
                text = "";
            };
            class RespirationRateDisplayBackground_Title: HeartRateVitalsDisplayBackground_Title {
                idc = -1;
                x = QUOTE(KAT_pxToScreen_X(1010));
                colorBackground[] = {0.73,0.02,0.74,1};
                colorText[] = {0,0,0,1};
                text = "Resp";
            };
            class RespirationRateDisplayBackgroundText_Title: RespirationRateDisplayBackground_Title {
                idc = -1;
                style = 1;
                colorBackground[] = {0,0,0,0};
                font = "RobotoCondensedLight";
                text = "/min";
            };
            class SpO2DisplayBackground_Title: HeartRateVitalsDisplayBackground_Title {
                idc = -1;
                x = QUOTE(KAT_pxToScreen_X(1204));
                colorBackground[] = {0.99,0.97,0.02,1};
                colorText[] = {0,0,0,1};
                text = "SpO2";
            };
            class SpO2DisplayBackgroundText_Title: SpO2DisplayBackground_Title {
                idc = -1;
                style = 1;
                colorBackground[] = {0,0,0,0};
                font = "RobotoCondensedLight";
                text = "%";
            };
            class SpO2PulseRateDisplayBorder_Title: RscText {
                idc = IDC_DISPLAY_PULSERATEBORDER_TITLE;
                x = QUOTE(KAT_pxToScreen_X(1366));
                y = QUOTE(KAT_pxToScreen_Y(907));
                w = QUOTE(KAT_pxToScreen_W(26));
                h = QUOTE(KAT_pxToScreen_H(80));
                type = 0;
                style = 0;
                font = "RobotoCondensed";
                sizeEx = QUOTE(KAT_GRID_H * 0.6 * (0.55 / (getResolution select 5)));
                shadow = 0;
                colorBackground[] = {0.99,0.97,0.02,1};
                colorText[] = {0,0,0,0};
                text = "";
                show = 0;
            };
            class SpO2PulseRateDisplayBackground_Title: SpO2PulseRateDisplayBorder_Title {
                idc = IDC_DISPLAY_PULSERATEBG_TITLE;
                x = QUOTE(KAT_pxToScreen_X(1368));
                y = QUOTE(KAT_pxToScreen_Y(910));
                w = QUOTE(KAT_pxToScreen_W(20));
                h = QUOTE(KAT_pxToScreen_H(74));
                colorBackground[] = {0,0,0,1};
            };
            class SpO2PulseRateDisplayBar_Title: SpO2PulseRateDisplayBorder_Title {
                idc = IDC_DISPLAY_PULSERATEDSPBAR_TITLE;
                x = QUOTE(KAT_pxToScreen_X(1370));
                y = QUOTE(KAT_pxToScreen_Y(911));
                w = QUOTE(KAT_pxToScreen_W(17));
                h = QUOTE(KAT_pxToScreen_H(71));
            };
            class SpO2PulseRateDisplayBarB_Title: SpO2PulseRateDisplayBar_Title {
                idc = IDC_DISPLAY_PULSERATEBAR_TITLE;
                colorBackground[] = {0,0,0,1};
            };
            class HeartRateDisplay_Title: RscText {
                idc = IDC_DISPLAY_HEARTRATE_TITLE;
                x = QUOTE(KAT_pxToScreen_X(552));
                y = QUOTE(KAT_pxToScreen_Y(896));
                w = QUOTE(KAT_pxToScreen_W(190));
                h = QUOTE(KAT_pxToScreen_H(80));
                type = 0;
                style = 2;
                font = "RobotoCondensed";
                sizeEx = QUOTE(KAT_GRID_H * 2.5 * (0.55 / (getResolution select 5)));
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.77,0.96,0.32,1};
                text = "---";
            };
            class TopBloodPressureDisplay_Title: HeartRateDisplay_Title {
                idc = IDC_DISPLAY_BLOODPRESSURE_T_TITLE;
                style = 1;
                x = QUOTE(KAT_pxToScreen_X(760));
                w = QUOTE(KAT_pxToScreen_W(120));
                h = QUOTE(KAT_pxToScreen_H(70));
                sizeEx = QUOTE(KAT_GRID_H * 1.8 * (0.55 / (getResolution select 5)));
                colorText[] = {0.04,0.96,0.98,1};
                text = "---";
            };
            class BottomBloodPressureDisplay_Title: TopBloodPressureDisplay_Title {
                idc = IDC_DISPLAY_BLOODPRESSURE_B_TITLE;
                y = QUOTE(KAT_pxToScreen_Y(990));
                colorText[] = {0.04,0.96,0.98,1};
                text = "---";
            };
            class MeanBloodPressureDisplay_Title: TopBloodPressureDisplay_Title {
                idc = IDC_DISPLAY_BLOODPRESSURE_M_TITLE;
                x = QUOTE(KAT_pxToScreen_X(910));
                w = QUOTE(KAT_pxToScreen_W(100));
                h = QUOTE(KAT_pxToScreen_H(60));
                sizeEx = QUOTE(KAT_GRID_H * 1.1 * (0.55 / (getResolution select 5)));
                colorText[] = {0.04,0.96,0.98,1};
                text = "";
            };
            class RespirationRateDisplay_Title: HeartRateDisplay_Title {
                idc = IDC_DISPLAY_RESP_TITLE;
                x = QUOTE(KAT_pxToScreen_X(1010));
                h = QUOTE(KAT_pxToScreen_H(120));
                sizeEx = QUOTE(KAT_GRID_H * 0.7 * (0.55 / (getResolution select 5)));
                colorText[] = {0.73,0.02,0.74,1};
                text = "Resp off";
            };
            class SpO2Display_Title: HeartRateDisplay_Title {
                idc = IDC_DISPLAY_SPO2_TITLE;
                x = QUOTE(KAT_pxToScreen_X(1200));
                w = QUOTE(KAT_pxToScreen_W(170));
                colorText[] = {0.99,0.97,0.02,1};
                text = "---";
            };
            class DateAndTime_Title: RscText {
                idc = IDC_DISPLAY_DATEANDTIME_TITLE;
                x = QUOTE(KAT_pxToScreen_X(505));
                y = QUOTE(KAT_pxToScreen_Y(318));
                w = QUOTE(KAT_pxToScreen_W(400));
                h = QUOTE(KAT_pxToScreen_H(40));
                type = 0;
                style = 0;
                font = "RobotoCondensed";
                sizeEx = QUOTE(KAT_GRID_H * 0.8 * (0.55 / (getResolution select 5)));
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                text = "00/00/0000               00:00";
            };
            class Battery_Title: RscPicture {
                idc = -1;
                x = QUOTE(KAT_pxToScreen_X(1256));
                y = QUOTE(KAT_pxToScreen_Y(322));
                w = QUOTE(KAT_pxToScreen_W(64));
                h = QUOTE(KAT_pxToScreen_H(64));
                style = 48;
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                text = QPATHTOF(ui\battery.paa);
            };
            class ElapsedTime_Title: DateAndTime_Title {
                idc = IDC_DISPLAY_ELAPSEDTIME_TITLE;
                x = QUOTE(KAT_pxToScreen_X(1335));
                w = QUOTE(KAT_pxToScreen_W(130));
                style = 2;
                text = "00:00:00";
            };
            class AEDBackground_Title: RscPicture {
                idc = -1;
                x = QUOTE(KAT_GUI_GRID_X);
                y = QUOTE(KAT_pxToScreen_Y(-300));
                w = QUOTE(KAT_GUI_GRID_W);
                h = QUOTE(KAT_GUI_GRID_H);
                type = 0;
                style = 48;
                font = "TahomaB";
                size = 0;
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                text = QPATHTOF(ui\zoll.paa);
            };
            class ShockButton_Title: RscPicture {
                idc = IDC_SHOCKBUTTON;
                x = QUOTE(KAT_pxToScreen_X(1487));
                y = QUOTE(KAT_pxToScreen_Y(1080));
                w = QUOTE(KAT_pxToScreen_W(256));
                h = QUOTE(KAT_pxToScreen_H(256));
                style = 48;
                colorBackground[] = {0,0,0,0};
                colorText[] = {1,1,1,1};
                text = QPATHTOF(ui\shockbutton.paa);
                show = 0;
            };
        };
    };
};
