class CfgVehicles {
    class Truck_01_base_F;
    class rhsusf_fmtv_base: Truck_01_base_F {};
    class rhsusf_M1078A1P2_fmtv_usarmy: rhsusf_fmtv_base {};
    class rhsusf_M1078A1P2_D_fmtv_usarmy: rhsusf_M1078A1P2_fmtv_usarmy {
        kat_stretcherPos[] = {0,-1,-0.4};
        kat_stretcherVector[] = {{0, 0, 0}, {0, 0, 0}};
    };
    class rhsusf_M1083A1P2_fmtv_usarmy: rhsusf_M1078A1P2_fmtv_usarmy {};
    class rhsusf_M1083A1P2_B_fmtv_usarmy: rhsusf_M1083A1P2_fmtv_usarmy {};
    class rhsusf_M1085A1P2_B_Medical_fmtv_usarmy: rhsusf_M1083A1P2_B_fmtv_usarmy {
        kat_stretcherPos[] = {-0.9,3,0.67};
        kat_stretcherVector[] = {{0,0,0},{0,0,0}};
    };

    class Heli_Transport_01_base_F;
    class RHS_UH60_Base: Heli_Transport_01_base_F {
        kat_stretcherPos[] = {0,1.25,-1.86};
        kat_stretcherVector[] = {{1, 0, 0}, {0, 0, 1}};
    };

    class Heli_Transport_02_base_F;
    class RHS_CH_47F_base: Heli_Transport_02_base_F {
        kat_stretcherPos[] = {0,-0.43,-2.63};
        kat_stretcherVector[] = {{0, 0, 0}, {0, 0, 0}};
    };

    class MRAP_01_base_F;
    class rhsusf_hmmwe_base: MRAP_01_base_F {
        kat_stretcherPos[] = {0,-0.5,-0.85};
        kat_stretcherVector[] = {{0, 0, 0}, {0, 0, 0}};
    };

    class APC_Tracked_03_base_F;
    class RHS_M2A2_Base: APC_Tracked_03_base_F {
        kat_stretcherPos[] = {-1.19,-0.6,-0.45};
        kat_stretcherVector[] = {{0,0,0},{0,0,0}};
    };

    class Tank_F;
    class APC_Tracked_02_base_F: Tank_F {};
    class rhsusf_m113tank_base: APC_Tracked_02_base_F {
        kat_stretcherPos[] = {0,-0.5,-2.05};
        kat_stretcherVector[] = {{0,0,0},{0,0,0}};
    };
};
