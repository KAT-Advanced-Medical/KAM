////////////////////////////////////////////////////////////////////////////
//////           This HPP was created by Shinji`s GUI tool            //////
////////////////////////////////////////////////////////////////////////////
class kat_aceBreathing_pulsoximeter_menu {
    idd = 1000;
    name = "kat_aceBreathing_pulsoximeter_menu";
    onLoad = "uiNamespace setVariable ['kat_aceBreathing_pulsoximeter_menu', _this select 0];";
    onUnLoad = "uiNamespace setVariable ['kat_aceBreathing_pulsoximeter_menu', nil];";
    movingEnable = false;
    enableSimulation = true;

    class controlsBackground {
        class RscText;
        class Background_1101: RscText
        {
            idc = 1101;
            text = "";
            x = 0.442569 * safezoneW + safezoneX;
            y = 0.47216 * safezoneH + safezoneY;
            w = 0.148437 * safezoneW;
            h = 0.130555 * safezoneH;
        };
    };
    class controls {
        class RscPicture;
        class Picturebox_1100 {
            idc = 1100;
            text = "images\gui_pulsoxi.png";
            x = 0.334756 * safezoneW + safezoneX;
            y = 0.369382 * safezoneH + safezoneY;
            w = 0.3625 * safezoneW;
            h = 0.333333 * safezoneH;
            ColorBackground[] = {1,1,1,0};
        };
        class RscText;
        class Small_1102  {
            idc = 1102;
            text = "Sp0₂";
            x = 0.445694 * safezoneW + safezoneX;
            y = 0.48003 * safezoneH + safezoneY;
            w = 0.043229 * safezoneW;
            h = 0.044907 * safezoneH;
            ColorBackground[] = {0,0,0,0};
            ColorText[] = {0,0,1,1};
            SizeEx = 0.3;
        };
        class RscStructuredText;
        class kat_oxygen_status {
            idc = 1103;
            text = "";
            x = 0.502985 * safezoneW + safezoneX;
            y = 0.530493 * safezoneH + safezoneY;
            w = 0.067708 * safezoneW;
            h = 0.055555 * safezoneH;
            ColorBackground[] = {1,1,1,0};
            ColorText[] = {0,0,1,1};
        };
    };
};
////////////////////////////////////////////////////////////////////////////
