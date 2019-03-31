class CfgVehicles {
    class Item_Base_F;

    class kat_npaItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(npa_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_npa,1);
        };
    };
    class kat_opaItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(opa_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_opa,1);
        };
    };
    class kat_endItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(end_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_end,1);
        };
    };
    class kat_suctionItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(suction_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_suction,1);
        };
    };
    class kat_accuvacItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(accuvac_display);
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
            MACRO_ADDITEM(kat_npa,15);
            MACRO_ADDITEM(kat_opa,15);
            MACRO_ADDITEM(kat_end,15);
            MACRO_ADDITEM(kat_suction,5);
            MACRO_ADDITEM(kat_accuvac,1);
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Head {
                class airway {
                    displayName = CSTRING(airway);
                    icon = "";
                    class npa {
                        displayName = CSTRING(npa_display);
                        distance = 2.0;
                        condition = "[_player, _target, 'head', 'npa'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'npa'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\larynx.paa);
                    };
                    class opa: npa {
                        displayName = CSTRING(opa_display);
                        condition = "[_player, _target, 'head', 'opa'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'opa'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        icon = QPATHTOF(ui\guedel.paa);
                    };
                    class end: npa {
                        displayName = CSTRING(end_display);
                        condition = "[_player, _target, 'head', 'end'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'end'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        icon = QPATHTOF(ui\guedel.paa);
                    };
                    class headtilt: npa {
                        displayName = CSTRING(headtilt);
                        condition = "[_player, _target, 'head', 'headtilt'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'headtilt'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        icon = "";
                    };
                    class suction {
                        displayName = CSTRING(suction_display);
                        distance = 2.0;
                        condition = "[_player, _target, 'head', 'suction'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'suction'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        showDisabled = 0;
                        icon = "";
                    };
                    class accuvac {
                        displayName = CSTRING(accuvac_display);
                        distance = 2.0;
                        condition = "[_player, _target, 'head', 'accuvac'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'accuvac'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        showDisabled = 0;
                        icon = QPATHTOF(ui\accuvac.paa);
                    };
                    class TurnAround: accuvac {
                        displayName = CSTRING(turnaround);
                        condition = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_canTreatCached";
                        statement = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_treatment";
                        exceptions[] = {""};
                        icon = "";
                    };
                };
                class CheckPulse;
                class CheckAirway: CheckPulse {
                    displayName = CSTRING(assessairway);
                    condition = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_canTreatCached";
                    statement = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_treatment";
                    exceptions[] = {""};
                    icon = "";
                };
            };
            class ACE_MainActions {
                class Medical {
                    class ACE_Head {
                        class airway {
                            displayName = CSTRING(airway);
                            icon = "";
                            class npa {
                                displayName = CSTRING(npa_display);
                                distance = 2.0;
                                condition = "[_player, _target, 'head', 'npa'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'npa'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                showDisabled = 0;
                                icon = QPATHTOF(ui\larynx.paa);
                            };
                            class opa: npa {
                                displayName = CSTRING(opa_display);
                                condition = "[_player, _target, 'head', 'opa'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'opa'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                icon = QPATHTOF(ui\guedel.paa);
                            };
                            class end: npa {
                                displayName = CSTRING(end_display);
                                condition = "[_player, _target, 'head', 'end'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'end'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                icon = QPATHTOF(ui\guedel.paa);
                            };
                            class headtilt: npa {
                                displayName = CSTRING(headtilt);
                                condition = "[_player, _target, 'head', 'headtilt'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'headtilt'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                icon = "";
                            };
                            class suction {
                                displayName = CSTRING(suction_display);
                                distance = 2.0;
                                condition = "[_player, _target, 'head', 'suction'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'suction'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                showDisabled = 0;
                                icon = "";
                            };
                            class accuvac {
                                displayName = CSTRING(accuvac_display);
                                distance = 2.0;
                                condition = "[_player, _target, 'head', 'accuvac'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'accuvac'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                showDisabled = 0;
                                icon = QPATHTOF(ui\accuvac.paa);
                            };
                            class TurnAround: accuvac {
                                displayName = CSTRING(turnaround);
                                condition = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_canTreatCached";
                                statement = "[_player, _target, 'head', 'TurnAround'] call ace_medical_fnc_treatment";
                                exceptions[] = {""};
                                icon = "";
                            };
                        };
                        class CheckPulse;
                        class CheckAirway: CheckPulse {
                            displayName = CSTRING(assessairway);
                            condition = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_canTreatCached";
                            statement = "[_player, _target, 'head', 'CheckAirway'] call ace_medical_fnc_treatment";
                            exceptions[] = {""};
                            icon = "";
                        };
                    };
                };
            };
        };
    };
};
