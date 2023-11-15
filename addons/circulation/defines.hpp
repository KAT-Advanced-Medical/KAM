// UI stuff
#define KAT_GUI_GRID_W (safezoneW * 0.55)
#define KAT_GUI_GRID_H (KAT_GUI_GRID_W * 4/3)
#define KAT_GUI_GRID_X (safezoneX + (safezoneW - KAT_GUI_GRID_W) / 2)
#define KAT_GUI_GRID_Y (safezoneY + (safezoneH - KAT_GUI_GRID_H) / 2)

#define KAT_pxToScreen_X(X) (X / 2048 * KAT_GUI_GRID_W + KAT_GUI_GRID_X)
#define KAT_pxToScreen_Y(X) (X / 2048 * KAT_GUI_GRID_H + KAT_GUI_GRID_Y)
#define KAT_pxToScreen_W(X) (X / 2048 * KAT_GUI_GRID_W)
#define KAT_pxToScreen_H(X) (X / 2048 * KAT_GUI_GRID_H)

#define KAT_GRID_H ((((safezoneW / safezoneH) min 1.2) / 1.2) / 22)

#define IDC_AEDX_MONITOR            70000
#define IDC_EKG_SLIDER              70010
#define IDC_DISPLAY_HEARTRATE       70011
#define IDC_DISPLAY_HEARTRATE_TEXT  70012
#define IDC_DISPLAY_BLOODPRESSURE_T 70013
#define IDC_DISPLAY_BLOODPRESSURE_B 70014
#define IDC_DISPLAY_BLOODPRESSURE_M 70015
#define IDC_DISPLAY_RESP            70016
#define IDC_DISPLAY_SPO2            70017
#define IDC_DISPLAY_PULSERATEBORDER 70018
#define IDC_DISPLAY_PULSERATEBG     70019
#define IDC_DISPLAY_PULSERATEDSPBAR 70020
#define IDC_DISPLAY_PULSERATEBAR    70021
#define IDC_DISPLAY_DATEANDTIME     70022
#define IDC_DISPLAY_ELAPSEDTIME     70023
#define IDC_EKG_DISPLAY             70024
#define IDC_EKG_DISPLAY_MIDTEXT     70025
#define IDC_SHOCKBUTTON             70026
#define IDC_AEDMODE_MSG_BG          70027
#define IDC_AEDMODE_MSG_TOP         70028
#define IDC_AEDMODE_MSG             70029
#define IDC_CHARGE_BBACKGROUND      70030
#define IDC_CHARGE_BBACKGROUND2     70031
#define IDC_CHARGE_STATUS_TITLE     70032
#define IDC_CHARGE_STATUS           70033
#define IDC_CHARGE_ENERGY_SELECT    70034
#define IDC_CHARGE_ENERGY_AMOUNT    70035
#define IDC_CHARGE_BAR_BACKGROUND   70036
#define IDC_CHARGE_SHOCKTOTAL       70037
#define IDC_CHARGE_BACKGROUND       70040
#define IDC_CHARGE_BAR_1            70041
#define IDC_CHARGE_BAR_2            70042
#define IDC_CHARGE_BAR_3            70043
#define IDC_CHARGE_BAR_4            70044
#define IDC_CHARGE_BAR_5            70045
#define IDC_CHARGE_BAR_6            70046
#define IDC_CHARGE_BAR_7            70047
#define IDC_CHARGE_BAR_8            70048
#define IDC_CHARGE_BAR_9            70049
#define IDC_CHARGE_BAR_10           70050
#define IDC_CHARGE_BAR_15           70051
#define IDC_CHARGE_BAR_20           70052
#define IDC_CHARGE_BAR_30           70053
#define IDC_CHARGE_BAR_50           70054
#define IDC_CHARGE_BAR_70           70055
#define IDC_CHARGE_BAR_85           70056
#define IDC_CHARGE_BAR_100          70057
#define IDC_CHARGE_BAR_120          70058
#define IDC_CHARGE_BAR_150          70059
#define IDC_CHARGE_BAR_200          70060