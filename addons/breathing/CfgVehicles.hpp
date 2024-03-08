class CfgVehicles {
    class Item_Base_F;

    class kat_PulseoximeterItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(Pulseoximeter_Desc_Short);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_Pulseoximeter,1);
        };
    };

    class kat_nasalItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(NasalCannula_Display);
        author = "apo_tle";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_nasal,1);
        };
    };

    class kat_chestSealItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName= CSTRING(chestseal_display);
        author = "Katalam";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(kat_chestSeal,1);
        };
    };

    class NATO_Box_Base;
    class ACE_medicalSupplyCrate: NATO_Box_Base {
        class TransportItems;
        class TransportMagazines;
    };
    class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
        class TransportItems: TransportItems {
            MACRO_ADDITEM(kat_Pulseoximeter,3);
            MACRO_ADDITEM(kat_chestSeal,25);
            MACRO_ADDITEM(kat_aatKit,10);
            MACRO_ADDITEM(kat_stethoscope,5);
            MACRO_ADDITEM(kat_BVM,5);
            MACRO_ADDITEM(kat_pocketBVM,5);
        };
        class TransportMagazines: TransportMagazines {
            MACRO_ADDMAGAZINE(kat_oxygenTank_150,2);
            MACRO_ADDMAGAZINE(kat_oxygenTank_300,2);
        };
    };
    class kat_basicSupplyCrate: ACE_medicalSupplyCrate {
        displayName = CSTRING(basicSupplyCrate_display);
        class TransportItems: TransportItems {
            MACRO_ADDITEM(Attachable_Helistretcher,5);
            MACRO_ADDITEM(kat_stretcherBag,5);
            MACRO_ADDITEM(kat_accuvac,2);
            MACRO_ADDITEM(kat_suction,15);
            MACRO_ADDITEM(kat_guedel,15);
            MACRO_ADDITEM(kat_larynx,15);
            MACRO_ADDITEM(kat_aatKit,15);
            MACRO_ADDITEM(kat_chestSeal,15);
            MACRO_ADDITEM(kat_Pulseoximeter,2);
            MACRO_ADDITEM(kat_stethoscope,2);
            MACRO_ADDITEM(kat_IO_FAST,15);
            MACRO_ADDITEM(kat_IV_16,15);
            MACRO_ADDITEM(kat_crosspanel,2);
            MACRO_ADDITEM(KAT_Empty_bloodIV_250,7);
            MACRO_ADDITEM(KAT_Empty_bloodIV_500,7);
            MACRO_ADDITEM(kat_AED,2);
            MACRO_ADDITEM(kat_X_AED,2);
            MACRO_ADDITEM(kat_BVM,5);
            MACRO_ADDITEM(kat_pocketBVM,5);
        };
        class TransportMagazines: TransportMagazines {
            MACRO_ADDMAGAZINE(kat_oxygenTank_150,2);
            MACRO_ADDMAGAZINE(kat_oxygenTank_300,2);
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class KAT_Equipment {
               class PulseOximeter_removeSound {
                    displayName = CSTRING(PulseOximeter_Action_removeSound);
                    condition = QUOTE('kat_Pulseoximeter' in (items _player) && (_player getVariable [ARR_2(QQGVAR(PulseOximeter_Volume),false])));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(PulseOximeter_Volume),false,true)]);
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting", "isNotSwimming", "isNotOnLadder"};
                    icon = "";
                };
                class PulseOximeter_addSound : PulseOximeter_removeSound {
                    displayName = CSTRING(PulseOximeter_Action_addSound);
                    condition = QUOTE('kat_Pulseoximeter' in (items _player) && !(_player getVariable [ARR_2(QQGVAR(PulseOximeter_Volume),false])));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(PulseOximeter_Volume),true,true)]);
                };
                class SetPreferred_OxygenTank_150 {
                    displayName = CSTRING(SetPreferredOxygenTank_150);
                    condition = QUOTE([ARR_2(_player,'kat_oxygenTank_150')] call ACEFUNC(common,hasMagazine));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(oxygenTankPreferred),'kat_oxygenTank_150',true)]);
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting", "isNotSwimming", "isNotOnLadder"};
                    icon = QPATHTOF(ui\oxygenTank_ui.paa);
                };
                class SetPreferred_OxygenTank_300: SetPreferred_OxygenTank_150 {
                    displayName = CSTRING(SetPreferredOxygenTank_300);
                    condition = QUOTE([ARR_2(_player,'kat_oxygenTank_300')] call ACEFUNC(common,hasMagazine));
                    statement = QUOTE(_player setVariable [ARR_3(QQGVAR(oxygenTankPreferred),'kat_oxygenTank_300',true)]);
                };
                class Refill_OxygenTank_150_Facility {
                    displayName = CSTRING(RefillPortableOxygenTank_150);
                    condition = QUOTE((GVAR(locationProvideOxygen) in [ARR_2(2,3)]) && 'kat_oxygenTank_150_Empty' in (items _player) && _player call ACEFUNC(medical_treatment,isInMedicalFacility));
                    statement = QUOTE([ARR_3(_player,'kat_oxygenTank_150',GVAR(PortableOxygenTank_RefillTime))] call FUNC(refillOxygenTank));
                    showDisabled = 0;
                    exceptions[] = {"isNotInside"};
                    icon = QPATHTOF(ui\oxygenTank_ui.paa);
                };
                class Refill_OxygenTank_300_Facility: Refill_OxygenTank_150_Facility {
                    displayName = CSTRING(RefillPortableOxygenTank_300);
                    condition = QUOTE((GVAR(locationProvideOxygen) in [ARR_2(2,3)]) && 'kat_oxygenTank_300_Empty' in (items _player) && _player call ACEFUNC(medical_treatment,isInMedicalFacility));
                    statement = QUOTE([ARR_3(_player,'kat_oxygenTank_300',GVAR(PortableOxygenTank_RefillTime)*2)] call FUNC(refillOxygenTank));
                };
            };
        };
    };

    class LandVehicle;
    class Car: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class RefillActionsVehicle {
                    displayName = CSTRING(RefillPortableOxygenTanks);
                    icon = QPATHTOF(ui\oxygenTank_ui.paa);
                    condition = QUOTE(GVAR(locationProvideOxygen) in [ARR_2(1,3)]);
                    class Refill_OxygenTank_150_Vehicle {
                        displayName = CSTRING(RefillPortableOxygenTank_150);
                        condition = QUOTE('kat_oxygenTank_150_Empty' in (items _player) && _target call ACEFUNC(medical_treatment,isMedicalVehicle));
                        statement = QUOTE([ARR_3(_player,'kat_oxygenTank_150',GVAR(PortableOxygenTank_RefillTime))] call FUNC(refillOxygenTank));
                    };
                    class Refill_OxygenTank_300_Vehicle: Refill_OxygenTank_150_Vehicle {
                        displayName = CSTRING(RefillPortableOxygenTank_300);
                        condition = QUOTE('kat_oxygenTank_300_Empty' in (items _player) && _target call ACEFUNC(medical_treatment,isMedicalVehicle));
                        statement = QUOTE([ARR_3(_player,'kat_oxygenTank_300',GVAR(PortableOxygenTank_RefillTime)*2)] call FUNC(refillOxygenTank));
                    };
                };
            };
        };
    };
};
