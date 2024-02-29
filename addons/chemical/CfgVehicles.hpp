class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class KAT_Equipment {
                class KAT_CheckGasMaskDur {
                    displayName = CSTRING(CheckGasMaskDurability);
                    condition = QUOTE([_player] call FUNC(hasGasMaskOn));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    statement = QUOTE(_this call FUNC(checkGasMaskDur));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\Gasmask_icon.paa);
                };
                class KAT_ChangeGasMaskFilter {
                    displayName = CSTRING(ChangeGasMaskFilter);
                    condition = QUOTE([_player] call FUNC(canReplaceFilter));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    statement = QUOTE(_this call FUNC(changeGasMaskFilter));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\gasmaskfilter_ca.paa);
                };
                class KAT_MuteChemDetector {
                    displayName = CSTRING(ChemDetector_Mute);
                    condition = QUOTE([ARR_2(_player,true)] call FUNC(getChemDetectorState));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(chemDetectorState),false,true)]);
                    showDisabled = 0;
                    icon = QPATHTOF(ui\ChemDetectorIcon.paa);
                };
                class KAT_UnmuteChemDetector {
                    displayName = CSTRING(ChemDetector_Unmute);
                    condition = QUOTE([ARR_2(_player,false)] call FUNC(getChemDetectorState));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(chemDetectorState),true,true)]);
                    showDisabled = 0;
                    icon = QPATHTOF(ui\ChemDetectorIcon.paa);
                };
            };
        };
    };

    class Item_Base_F;

    class kat_sealant_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(sealantItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_sealant {
                name = "kat_sealant";
                count = 1;
            };
        };
    };

    class kat_gasmaskFilter_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(GasFilterItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_gasmaskFilter {
                name = "kat_gasmaskFilter";
                count = 1;
            };
        };
    };

    class Logic;
    class Module_F: Logic
    {
        class AttributesBase
        {
            class Default;
            class Edit;                    // Default edit box (i.e., text input field)
            class Combo;                // Default combo box (i.e., drop-down menu)
            class Checkbox;                // Default checkbox (returned value is Boolean)
            class CheckboxNumber;        // Default checkbox (returned value is Number)
            class ModuleDescription;    // Module description
            class Units;
        };
        class ModuleDescription;
    };

    class kat_module_gas: Module_F
    {
        scope = 2;
        side=7;
        displayName = CSTRING(GasModule_Displayname);
        category = QEGVAR(zeus,KAM);
        function = QFUNC(gasmodule);
        isTriggerActivated = 0;
        functionPriority = 1;
        isGlobal = 1;

        class Arguments: AttributesBase
        {
            class Radius_Max
            {
                displayName = CSTRING(UI_max_range);
                tooltip = CSTRING(GasModule_min_radius_dcs);
                typeName = "NUMBER";
                defaultValue = 20;
            };
            class Radius_Min
            {
                displayName = CSTRING(UI_min_range);
                tooltip = CSTRING(GasModule_max_radius_dcs);
                typeName = "NUMBER";
                defaultValue = 10;
            };
            class GAS_Type
            {
                displayName = CSTRING(UI_gasType);
                typeName = "STRING";
                class values {
                    class toxicgas {
                        name = CSTRING(LvL1_Gas);
                        value = "Toxic";
                        default = 1;
                    };
                   /* class csgas {
                        name = "CS-Gas (Level 2)";
                        value = "CS";
                    };*/
                };
            };
            class IsSealable
            {
                displayName = CSTRING(UI_sealable);
                toolTip = CSTRING(UI_sealable_tooltip);
                typeName = "BOOL";
                defaultValue = 0;
            };
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(GasModule_description);
            sync[] = {"LocationArea_F"};

            class LocationArea_F {
                position = 0;
                optional = 0;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };

    class kat_module_zeus_gas: Module_F
    {
        scope = 1;
        scopeCurator = 2;
        side=7;
        curatorCanAttach = 1;
        displayName = CSTRING(GasModule_Displayname);
        category = QEGVAR(zeus,KAM);
        curatorInfoType = QGVAR(kat_RscGasModul);
        isTriggerActivated = 0;
        functionPriority = 1;
        isGlobal = 1;
    };


    class LandVehicle;
    class StaticWeapon: LandVehicle {
        class Turrets {
            class MainTurret;
        };
    };
    class StaticMortar: StaticWeapon {
        class Turrets: Turrets {
            class MainTurret: MainTurret {};
        };
    };
    class Mortar_01_base_F: StaticMortar {
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                magazines[] += {"KAT_5Rnd_82mm_Mo_Type0_AI","KAT_5Rnd_82mm_Mo_Type0_AI","KAT_5Rnd_82mm_Mo_Type0_AI","KAT_5Rnd_82mm_Mo_Type0_AI","KAT_3Rnd_82mm_Mo_TypeCS_AI","KAT_3Rnd_82mm_Mo_TypeCS_AI","KAT_3Rnd_82mm_Mo_TypeCS_AI"};
            };
        };
    };


    class Box_NATO_AmmoOrd_F;
    class ACE_Box_82mm_Mo_HE: Box_NATO_AmmoOrd_F {
        class TransportMagazines;
    };
    class ACE_Box_82mm_Mo_Combo: ACE_Box_82mm_Mo_HE {
        class TransportMagazines: TransportMagazines {
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type0,8);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_TypeCS,8);
        };
    };
    class ACE_Box_82mm_Mo_Gas: ACE_Box_82mm_Mo_HE {
        displayName = CSTRING(GasBox_Displayname);
        class TransportMagazines {
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type0,8);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_TypeCS,8);
        };
    };

    class APERSTripMine;

    class KAT_Gas_TripWireMine: APERSTripMine {
        author = "DiGii";
        ammo = "KAT_Gas_TripWireMine_Ammo";
        displayName = CSTRING(TriWire_Gas_Name);
    };
};
