

 
class cfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_gasmaskFilter : ACE_ItemCore {
        scope = 2;
        author = "DiGii";
        displayName = CSTRING(GasFilterItem);
        model = "\A3\weapons_F\ammo\mag_univ.p3d";
        picture = QPATHTOF(ui\gasmaskfilter_ca.paa);
        descriptionShort = CSTRING(GasFilterItem_desc);
        descriptionUse = CSTRING(GasFilterItem_desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };

    class kat_Antidot : ACE_ItemCore {
        scope = 2;
        author = "DiGii";
        displayName = CSTRING(AntidotItem);
        model = QPATHTOF(data\antidote.p3d);
        picture = QPATHTOF(ui\antidote_ca.paa);
        descriptionShort = CSTRING(AntidotItem_desc);
        descriptionUse = CSTRING(AntidotItem_desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };

    class kat_sealant : ACE_ItemCore {
        scope = 2;
        author = "DiGii";
        displayName = CSTRING(sealantItem);
        model = "\A3\Weapons_F\DummyItem.p3d";
        picture = QPATHTOF(ui\Sealant.paa);
        descriptionShort = CSTRING(sealantItem_desc);
        descriptionUse = CSTRING(sealantItem_desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
    };

};