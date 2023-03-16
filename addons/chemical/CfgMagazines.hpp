class cfgMagazines
{
    class ACE_1Rnd_82mm_Mo_HE;
    class KAT_1Rnd_82mm_Mo_Type0: ACE_1Rnd_82mm_Mo_HE
    {
        author="DiGii";
        ammo="Sh_82mm_AMOS_Type0";
        displayNameMFDFormat= CSTRING(ToxicGas_MFDNAME);
        displayNameShort= CSTRING(ToxicGas_MFDNAME);
        displayName= CSTRING(ToxicGas_DisplayName);
    };
    class KAT_5Rnd_82mm_Mo_Type0_AI: KAT_1Rnd_82mm_Mo_Type0
    {
        scope = 1;
        count = 5;
    };
    class KAT_1Rnd_82mm_Mo_TypeCS: ACE_1Rnd_82mm_Mo_HE 
    {
        author="DiGii";
        ammo="Sh_82mm_AMOS_TypeCS";
        displayNameMFDFormat= CSTRING(CSGas_MFDNAME);
        displayNameShort= CSTRING(CSGas_MFDNAME);
        displayName= CSTRING(CSGas_DisplayName);
    };
    class KAT_3Rnd_82mm_Mo_TypeCS_AI: KAT_1Rnd_82mm_Mo_TypeCS 
    {
        scope = 1;
        count = 3;
    };

    class HandGrenade;
    class KAT_M7A3: HandGrenade
    {
        author = "DiGi";
        displayname = CSTRING(M7A3_CSGrenade_DisplayName);
        descriptionShort = CSTRING(M7A3_DcsShort);
        displayNameShort = CSTRING(M7A3_CSGrenade_ShortName);
        model = QPATHTOF(ui\m7a3.p3d);
        picture = QPATHTOF(ui\KAT_m7a3_ca.paa);        
        ammo = "KAT_G_M7A3";
        mass = 4;
    };

    class APERSTripMine_Wire_Mag;
    class KAT_Gas_TripWireMine_Mag: APERSTripMine_Wire_Mag {
        author = "DiGii";
        ammo = "KAT_Gas_TripWireMine_Ammo";
        ace_explosives_SetupObject = "ACE_Explosives_Place_APERSTripwireMine";
        displayName = CSTRING(TriWire_Gas_Name);
        descriptionShort = CSTRING(TriWire_Gas_Desc);
        class Library {libTextDesc = CSTRING(TriWire_Gas_Desc);};
    };

    class Default;    // External class reference
    class VehicleMagazine;
    class PylonMissile_Bomb_GBU12_x1;
    class PylonRack_Bomb_GBU12_x2;
    class KAT_CAS_M43_Mag: PylonMissile_Bomb_GBU12_x1 {

        ammo = "KAT_CAS_M43_Ammo";
        author = "DiGii";
        count = 1;
        initSpeed = 0;
        displayName = CSTRING(M43_DisplayName_1x);
        displayNameShort = CSTRING(M43_ShortName_1x);
        descriptionShort = CSTRING(M43_desc);
        hardpoints[] = {"RHS_HP_KMGU2","RHS_HP_PTB1150","RHS_HP_JDAM_1000","RHS_HP_HELLFIRE_RACK","RHS_HP_BOMB_500","RHS_HP_LGB_500","I_GBU12","B_GBU12","B_BOMB_PYLON", "B_ASRAAM", "CUP_PylonPod_19Rnd_Rocket_FFAR_plane_M", "DAR","CUP_NATO_HELO_SMALL","CUP_NATO_HELO_LARGE","CUP_NATO_HELO_ROCKETS","CUP_19Rnd_FFAR", "RHS_HP_LONGBOW_RACK", "B_BOMB_FFAR21", "B_BOMB_FFAR7", "FIR_F16_Combined_HP","FIR_F16_AG_HP","FIR_FA18EF_Combined_HP","FIR_A10_BOMB_HP","FIR_AV8B_AG_HP","FIR_SH_AG_HP","FIR_BLUFOR_AG_HP","FIR_BLUFOR_Combined_HP","FIR_FA181E_AG_HP","FIR_F35B_Combined_HP","FIR_FA18_Combined_HP","RHS_HP_FFAR_ARMY","RHS_HP_FFAR_USMC","B_MISSILE_PYLON","B_AGM65_RAIL","I_AGM65_RAIL", "FIR_FA18_Wingtip_HP","FIR_F15E_AA_HP","FIR_F15C_AA_HP","FIR_F15A_AA_HP","FIR_F16_AA_HP","FIR_F16_Combined_HP","FIR_F2A_AA_HP","FIR_F2A_Combined_HP","FIR_BLUFOR_AA_HP","FIR_BLUFOR_Combined_HP", "FIR_F14_SW_LAU138_HP", "FIR_F14_AA_HP", "RHS_HP_INGWE", "RHS_HP_MELB_R", "RHS_HP_MELB","B_AH_99_PYLON","I_BOMB_PYLON","I_MISSILE_PYLON","RHS_HP_B8V20", "pook_SOV_AS18", "POOK_MIG25_CENTERLINE", "CUP_SUPER_PYLON","CUP_EAST_HELO_SMALL","CUP_EAST_HELO_LARGE","CUP_32Rnd_S5", "RHS_HP_INGWE", "RHS_HP_UB32","CUP_O_AA_MISSILE_PYLON","CUP_PylonPod_1Rnd_R73_Vympel", "FIR_OPFOR_Combined_HP","FIR_OPFOR_AG_HP","FIR_Su25_AG_HP","O_BOMB_PYLON","O_MISSILE_PYLON","O_KH25", "RHS_HP_9m120_Mi28", "pook_RPOD", "pook_BMB","pook_HELI_BMB", "pook_HELI_MISSILERACK", "POOK_GUNPOD","CUP_GSh23"};
        mass = 100;
        pylonWeapon = "KAT_CAS_M43_Bomb";
    };

    class KAT_CAS_M43_Mag_x2 : PylonRack_Bomb_GBU12_x2 
    {
        ammo = "KAT_CAS_M43_Ammo";
        author = "DiGii";
        count = 2;
        initSpeed = 0;
        displayName = CSTRING(M43_DisplayName_2x);
        displayNameShort = CSTRING(M43_ShortName_2x);
        descriptionShort = CSTRING(M43_desc);
        hardpoints[] = {"RHS_HP_KMGU2","RHS_HP_PTB1150","RHS_HP_JDAM_1000","RHS_HP_HELLFIRE_RACK","RHS_HP_BOMB_500","RHS_HP_LGB_500","I_GBU12","B_GBU12","B_BOMB_PYLON", "B_ASRAAM", "CUP_PylonPod_19Rnd_Rocket_FFAR_plane_M", "DAR","CUP_NATO_HELO_SMALL","CUP_NATO_HELO_LARGE","CUP_NATO_HELO_ROCKETS","CUP_19Rnd_FFAR", "RHS_HP_LONGBOW_RACK", "B_BOMB_FFAR21", "B_BOMB_FFAR7", "FIR_F16_Combined_HP","FIR_F16_AG_HP","FIR_FA18EF_Combined_HP","FIR_A10_BOMB_HP","FIR_AV8B_AG_HP","FIR_SH_AG_HP","FIR_BLUFOR_AG_HP","FIR_BLUFOR_Combined_HP","FIR_FA181E_AG_HP","FIR_F35B_Combined_HP","FIR_FA18_Combined_HP","RHS_HP_FFAR_ARMY","RHS_HP_FFAR_USMC","B_MISSILE_PYLON","B_AGM65_RAIL","I_AGM65_RAIL", "FIR_FA18_Wingtip_HP","FIR_F15E_AA_HP","FIR_F15C_AA_HP","FIR_F15A_AA_HP","FIR_F16_AA_HP","FIR_F16_Combined_HP","FIR_F2A_AA_HP","FIR_F2A_Combined_HP","FIR_BLUFOR_AA_HP","FIR_BLUFOR_Combined_HP", "FIR_F14_SW_LAU138_HP", "FIR_F14_AA_HP", "RHS_HP_INGWE", "RHS_HP_MELB_R", "RHS_HP_MELB","B_AH_99_PYLON","I_BOMB_PYLON","I_MISSILE_PYLON","RHS_HP_B8V20", "pook_SOV_AS18", "POOK_MIG25_CENTERLINE", "CUP_SUPER_PYLON","CUP_EAST_HELO_SMALL","CUP_EAST_HELO_LARGE","CUP_32Rnd_S5", "RHS_HP_INGWE", "RHS_HP_UB32","CUP_O_AA_MISSILE_PYLON","CUP_PylonPod_1Rnd_R73_Vympel", "FIR_OPFOR_Combined_HP","FIR_OPFOR_AG_HP","FIR_Su25_AG_HP","O_BOMB_PYLON","O_MISSILE_PYLON","O_KH25", "RHS_HP_9m120_Mi28", "pook_RPOD", "pook_BMB","pook_HELI_BMB", "pook_HELI_MISSILERACK", "POOK_GUNPOD","CUP_GSh23"};
        mass = 200;
        pylonWeapon = "KAT_CAS_M43_Bomb";
    };
    
    class PylonRack_19Rnd_Rocket_Skyfire;
    class KAT_CAS_R_80mm_GAS_MAG: PylonRack_19Rnd_Rocket_Skyfire {
        ammo = "KAT_CAS_R_80mm_GAS_AMMO";
        author = "DiGii";
        descriptionShort = CSTRING(HydraGas_desc);
        displayName = CSTRING(HydraGas_DisplayName);
        displayNameShort =  CSTRING(HydraGas_ShortName);
        pylonWeapon = "KAT_CAS_R_80mm_GAS_POD";
        hardpoints[] = {"RHS_HP_UPK23_KA52","RHS_HP_9m120_Mi28","RHS_HP_KH55SM_INT","RHS_HP_TU95MS6_INT","RHS_HP_FFAR_ARMY","RHS_HP_MELB","O_MISSILE_PYLON","O_SKYFIRE","B_MISSILE_PYLON","DAGR","DAR","B_SHIEKER","CUP_PylonPod_19Rnd_Rocket_FFAR_plane_M","CUP_NATO_HELO_ROCKETS","CUP_19Rnd_FFAR","B_AH_99_PYLON","CUP_SUPER_PYLON","CUP_32Rnd_S5","pook_RPOD","RHS_HP_FFAR_USMC", "RHS_HP_INGWE", "RHS_HP_MELB_R", "RHS_HP_MELB","RHS_HP_UB32","pook_HELI_BMB","pook_HELI_MISSILERACK"};
    };
};