#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            "kat_PainkillerItem",
            "kat_X_AEDItem"
        };
        weapons[] = {
            "kat_Painkiller",
            "kat_PainkillerItem",
            "kat_IV_16",
            "kat_IO_FAST",
            "kat_Carbonate",
            "kat_CarbonateItem",
            "kat_naloxone",
            "kat_EACA",
            "kat_TXA",
            "kat_X_AED",
            "kat_norepinephrine",
            "kat_phenylephrine",
            "kat_nitroglycerin",
            "kat_amiodarone",
            "kat_lidocane",
            "kat_atropine",
            "kat_ketamine",
            "kat_fentanyl",
            "kat_nalbuphine",
            "kat_flumazenil",
            "kat_lorazepam",
            "kat_etomidate"
        };
        magazines[] = { };
        requiredAddons[] = {
            "ace_medical",
            "ace_medical_ai",
            "ace_medical_blood",
            "ace_medical_damage",
            "ace_medical_engine",
            "ace_medical_feedback",
            "ace_medical_gui",
            "ace_medical_statemachine",
            "ace_medical_status",
            "ace_medical_treatment",
            "ace_medical_vitals",
            "ace_dogtags",
            "cba_settings"
        };
        author = "Katalam";
        authors[] = {"Katalam", "2LT.Mazinski", "MiszczuZPolski"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

class CfgWeapons
{
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;
	class kat_IV_16: ACE_ItemCore
	{
		scope=2;
		displayName="$STR_kat_pharma_IV_16_Display";
		picture="\x\kat\addons\pharma\ui\icon_IV_16.paa";
		model="\x\kat\addons\pharma\models\iv\kat_iv.p3d";
		descriptionShort="$STR_kat_pharma_IV_DescShort";
		hiddenSelections[]={"0"};
        hiddenSelectionsTextures[]=
        {
            "\x\kat\addons\pharma\models\iv\kat_iv.paa"
        };
		class ItemInfo: CBA_MiscItem_ItemInfo
		{
			mass=0.5;
		};
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"
#include "CfgWeapons.hpp"
#include "CfgMagazines.hpp"
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"