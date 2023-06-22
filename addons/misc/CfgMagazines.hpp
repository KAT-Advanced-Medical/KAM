class CfgMagazines {
    class CA_Magazine;
    
    class kat_Bubble_Wrap: CA_Magazine {
        scope = 2;
        author = "Miss Heda";
        displayName = "Bubble"; //CSTRING(Bubble_Wrap_Display); //TODO
        picture = QPATHTOF(ui\Bubble_Wrap_Item.paa); //TODO
        
        ammo = "";
        count = 50;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 0.1;
    };
};
