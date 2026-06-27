class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class KAT_Equipment {
                class KAT_CheckGasMaskDur {
                    displayName = CSTRING(CheckGasMaskDurability);
                    condition = QUOTE([_player] call FUNC(hasGasMaskOn));
                    exceptions[] = {"isNotSwimming"};
                    statement = QUOTE(_this call FUNC(checkGasMaskDur));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\Gasmask_icon.paa);
                };
                class KAT_ChangeGasMaskFilter {
                    displayName = CSTRING(ChangeGasMaskFilter);
                    condition = QUOTE([_player] call FUNC(canReplaceFilter));
                    exceptions[] = {"isNotSwimming"};
                    statement = QUOTE(_this call FUNC(changeGasMaskFilter));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\gasmaskfilter_ca.paa);
                };
                class KAT_PutOnGasMask {
                    displayName = CSTRING(PutOnGasMask);
                    condition = QUOTE([_player] call FUNC(canPutOnGasMask));
                    exceptions[] = {"isNotSwimming"};
                    statement = QUOTE([_player] call FUNC(putOnGasMask));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\Gasmask_icon.paa);
                };
                class KAT_TakeOffGasMask {
                    displayName = CSTRING(TakeOffGasMask);
                    condition = QUOTE([_player] call FUNC(canTakeOffGasMask));
                    exceptions[] = {"isNotSwimming"};
                    statement = QUOTE([_player] call FUNC(takeOffGasMask));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\Gasmask_icon.paa);
                };

                class KAT_UseM8Paper {
                    displayName = CSTRING(UseM8Paper);
                    condition = QUOTE('kat_m8paper' in (items _player));
                    exceptions[] = {"isNotSwimming", "isNotInside"};
                    statement = QUOTE([_player] call FUNC(useM8Paper));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_m8paper.paa);
                };

                class KAT_UseDecon {
                    displayName = CSTRING(UseDecon);
                    condition = QUOTE('kat_decon_kit' in (items _player) && {((_player getVariable [ARR_2(QQGVAR(chemicalContamination),'')]) != '') || {(_player getVariable [ARR_2(QQGVAR(radExternalContam),0)]) > 0}});
                    exceptions[] = {"isNotSwimming", "isNotInside"};
                    statement = QUOTE([ARR_2(_player,_player)] call FUNC(decontaminate));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_deconkit.paa);
                };

                class KAT_DropRadSource {
                    displayName = CSTRING(DropRadSource);
                    condition = QUOTE(!isNull (_player getVariable [ARR_2(QQGVAR(carriedRadSource),objNull)]));
                    exceptions[] = {"isNotSwimming"};
                    statement = QUOTE([_player] call FUNC(dropRadSource));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\icon_deconkit.paa);
                };

                class KAT_ChemicalDetector {
                    displayName = CSTRING(ChemicalDetector_Menu);
                    icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    exceptions[] = {"isNotSwimming"};

                    class KAT_ChemicalDetector_Enable {
                        displayName = CSTRING(EnableDetector);
                        condition = QUOTE(([_player] call FUNC(hasDetector)) && !(_player getVariable [ARR_2(QQGVAR(detectorEnabled),false)]));
                        exceptions[] = {"isNotSwimming"};
                        statement = QUOTE([_player] call FUNC(enableChemDetector));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    };
                    class KAT_ChemicalDetector_SoundOn {
                        displayName = CSTRING(EnableDetectorSound);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(detectorSound),false)]) && ([_player] call FUNC(hasDetector)));
                        exceptions[] = {"isNotSwimming"};
                        statement = QUOTE(_player setVariable [ARR_3(QQGVAR(detectorSound),true,true)]);
                        showDisabled = 0;
                        icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    };
                    class KAT_ChemicalDetector_SoundOff {
                        displayName = CSTRING(DisableDetectorSound);
                        condition = QUOTE((_player getVariable [ARR_2(QQGVAR(detectorSound),false)]) && ([_player] call FUNC(hasDetector)));
                        exceptions[] = {"isNotSwimming"};
                        statement = QUOTE(_player setVariable [ARR_3(QQGVAR(detectorSound),false,true)]);
                        showDisabled = 0;
                        icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    };
                };

                class KAT_Dosimeter {
                    displayName = CSTRING(Dosimeter_Menu);
                    icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    exceptions[] = {"isNotSwimming"};

                    class KAT_Dosimeter_Enable {
                        displayName = CSTRING(EnableDosimeter);
                        condition = QUOTE(([_player] call FUNC(hasDosimeter)) && !(_player getVariable [ARR_2(QQGVAR(dosimeterEnabled),false)]));
                        exceptions[] = {"isNotSwimming"};
                        statement = QUOTE([_player] call FUNC(enableDosimeter));
                        showDisabled = 0;
                        icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    };
                    class KAT_Dosimeter_Disable {
                        displayName = CSTRING(DisableDosimeter);
                        condition = QUOTE(([_player] call FUNC(hasDosimeter)) && (_player getVariable [ARR_2(QQGVAR(dosimeterEnabled),false)]));
                        exceptions[] = {"isNotSwimming"};
                        statement = QUOTE(_player setVariable [ARR_3(QQGVAR(dosimeterEnabled),false,true)]);
                        showDisabled = 0;
                        icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    };
                    class KAT_Dosimeter_SoundOn {
                        displayName = CSTRING(EnableDosimeterSound);
                        condition = QUOTE(!(_player getVariable [ARR_2(QQGVAR(dosimeterSound),false)]) && ([_player] call FUNC(hasDosimeter)));
                        exceptions[] = {"isNotSwimming"};
                        statement = QUOTE(_player setVariable [ARR_3(QQGVAR(dosimeterSound),true,true)]);
                        showDisabled = 0;
                        icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    };
                    class KAT_Dosimeter_SoundOff {
                        displayName = CSTRING(DisableDosimeterSound);
                        condition = QUOTE((_player getVariable [ARR_2(QQGVAR(dosimeterSound),false)]) && ([_player] call FUNC(hasDosimeter)));
                        exceptions[] = {"isNotSwimming"};
                        statement = QUOTE(_player setVariable [ARR_3(QQGVAR(dosimeterSound),false,true)]);
                        showDisabled = 0;
                        icon = QPATHTOF(ui\kat_chemicalDet_icon.paa);
                    };
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

    class kat_m8paper_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(m8paperItem);
        author = "AtrixZockt";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_m8paper {
                name = "kat_m8paper";
                count = 1;
            };
        };
    };

    class kat_decon_kit_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(deconKitItem);
        author = "AtrixZockt";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_decon_kit {
                name = "kat_decon_kit";
                count = 1;
            };
        };
    };

    class kat_potassiumIodide_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(potassiumIodideItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_potassiumIodide {
                name = "kat_potassiumIodide";
                count = 1;
            };
        };
    };

    class kat_prussianBlue_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(prussianBlueItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_prussianBlue {
                name = "kat_prussianBlue";
                count = 1;
            };
        };
    };

    class kat_antibiotics_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(antibioticsItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_antibiotics {
                name = "kat_antibiotics";
                count = 1;
            };
        };
    };

    class kat_filgrastim_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(filgrastimItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_filgrastim {
                name = "kat_filgrastim";
                count = 1;
            };
        };
    };

    class kat_antiemetic_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(antiemeticItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_antiemetic {
                name = "kat_antiemetic";
                count = 1;
            };
        };
    };

    class kat_stemCells_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(stemCellsItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_stemCells {
                name = "kat_stemCells";
                count = 1;
            };
        };
    };

    class Land_CanisterFuel_F;
    class kat_radSource: Land_CanisterFuel_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(radSourceObject);
        author = "DiGii";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class ACE_Actions {
            class ACE_MainActions {
                displayName = CSTRING(radSourceObject);
                selection = "";
                distance = 4;
                condition = "true";
                class KAT_PickupRadSource {
                    displayName = CSTRING(PickupRadSource);
                    distance = 4;
                    condition = QUOTE(isNull (_player getVariable [ARR_2(QQGVAR(carriedRadSource),objNull)]));
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(pickupRadSource));
                    icon = QPATHTOF(ui\icon_deconkit.paa);
                };
            };
        };
    };

    class Logic;
    class Module_F: Logic
    {
        class AttributesBase {};
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
        isGlobal = 0;

        class Arguments: AttributesBase
        {
            class Radius
            {
                displayName = CSTRING(UI_max_range);
                tooltip = CSTRING(GasModule_max_radius_dcs);
                typeName = "NUMBER";
                defaultValue = 20;
            };
            class GAS_Type
            {
                displayName = CSTRING(UI_gasType);
                typeName = "NUMBER";
                class values {
                    class TearGas {
                        name = CSTRING(Lvl0_Gas);
                        value = 0;
                    };
                    class ToxicGas {
                        name = CSTRING(Lvl1_Gas);
                        value = 1;
                        default = 1;
                    };
                    class Phosgene {
                        name = CSTRING(Lvl2_Gas);
                        value = 2;
                    };
                    class Mustard {
                        name = CSTRING(Lvl3_Gas);
                        value = 3;
                    };
                    class Sarin {
                        name = CSTRING(Lvl4_Gas);
                        value = 4;
                    };
                    class VX {
                        name = CSTRING(Lvl5_Gas);
                        value = 5;
                    };
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
        function = QACEFUNC(common,dummy);
        curatorInfoType = QGVAR(kat_RscGasModul);
        isTriggerActivated = 0;
        functionPriority = 1;
        isGlobal = 0;
    };

    class kat_module_radiation: Module_F
    {
        scope = 2;
        side = 7;
        displayName = CSTRING(RadModule_Displayname);
        category = QEGVAR(zeus,KAM);
        function = QFUNC(radmodule);
        isTriggerActivated = 0;
        functionPriority = 1;
        isGlobal = 0;

        class Arguments: AttributesBase
        {
            class Radius
            {
                displayName = CSTRING(UI_max_range);
                tooltip = CSTRING(RadModule_max_radius_dcs);
                typeName = "NUMBER";
                defaultValue = 20;
            };
            class Preset
            {
                displayName = CSTRING(RadModule_preset);
                tooltip = CSTRING(RadModule_preset_dcs);
                typeName = "NUMBER";
                class values
                {
                    class custom { name = CSTRING(RadPreset_custom); value = 0; default = 1; };
                    class cobalt { name = CSTRING(RadPreset_Cobalt60); value = 1; };
                    class reactor { name = CSTRING(RadPreset_Reactor); value = 2; };
                    class fallout { name = CSTRING(RadPreset_Fallout); value = 3; };
                    class alpha { name = CSTRING(RadPreset_AlphaEmitter); value = 4; };
                    class dirty { name = CSTRING(RadPreset_DirtyBomb); value = 5; };
                };
            };
            class Alpha
            {
                displayName = CSTRING(RadModule_alpha);
                tooltip = CSTRING(RadModule_strength_dcs);
                typeName = "NUMBER";
                defaultValue = 0;
            };
            class Beta
            {
                displayName = CSTRING(RadModule_beta);
                tooltip = CSTRING(RadModule_strength_dcs);
                typeName = "NUMBER";
                defaultValue = 0;
            };
            class Gamma
            {
                displayName = CSTRING(RadModule_gamma);
                tooltip = CSTRING(RadModule_strength_dcs);
                typeName = "NUMBER";
                defaultValue = 50;
            };
            class Neutron
            {
                displayName = CSTRING(RadModule_neutron);
                tooltip = CSTRING(RadModule_strength_dcs);
                typeName = "NUMBER";
                defaultValue = 0;
            };
            class PointSource
            {
                displayName = CSTRING(RadModule_pointSource);
                tooltip = CSTRING(RadModule_pointSource_dcs);
                typeName = "BOOL";
                defaultValue = 0;
            };
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(RadModule_description);
            sync[] = {"LocationArea_F"};

            class LocationArea_F {
                position = 0;
                optional = 1;
                duplicate = 1;
                synced[] = {"Anything"};
            };
        };
    };

    class kat_module_zeus_radiation: Module_F
    {
        scope = 1;
        scopeCurator = 2;
        side = 7;
        curatorCanAttach = 1;
        displayName = CSTRING(RadModule_Displayname);
        category = QEGVAR(zeus,KAM);
        function = QACEFUNC(common,dummy);
        curatorInfoType = QGVAR(kat_RscRadModul);
        isTriggerActivated = 0;
        functionPriority = 1;
        isGlobal = 0;
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
        class ace_csw {
            proxyWeapon = "ace_mortar_82mm";
        };

        class Turrets: Turrets {
            class MainTurret: MainTurret {
                magazines[] += {"KAT_5Rnd_82mm_Mo_Type0_AI","KAT_5Rnd_82mm_Mo_Type0_AI","KAT_5Rnd_82mm_Mo_Type0_AI","KAT_5Rnd_82mm_Mo_Type0_AI","KAT_3Rnd_82mm_Mo_TypeCS_AI","KAT_3Rnd_82mm_Mo_TypeCS_AI","KAT_3Rnd_82mm_Mo_TypeCS_AI"};
            };
        };
    };

    class Box_NATO_AmmoOrd_F;
    class ACE_Box_82mm_Mo_HE: Box_NATO_AmmoOrd_F {};
    class ACE_Box_82mm_Mo_Combo: ACE_Box_82mm_Mo_HE {
        class TransportMagazines {
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type0,8);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_TypeCS,8);
        };
    };
    class ACE_Box_82mm_Mo_Gas: ACE_Box_82mm_Mo_HE {
        displayName = CSTRING(GasBox_Displayname);
        class TransportMagazines {
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type0,8);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type0_Cluser,8);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_TypeCS,8);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type2,4);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type3,4);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type4,4);
            MACRO_ADDMAGAZINE(KAT_1Rnd_82mm_Mo_Type5,4);
        };
    };

    class APERSTripMine;
    class KAT_Gas_TripWireMine: APERSTripMine {
        author = "DiGii";
        ammo = "KAT_Gas_TripWireMine_Ammo";
        displayName = CSTRING(TriWire_Gas_Name);
    };


    class Static;
    class GVAR(logic): Static {
        scope = 1;
        displayName = "";
    };
};
