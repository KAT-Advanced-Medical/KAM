class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class KAM_stretcher: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(stretcher_display);
        descriptionShort = CSTRING(stretcher_desc);
        descriptionUse = CSTRING(stretcher_desc);
        picture = QPATHTOF(ui\npa.paa);
        model = "\A3\Props_F_Orange\Humanitarian\Camps\Stretcher_01_folded_F.p3d";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 15;
        };
    };
};
