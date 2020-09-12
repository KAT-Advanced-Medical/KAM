#include "script_component.hpp"
class CfgPatches
{
    class ADDON
    {
        name = COMPONENT_NAME;
        units[] = {
			ACE_SterileGauze
		};
        weapons[] = {
			ACE_SterileGauze
		};
        requiredVersion = 1.80;
        requiredAddons[] = {
			"ace_medical",
			"ace_medical_damage",
			"ace_medical_treatment",
			"ace_medical_gui",
            "cba_settings"
		};
		author = "$STR_kat_burning_Author";
		authors[] = {"Church", "Rapp", "Revu", "Tomcat"};
		url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;
	
	 class ACE_SterileGauze: ACE_ItemCore {
		scope = 2;
		author = "$STR_kat_burning_Author";
		model = "\z\ace\addons\medical_treatment\data\QuikClot.p3d";
		picture = "\burning\ui\sterile_gauze.paa";
        displayName = "$STR_kat_burning_DisplayName";
        descriptionShort = "$STR_kat_burning_DescShort";
        descriptionUse = "$STR_kat_burning_DescUse";
		class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
	};
};

class cfgVehicles {
	class Item_Base_F;
    class ACE_SterileGauzeItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_kat_burning_DisplayName";
        author = "$STR_kat_burning_Author";
        vehicleClass = "Items";
        class TransportItems {
            class _xx_ACE_SterileGauze
			{
				name = "ACE_SterileGauze";
				count = 1;
			};
		};
	};
	
	class NATO_Box_Base;
	class ACE_MedicalSupplyCrate: NATO_Box_Base {
		class transportItems;
	};
	
	class ACE_medicalSupplyCrate_Advanced: ACE_MedicalSupplyCrate {
		class transportItems: transportItems {
			class _xx_ACE_SterileGauze {
				name = "ACE_SterileGauze";
				count = 25;
			};
		};
	};
};

class ACE_Medical_Injuries {
	class wounds {
		class Burn {
			causes[] = {"grenade", "explosive", "shell", "backblast", "ropeburn", "burn"};
            bleeding = 0.05;
            pain = 0.65;
            minDamage = 0.15;
        };
	};
	class damageTypes {
		class burn {
			thresholds[] = {{0.2, 3}};
            selectionSpecific = 1;
		};
	};
};

class ACE_Medical_Treatment {
	class Bandaging {
		//Vanilla ACE Treatments
		class FieldDressing {
			class Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMinor: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMedium: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnLarge: Burn { effectiveness = 0; reopeningChance = .75; };
		};
		class PackingBandage {
			class Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMinor: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMedium: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnLarge: Burn { effectiveness = 0; reopeningChance = .75; };
		};
		class ElasticBandage {
			class Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMinor: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMedium: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnLarge: Burn { effectiveness = 0; reopeningChance = .75; };
		};
		class QuikClot {
			class Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMinor: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnMedium: Burn { effectiveness = 0; reopeningChance = .75; };
			class BurnLarge: Burn { effectiveness = 0; reopeningChance = .75; };
		};
		// Sterile Gauze
		class SterileGauze: QuikClot {
			effectiveness = 0;
            reopeningChance = .25;
            reopeningMinDelay = 300;
            reopeningMaxDelay = 600;
			class Burn {
				effectiveness = 1;
			};
			class BurnMinor: Burn {
				effectiveness = 1;
			};
			class BurnMedium: Burn {
				effectiveness = .75;
			};
			class BurnLarge: Burn {
				effectiveness = .5;
			};
		};
	};
};

class ACE_Medical_Treatment_Actions {
	class FieldDressing;
	class SterileGauze: FieldDressing {
		displayName = "$STR_kat_burning";
		displayNameProgress = "$STR_ace_medical_treatment_Bandaging";
		
		consumeItem = 1;
		items[] = {"ACE_SterileGauze"};
		
		medicRequired = 0;
		allowSelfTreatment = 1;
		allowedSelections[] = {"All"};
		condition = "ace_medical_treatment_fnc_canBandage";
		treatmentLocations = 0;
		treatmentTime = 10;
		treatmentTimeSelfCoef = 1;
		
		callbackStart = "";
		callbackProgress = "";
		callbackSuccess = "ace_medical_treatment_fnc_bandage";
		callbackFailure = "";
		
		animationMedic = "AinvPknlMstpSlayW[wpn]Dnon_medicOther";
		animationMedicProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
		animationMedicSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
		animationMedicSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
		
		litter[] = {{},{"ACE_MedicalLitter_clean"},{{"ACE_MedicalLitter_bandage2","ACE_MedicalLitter_bandage3"}}};
	};
};