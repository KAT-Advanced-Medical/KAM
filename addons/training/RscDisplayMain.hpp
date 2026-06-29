class RscStandardDisplay;
class RscControlsGroupNoScrollbars;
class RscDisplayMain: RscStandardDisplay {
    class controls {
        class GroupSingleplayer: RscControlsGroupNoScrollbars {
            class Controls;
        };
        class GroupTutorials: GroupSingleplayer {
            h = "(6 *   1.5) *  (pixelH * pixelGrid * 2)";

            class Controls: Controls {
                class Bootcamp;
                class Arsenal;
                class GVAR(mission): Arsenal {
                    idc = -1;
                    text = CSTRING(Mission);
                    tooltip = CSTRING(Mission_tooltip);
                    y = "(4 *   1.5) *  (pixelH * pixelGrid * 2) +  (pixelH)";
                    onbuttonclick = QUOTE(playMission [ARR_2('','PATHTOF(missions\MedicTraining.VR)')]);
                    
                    animTextureNormal = QPATHTOF(data\KamMissionLogo.paa);
                    animTextureDisabled = QPATHTOF(data\KamMissionLogo.paa);
                    animTextureOver = QPATHTOF(data\KamMissionLogoWhite.paa);
                    animTextureFocused = QPATHTOF(data\KamMissionLogoWhite.paa);
                    animTexturePressed = QPATHTOF(data\KamMissionLogo.paa);
                    animTextureDefault = QPATHTOF(data\KamMissionLogo.paa);
                    
                };
                class FieldManual: Bootcamp {
                    y = "(5 *   1.5) *  (pixelH * pixelGrid * 2) +  (pixelH)";
                };
                class CommunityGuides: Bootcamp {
                    y = "(6 *   1.5) *  (pixelH * pixelGrid * 2) +  (pixelH)";
                };
            };
        };
    };
};