class CfgVehicles {
    class Item_Base_F;

    class kat_larynxItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Larynx_Display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_larynx,1);
        };
    };
    class kat_guedelItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Guedel_Display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_guedel,1);
        };
    };
    class kat_accuvacItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= "Accuvac";
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_accuvac,1);
        };
    };
    class BloodSplatter_01_Small_Old_F;
    class kat_vomit: BloodSplatter_01_Small_Old_F {
        displayName = CSTRING(Vomit_Display);
        hiddenSelectionsTextures[] = {QPATHTOF(ui\vomit.paa)};
    };

    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
    };
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_larynx,15);
            MACRO_ADDITEM(kat_guedel,15);
            MACRO_ADDITEM(kat_accuvac,1);
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Head {
                class intubating {
                    displayName = CSTRING(intubating);
                    icon = "";
                    class Larynxtubus {
                        displayName = CSTRING(Larynx_Display);
                        distance = 2.0;
                        condition = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_treatment_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_treatment_fnc_treatment";
                        exceptions[] = {""};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\larynx.paa);
                    };
                    class Guedeltubus: Larynxtubus {
                        displayName = CSTRING(Guedel_Display);
                        condition = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_treatment_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_treatment_fnc_treatment";
                        exceptions[] = {""};
                        icon = QPATHTOF(ui\guedel.paa);
                    };
                    class Overstretch: Larynxtubus {
                        displayName = CSTRING(overstretch);
                        condition = "[_player, _target, 'head', 'Overstretch'] call ace_medical_treatment_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Overstretch'] call ace_medical_treatment_fnc_treatment";
                        exceptions[] = {""};
                        icon = "";
                    };
                };
                class vacuum {
                    displayName = CSTRING(vacuum);
                    icon = "";
                    class Accuvac {
                        displayName = "Accuvac";
                        distance = 2.0;
                        condition = "[_player, _target, 'head', 'Accuvac'] call ace_medical_treatment_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'Accuvac'] call ace_medical_treatment_fnc_treatment";
                        exceptions[] = {""};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\accuvac.paa);
                    };
                    class TurnAround: Accuvac {
                        displayName = CSTRING(turnaround);
                        condition = "[_player, _target, 'head', 'TurnAround'] call ace_medical_treatment_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'TurnAround'] call ace_medical_treatment_fnc_treatment";
                        exceptions[] = {""};
                        icon = "";
                    };
                };
                class CheckPulse;
                class CheckAirway: CheckPulse {
                    displayName = CSTRING(checkAirway);
                    condition = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_treatment_fnc_canTreatCached";
                    statement = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_treatment_fnc_treatment";
                    exceptions[] = {""};
                    icon = "";
                };
            };
            class ACE_MainActions {
                class Medical {
                    class ACE_Head {
                        class intubating {
                            displayName = CSTRING(intubating);
                            icon = "";
                            class Larynxtubus {
                                displayName = CSTRING(Larynx_Display);
                                distance = 2.0;
                                condition = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_treatment_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Larynxtubus'] call ace_medical_treatment_fnc_treatment";
                                exceptions[] = {""};
                                showDisabled = 0;
                                icon = QPATHTOF(ui\larynx.paa);
                            };
                            class Guedeltubus: Larynxtubus {
                                displayName = CSTRING(Guedel_Display);
                                condition = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_treatment_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Guedeltubus'] call ace_medical_treatment_fnc_treatment";
                                exceptions[] = {""};
                                icon = QPATHTOF(ui\guedel.paa);
                            };
                            class Overstretch: Larynxtubus {
                                displayName = CSTRING(overstretch);
                                condition = "[_player, _target, 'head', 'Overstretch'] call ace_medical_treatment_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Overstretch'] call ace_medical_treatment_fnc_treatment";
                                exceptions[] = {""};
                                icon = "";
                            };
                        };
                        class vacuum {
                            displayName = CSTRING(vacuum);
                            icon = "";
                            class Accuvac {
                                displayName = "Accuvac";
                                distance = 2.0;
                                condition = "[_player, _target, 'head', 'Accuvac'] call ace_medical_treatment_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'Accuvac'] call ace_medical_treatment_fnc_treatment";
                                exceptions[] = {""};
                                showDisabled = 0;
                                icon = QPATHTOF(ui\accuvac.paa);
                            };
                            class TurnAround: Accuvac {
                                displayName = CSTRING(turnaround);
                                condition = "[_player, _target, 'head', 'TurnAround'] call ace_medical_treatment_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'TurnAround'] call ace_medical_treatment_fnc_treatment";
                                exceptions[] = {""};
                                icon = "";
                            };
                        };
                        class CheckPulse;
                        class CheckAirway: CheckPulse {
                            displayName = CSTRING(checkAirway);
                            condition = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_treatment_fnc_canTreatCached";
                            statement = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_treatment_fnc_treatment";
                            exceptions[] = {""};
                            icon = "";
                        };
                    };
                };
            };
        };
    };
};
