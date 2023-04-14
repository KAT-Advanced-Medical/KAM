class CfgUIGrids {
    class IGUI {
        class Presets {
            class Arma3 {
                class Variables {
                    ace_medical_gui_patientInfo[] = {
                        {
                            "PATIENT_INFO_IGUI_BASE_X",
                            "PATIENT_INFO_IGUI_BASE_Y",
                            "POS_W(9)",
                            "POS_H(20)"
                        },
                        "GUI_GRID_W",
                        "GUI_GRID_H"
                    };
                };
            };
        };

        class Variables {
            class ace_medical_gui_patientInfo {
                displayName = ACECSTRING(medical,Category);
                description = ACECSTRING(medical_gui,IGUI_PatientInfo);
                preview = "\z\ace\addons\medical_gui\ui\patient_info_preview_ca";
                saveToProfile[] = {0, 1};
                canResize = 0;
            };
        };
    };
};
