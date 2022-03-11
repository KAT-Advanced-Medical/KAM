class cfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
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
                    condition = QUOTE([_player] call FUNC(canRelpaceFilter));
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting"};
                    statement = QUOTE(_this call FUNC(changeGasMaskFilter));
                    showDisabled = 0;
                    icon = QPATHTOF(ui\gasmaskfilter_ca.paa);
                };
            }; 
        };
    };
 

    class Thing;
    class ACE_MedicalLitter_antidot: Thing {
        scope = 1;
        scopeCurator = 0;
        displayName = " ";
        destrType = "DestructNo";
        icon = QPATHTOF(data\littergeneric_antidote.p3d);
    };
    class ACE_MedicalLitter_PoisenBP: Thing {
        scope = 1;
        scopeCurator = 0;
        displayName = " ";
        destrType = "DestructNo";
        model = "";
    };

    class Item_Base_F;

    class kat_Antidot_Item: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(AntidotItem);
        author = "DiGii";
        vehicleClass = "Items";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        class TransportItems {
            class _xx_kat_Antidot {
                name = "kat_Antidot";
                count = 1;
            };
        };
    };

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
			class Edit;					// Default edit box (i.e., text input field)
			class Combo;				// Default combo box (i.e., drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
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
            class Raduis_MAX 
            {
                displayName = "Maximum Range: ";
                tooltip = CSTRING(GasModule_min_radius_dcs);
                typeName = "NUMBER";
                defaultValue = 20;
            };
            class Raduis_MIN
            {
                displayName = "Minimal Range: ";
                tooltip = CSTRING(GasModule_max_radius_dcs);
                typeName = "NUMBER";
                defaultValue = 10;
            };
            class GAS_Type
            {
                displayName = "Gas Type: ";
                typeName = "STRING";
                class values {
                    class toxicgas {
                        name = "Toxic gas (Level 1)";
                        value = "Toxic";
                        default = 1;
                    };
                   /* class csgas {
                        name = "CS-Gas (Level 2)";
                        value = "CS";
                    };*/
                };
            };
            class ISSealabe
            {
                displayName = "Is sealable?";
                toolTip = "ONLY WORKS IF LOGIC IS SYNCED WITH AN OBJECT!";
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
};