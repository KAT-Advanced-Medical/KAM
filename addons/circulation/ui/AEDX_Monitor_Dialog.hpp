#include "..\defines.hpp"

class RscPicture;
class RscLine;
class RscText;
class RscBackground;
class RscButton;
class RscStructuredText;

class GVAR(AEDX_Monitor_Dialog) {
    idd = IDC_AEDX_MONITOR;
    movingEnable = 0;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(AEDX_Monitor_Display),(_this select 0))]);
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(AEDX_Monitor_Display),nil)]);
    objects[] = {};

    class ControlsBackground {
        class BlackBackground: RscText {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(450));
            y = QUOTE(KAT_pxToScreen_Y(590));
            w = QUOTE(KAT_pxToScreen_W(1062));
            h = QUOTE(KAT_pxToScreen_H(824));
            type = 0;
            style = 80;
            colorBackground[] = {0,0,0,1};
            colorText[] = {0,0,0,1};
            text = "";
        };
        class Background: BlackBackground {};
        class EKG: RscPicture {
            idc = IDC_EKG_DISPLAY;
            x = QUOTE(KAT_pxToScreen_X(475));
            y = QUOTE(KAT_pxToScreen_Y(534));
            w = QUOTE(KAT_pxToScreen_W(1024));
            h = QUOTE(KAT_pxToScreen_H(1024));
            type = 0;
            style = 48;
            size = 0;
            colorBackground[] = {0,0,0,1};
            colorText[] = {1,1,1,1};
            text = QPATHTOF(ui\ekg_off.paa);
        };
        class EKGSlider: RscPicture {
            idc = IDC_EKG_SLIDER;
            x = QUOTE(KAT_pxToScreen_X(250));
            y = QUOTE(KAT_pxToScreen_Y(726));
            w = QUOTE(KAT_pxToScreen_W(256));
            h = QUOTE(KAT_pxToScreen_H(256));
            type = 0;
            style = 48;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            text = QPATHTOF(ui\ekg_slider.paa);
        };
        class HeartRateVitalsDisplayBackground: RscText {
            idc = IDC_DISPLAY_HEARTRATE_TEXT;
            x = QUOTE(KAT_pxToScreen_X(552));
            y = QUOTE(KAT_pxToScreen_Y(1166));
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
        class HeartRateVitalsDisplayBackgroundText: HeartRateVitalsDisplayBackground {
            idc = -1;
            style = 1;
            colorBackground[] = {0,0,0,0};
            font = "RobotoCondensedLight";
            text = "bpm";
        };
        class BloodPressureVitalsDisplayBackground: HeartRateVitalsDisplayBackground {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(746));
            w = QUOTE(KAT_pxToScreen_W(260));
            colorBackground[] = {0.04,0.96,0.98,1};
            colorText[] = {0,0,0,1};
            text = "NIBP";
        };
        class BloodPressureVitalsDisplayBackgroundText: BloodPressureVitalsDisplayBackground {
            idc = -1;
            style = 1;
            colorBackground[] = {0,0,0,0};
            font = "RobotoCondensedLight";
            text = "mmHg";
        };
        class BloodPressureVitalsDisplayLine: RscText
        {
            idc = -1;
            style = 2;
            x = QUOTE(KAT_pxToScreen_X(760));
            y = QUOTE(KAT_pxToScreen_Y(1279));
            w = QUOTE(KAT_pxToScreen_W(120));
            h = QUOTE(KAT_pxToScreen_H(3));
            colorBackground[] = {0.04,0.96,0.98,1};
            colorText[] = {1,1,1,1};
            text = "";
        };
        class RespirationRateDisplayBackground: HeartRateVitalsDisplayBackground {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(1010));
            colorBackground[] = {0.73,0.02,0.74,1};
            colorText[] = {0,0,0,1};
            text = "Resp";
        };
        class RespirationRateDisplayBackgroundText: RespirationRateDisplayBackground {
            idc = -1;
            style = 1;
            colorBackground[] = {0,0,0,0};
            font = "RobotoCondensedLight";
            text = "/min";
        };
        class SpO2DisplayBackground: HeartRateVitalsDisplayBackground {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(1204));
            colorBackground[] = {0.99,0.97,0.02,1};
            colorText[] = {0,0,0,1};
            text = "SpO2";
        };
        class SpO2DisplayBackgroundText: SpO2DisplayBackground {
            idc = -1;
            style = 1;
            colorBackground[] = {0,0,0,0};
            font = "RobotoCondensedLight";
            text = "%";
        };
        class SpO2PulseRateDisplayBorder: RscText {
            idc = IDC_DISPLAY_PULSERATEBORDER;
            x = QUOTE(KAT_pxToScreen_X(1366));
            y = QUOTE(KAT_pxToScreen_Y(1207));
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
        class SpO2PulseRateDisplayBackground: SpO2PulseRateDisplayBorder {
            idc = IDC_DISPLAY_PULSERATEBG;
            x = QUOTE(KAT_pxToScreen_X(1368));
            y = QUOTE(KAT_pxToScreen_Y(1210));
            w = QUOTE(KAT_pxToScreen_W(20));
            h = QUOTE(KAT_pxToScreen_H(74));
            colorBackground[] = {0,0,0,1};
        };
        class SpO2PulseRateDisplayBar: SpO2PulseRateDisplayBorder {
            idc = IDC_DISPLAY_PULSERATEDSPBAR;
            x = QUOTE(KAT_pxToScreen_X(1370));
            y = QUOTE(KAT_pxToScreen_Y(1211));
            w = QUOTE(KAT_pxToScreen_W(17));
            h = QUOTE(KAT_pxToScreen_H(71));
        };
        class SpO2PulseRateDisplayBarB: SpO2PulseRateDisplayBar {
            idc = IDC_DISPLAY_PULSERATEBAR;
            colorBackground[] = {0,0,0,1};
        };
        class HeartRateDisplay: RscText {
            idc = IDC_DISPLAY_HEARTRATE;
            x = QUOTE(KAT_pxToScreen_X(552));
            y = QUOTE(KAT_pxToScreen_Y(1196));
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
        class TopBloodPressureDisplay: HeartRateDisplay {
            idc = IDC_DISPLAY_BLOODPRESSURE_T;
            style = 1;
            x = QUOTE(KAT_pxToScreen_X(760));
            w = QUOTE(KAT_pxToScreen_W(120));
            h = QUOTE(KAT_pxToScreen_H(70));
            sizeEx = QUOTE(KAT_GRID_H * 1.8 * (0.55 / (getResolution select 5)));
            colorText[] = {0.04,0.96,0.98,1};
            text = "---";
        };
        class BottomBloodPressureDisplay: TopBloodPressureDisplay {
            idc = IDC_DISPLAY_BLOODPRESSURE_B;
            y = QUOTE(KAT_pxToScreen_Y(1290));
            colorText[] = {0.04,0.96,0.98,1};
            text = "---";
        };
        class MeanBloodPressureDisplay: TopBloodPressureDisplay {
            idc = IDC_DISPLAY_BLOODPRESSURE_M;
            x = QUOTE(KAT_pxToScreen_X(910));
            w = QUOTE(KAT_pxToScreen_W(100));
            h = QUOTE(KAT_pxToScreen_H(60));
            sizeEx = QUOTE(KAT_GRID_H * 1.1 * (0.55 / (getResolution select 5)));
            colorText[] = {0.04,0.96,0.98,1};
            text = "";
        };
        class RespirationRateDisplay: HeartRateDisplay {
            idc = IDC_DISPLAY_RESP;
            x = QUOTE(KAT_pxToScreen_X(1010));
            h = QUOTE(KAT_pxToScreen_H(120));
            sizeEx = QUOTE(KAT_GRID_H * 0.7 * (0.55 / (getResolution select 5)));
            colorText[] = {0.73,0.02,0.74,1};
            text = "Resp off";
        };
        class SpO2Display: HeartRateDisplay {
            idc = IDC_DISPLAY_SPO2;
            x = QUOTE(KAT_pxToScreen_X(1200));
            w = QUOTE(KAT_pxToScreen_W(170));
            colorText[] = {0.99,0.97,0.02,1};
            text = "---";
        };
        class DateAndTime: RscText {
            idc = IDC_DISPLAY_DATEANDTIME;
            x = QUOTE(KAT_pxToScreen_X(505));
            y = QUOTE(KAT_pxToScreen_Y(618));
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
        class Battery: RscPicture {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(1256));
            y = QUOTE(KAT_pxToScreen_Y(622));
            w = QUOTE(KAT_pxToScreen_W(64));
            h = QUOTE(KAT_pxToScreen_H(64));
            style = 48;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            text = QPATHTOF(ui\battery.paa);
        };
        class ElapsedTime: DateAndTime {
            idc = IDC_DISPLAY_ELAPSEDTIME;
            x = QUOTE(KAT_pxToScreen_X(1335));
            w = QUOTE(KAT_pxToScreen_W(130));
            style = 2;
            text = "00:00:00";
        };
        class topMiddleText: RscText {
            idc = IDC_EKG_DISPLAY_MIDTEXT;
            x = QUOTE(KAT_pxToScreen_X(880));
            y = QUOTE(KAT_pxToScreen_Y(680));
            w = QUOTE(KAT_pxToScreen_W(200));
            h = QUOTE(KAT_pxToScreen_H(100));
            type = 0;
            style = 2;
            font = "RobotoCondensed";
            sizeEx = QUOTE(KAT_GRID_H * 0.6 * (0.55 / (getResolution select 5)));
            shadow = 0;
            colorBackground[] = {0,0,0,0};
            colorText[] = {0,1,0,1};
            text = CSTRING(AEDX_Monitor_CheckPads);
        };
        class ChargingStatusBlackBackground: BlackBackground {
            idc = IDC_CHARGE_BBACKGROUND;
            x = QUOTE(KAT_pxToScreen_X(478));
            y = QUOTE(KAT_pxToScreen_Y(1119));
            w = QUOTE(KAT_pxToScreen_W(1000));
            h = QUOTE(KAT_pxToScreen_H(250));
            show = 0;
        };
        class ChargingStatusBlackBackground2: BlackBackground {
            idc = IDC_CHARGE_BBACKGROUND2;
            x = QUOTE(KAT_pxToScreen_X(1336));
            y = QUOTE(KAT_pxToScreen_Y(601));
            w = QUOTE(KAT_pxToScreen_W(145));
            h = QUOTE(KAT_pxToScreen_H(768));
            show = 0;
        };
        class ChargingStatusDefibrillator: RscText {
            idc = IDC_CHARGE_STATUS_TITLE;
            x = QUOTE(KAT_pxToScreen_X(579));
            y = QUOTE(KAT_pxToScreen_Y(1137));
            w = QUOTE(KAT_pxToScreen_W(400));
            h = QUOTE(KAT_pxToScreen_H(50));
            type = 0;
            style = 2;
            font = "RobotoCondensed";
            sizeEx = QUOTE(KAT_GRID_H * 0.8 * (0.55 / (getResolution select 5)));
            shadow = 0;
            colorBackground[] = {0.05,0.85,0.36,1};
            colorText[] = {0,0,0,1};
            text = CSTRING(AEDX_Monitor_Defibrillator);
            show = 0;
        };
        class ChargingStatus: ChargingStatusDefibrillator {
            idc = IDC_CHARGE_STATUS;
            y = QUOTE(KAT_pxToScreen_Y(1189));
            w = QUOTE(KAT_pxToScreen_W(400));
            h = QUOTE(KAT_pxToScreen_H(172));
            sizeEx = QUOTE(KAT_GRID_H * 1.5 * (0.55 / (getResolution select 5)));
            colorBackground[] = {1,0.35,0,1};
            colorText[] = {0,0,0,1};
            text = CSTRING(AEDX_Monitor_CHARGING);
        };
        class ChargingStatusEnergySelect: ChargingStatusDefibrillator {
            idc = IDC_CHARGE_ENERGY_SELECT;
            x = QUOTE(KAT_pxToScreen_X(1065));
            w = QUOTE(KAT_pxToScreen_W(270));
            text = CSTRING(AEDX_Monitor_SelectedEnergy);
        };
        class ChargingStatusEnergySelectAmount: ChargingStatus {
            idc = IDC_CHARGE_ENERGY_AMOUNT;
            x = QUOTE(KAT_pxToScreen_X(1065));
            w = QUOTE(KAT_pxToScreen_W(270));
            font = "RobotoCondensedBold";
            sizeEx = QUOTE(KAT_GRID_H * 2.5 * (0.55 / (getResolution select 5)));
            colorBackground[] = {0,0,0,1};
            colorText[] = {1,1,1,1};
            text = "150 J";
        };

        class ChargingStatusBarCharged: RscText {
            idc = IDC_CHARGE_BAR_BACKGROUND;
            x = QUOTE(KAT_pxToScreen_X(1344));
            y = QUOTE(KAT_pxToScreen_Y(1360));
            w = QUOTE(KAT_pxToScreen_W(126));
            h = QUOTE(KAT_pxToScreen_H(1));
            type = 0;
            style = 0;
            shadow = 0;
            colorBackground[] = {1,1,1,1};
            colorText[] = {1,1,1,0};
            show = 0;
        };

        class ChargingStatusBar1: RscText {
            idc = IDC_CHARGE_BAR_1;
            x = QUOTE(KAT_pxToScreen_X(1345));
            y = QUOTE(KAT_pxToScreen_Y(1328));
            w = QUOTE(KAT_pxToScreen_W(123));
            h = QUOTE(KAT_pxToScreen_H(28));
            type = 0;
            style = 2;
            font = "RobotoCondensedBold";
            sizeEx = QUOTE(KAT_GRID_H * 0.6 * (0.55 / (getResolution select 5)));
            shadow = 0;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            text = "1";
            show = 0;
        };
        class ChargingStatusBar2: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_2;
            y = QUOTE(KAT_pxToScreen_Y(1294));
            text = "2";
        };
        class ChargingStatusBar3: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_3;
            y = QUOTE(KAT_pxToScreen_Y(1260));
            text = "3";
        };
        class ChargingStatusBar4: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_4;
            y = QUOTE(KAT_pxToScreen_Y(1226));
            text = "4";
        };
        class ChargingStatusBar5: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_5;
            y = QUOTE(KAT_pxToScreen_Y(1192));
            text = "5";
        };
        class ChargingStatusBar6: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_6;
            y = QUOTE(KAT_pxToScreen_Y(1158));
            text = "6";
        };
        class ChargingStatusBar7: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_7;
            y = QUOTE(KAT_pxToScreen_Y(1124));
            text = "7";
        };
        class ChargingStatusBar8: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_8;
            y = QUOTE(KAT_pxToScreen_Y(1090));
            text = "8";
        };
        class ChargingStatusBar9: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_9;
            y = QUOTE(KAT_pxToScreen_Y(1056));
            text = "9";
        };
        class ChargingStatusBar10: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_10;
            y = QUOTE(KAT_pxToScreen_Y(1022));
            text = "10";
        };
        class ChargingStatusBar15: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_15;
            y = QUOTE(KAT_pxToScreen_Y(988));
            text = "15";
        };
        class ChargingStatusBar20: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_20;
            y = QUOTE(KAT_pxToScreen_Y(954));
            text = "20";
        };
        class ChargingStatusBar30: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_30;
            y = QUOTE(KAT_pxToScreen_Y(920));
            text = "30";
        };
        class ChargingStatusBar50: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_50;
            y = QUOTE(KAT_pxToScreen_Y(886));
            text = "50";
        };
        class ChargingStatusBar70: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_70;
            y = QUOTE(KAT_pxToScreen_Y(852));
            text = "70";
        };
        class ChargingStatusBar85: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_85;
            y = QUOTE(KAT_pxToScreen_Y(818));
            text = "85";
        };
        class ChargingStatusBar100: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_100;
            y = QUOTE(KAT_pxToScreen_Y(784));
            text = "100";
        };
        class ChargingStatusBar120: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_120;
            y = QUOTE(KAT_pxToScreen_Y(750));
            text = "120";
        };
        class ChargingStatusBar150: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_150;
            y = QUOTE(KAT_pxToScreen_Y(682));
            h = QUOTE(KAT_pxToScreen_H(66));
            sizeEx = QUOTE(KAT_GRID_H * 1.5 * (0.55 / (getResolution select 5)));
            text = "150";
        };
        class ChargingStatusBar200: ChargingStatusBar1 {
            idc = IDC_CHARGE_BAR_200;
            y = QUOTE(KAT_pxToScreen_Y(648));
            text = "200";
        };
        class ChargingStatusBackground: EKG {
            idc = IDC_CHARGE_BACKGROUND;
            text = QPATHTOF(ui\chargingstatus_bg.paa);
            show = 0;
        };
        class ShockTally: RscText {
            idc = IDC_CHARGE_SHOCKTOTAL;
            x = QUOTE(KAT_pxToScreen_X(980));
            y = QUOTE(KAT_pxToScreen_Y(1282));
            w = QUOTE(KAT_pxToScreen_W(84));
            h = QUOTE(KAT_pxToScreen_H(46));
            type = 0;
            style = 2;
            font = "RobotoCondensedBold";
            sizeEx = QUOTE(KAT_GRID_H * (0.55 / (getResolution select 5)));
            shadow = 0;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            text = "0";
            show = 0;
        };
        class AEDBackground: RscPicture {
            idc = -1;
            x = QUOTE(KAT_GUI_GRID_X);
            y = QUOTE(KAT_GUI_GRID_Y);
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
        class ShockButton: RscPicture {
            idc = IDC_SHOCKBUTTON;
            x = QUOTE(KAT_pxToScreen_X(1487));
            y = QUOTE(KAT_pxToScreen_Y(1380));
            w = QUOTE(KAT_pxToScreen_W(256));
            h = QUOTE(KAT_pxToScreen_H(256));
            style = 48;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            text = QPATHTOF(ui\shockbutton.paa);
            show = 0;
        };
        class AutoModeFeedbackMessageTop: RscText {
            idc = IDC_AEDMODE_MSG_TOP;
            x = QUOTE(KAT_pxToScreen_X(579));
            y = QUOTE(KAT_pxToScreen_Y(1137));
            w = QUOTE(KAT_pxToScreen_W(758));
            h = QUOTE(KAT_pxToScreen_H(61));
            type = 0;
            style = 2;
            font = "RobotoCondensed";
            sizeEx = QUOTE(KAT_GRID_H * 1 * (0.55 / (getResolution select 5)));
            shadow = 0;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            text = "";
            show = 0;
        };
        class AutoModeFeedbackMessage: AutoModeFeedbackMessageTop {
            idc = IDC_AEDMODE_MSG;
            y = QUOTE(KAT_pxToScreen_Y(1198));
            h = QUOTE(KAT_pxToScreen_H(150));
            font = "RobotoCondensedBold";
            sizeEx = QUOTE(KAT_GRID_H * 1.6 * (0.55 / (getResolution select 5)));
            text = "";
        };
        class AEDModeFeedbackMessageBackground: EKG {
            idc = IDC_AEDMODE_MSG_BG;
            text = QPATHTOF(ui\AEDmode_bg.paa);
            show = 0;
        };
    };

    class Controls {
        class ShockButton: RscButton {
            text = "";
            colorText[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,1};
            colorBackground[] = {0,0,0,0};
            colorBackgroundDisabled[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            colorBorder[] = {0,0,0,0};
            soundEnter[] = {};
            soundPush[] = {};
            soundEscape[] = {};
            idc = -1;
            style = 0;
            x = QUOTE(KAT_pxToScreen_X(1537));
            y = QUOTE(KAT_pxToScreen_Y(1430));
            w = QUOTE(KAT_pxToScreen_W(156));
            h = QUOTE(KAT_pxToScreen_H(156));
            shadow = 0;
            font = "RobotoCondensed";
            sizeEx = QUOTE(KAT_GRID_H);
            onButtonClick = QUOTE(if !(GVAR(AEDX_MonitorTarget) isEqualTo objNull) then {if(GVAR(AEDX_MonitorTarget) getVariable [ARR_2(QQGVAR(Defibrillator_Charged),false)]) then {GVAR(AEDX_MonitorTarget) setVariable [ARR_3(QQGVAR(Defibrillator_Charged),false,true)]; GVAR(AEDX_MonitorCharged) = false; GVAR(AEDX_MonitorShockAdministered) = true}});
            tooltip = CSTRING(Defibrillator_Action_Shock);
        };
        class AnalyzeButton: ShockButton {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(913));
            y = QUOTE(KAT_pxToScreen_Y(1487));
            w = QUOTE(KAT_pxToScreen_W(122));
            h = QUOTE(KAT_pxToScreen_H(89));
            onButtonClick = QUOTE(if (!(GVAR(AEDX_MonitorTarget) isEqualTo objNull) && GVAR(AEDX_MonitorTarget) getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] && !(GVAR(AEDX_MonitorTarget) getVariable [ARR_2(QQGVAR(DefibrillatorInUse),false)])) then {[ARR_3(player,GVAR(AEDX_MonitorTarget),'AEDX')] call FUNC(AED_Analyze); [] call FUNC(AEDX_ViewMonitor_AnalyzeFeedback)});
            tooltip = CSTRING(AnalyzeRhythm);
        };
        class ChargeButton: AnalyzeButton {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(1316));
            onButtonClick = QUOTE(if (!(GVAR(AEDX_MonitorTarget) isEqualTo objNull) && GVAR(AEDX_MonitorTarget) getVariable [ARR_2(QQGVAR(DefibrillatorPads_Connected),false)] && !(GVAR(AEDX_MonitorTarget) getVariable [ARR_2(QQGVAR(DefibrillatorInUse),false)])) then {[ARR_2(player,GVAR(AEDX_MonitorTarget))] call FUNC(Defibrillator_ManualCharge); [true] call FUNC(AEDX_ViewMonitor_AnalyzeFeedback); [] call FUNC(AEDX_ViewMonitor_Charging)});
            tooltip = CSTRING(Defibrillator_Action_Charge);
        };
        class CancelChargeButton: ShockButton {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(1116));
            y = QUOTE(KAT_pxToScreen_Y(1453));
            w = QUOTE(KAT_pxToScreen_W(119));
            h = QUOTE(KAT_pxToScreen_H(169));
            onButtonClick = QUOTE(if (!(GVAR(AEDX_MonitorTarget) isEqualTo objNull) && (GVAR(AEDX_MonitorTarget) getVariable [ARR_2(QQGVAR(Defibrillator_Charged),false)])) then {GVAR(AEDX_MonitorTarget) setVariable [ARR_3(QQGVAR(DefibrillatorInUse),false,true)]; GVAR(AEDX_MonitorTarget) setVariable [ARR_3(QQGVAR(Defibrillator_Charged),false,true)]; GVAR(AEDX_MonitorCharged) = false; GVAR(AEDX_MonitorShockAdministered) = false});
            tooltip = CSTRING(Defibrillator_Action_CancelCharge);
        };
        class ToggleVolumeButton: ShockButton {
            idc = -1;
            x = QUOTE(KAT_pxToScreen_X(1678));
            y = QUOTE(KAT_pxToScreen_Y(802));
            w = QUOTE(KAT_pxToScreen_W(91));
            h = QUOTE(KAT_pxToScreen_H(73));
            onButtonClick = QUOTE(if (!(GVAR(AEDX_MonitorTarget) isEqualTo objNull)) then {if (GVAR(AEDX_MonitorTarget) getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_VolumePatient),false)]) then {GVAR(AEDX_MonitorTarget) setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_VolumePatient),false,true)]; [ARR_2((GVAR(AEDX_MonitorTarget) getVariable QQGVAR(Defibrillator_Provider)) select 0,false)] call FUNC(AEDXPlaced_VitalsMonitor_SetVolume)} else {GVAR(AEDX_MonitorTarget) setVariable [ARR_3(QQGVAR(AED_X_VitalsMonitor_VolumePatient),true,true)]; [ARR_2((GVAR(AEDX_MonitorTarget) getVariable QQGVAR(Defibrillator_Provider)) select 0,true)] call FUNC(AEDXPlaced_VitalsMonitor_SetVolume)}});
            tooltip = CSTRING(AEDX_Monitor_ToggleVolume);
        };
        class ManualBloodPressureMeasurement: ToggleVolumeButton {
            idc = -1;
            y = QUOTE(KAT_pxToScreen_Y(1251));
            onButtonClick = QUOTE(if (!(GVAR(AEDX_MonitorTarget) isEqualTo objNull) && (missionNamespace getVariable [ARR_2(QQGVAR(AED_X_VitalsMonitor_BloodPressureInterval),0)] > 0)) then {GVAR(AEDX_MonitorTarget) call FUNC(measureBloodPressure)});
            tooltip = CSTRING(AEDX_Monitor_MeasureBloodPressure);
        };
    };
};
