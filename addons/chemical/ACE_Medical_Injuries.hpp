// Custom wound + damage type for chemical-warfare blister agents (mustard,
// future lewisite-class agents)
//
// ACE's parseConfigForInjuries (medical_damage/functions) walks
// configFile >> "ACE_Medical_Injuries" at preInit and merges all addon
// contributions automatically, so no further wiring is needed.

class ACE_Medical_Injuries {
    class wounds {
        class KAT_ChemicalBurn {
            bleeding = 0.005;  // mustard blisters weep — slow but persistent
            pain = 0.6;
            minDamage = 0;
        };
        // Beta / local high-dose radiation burn. Like a chemical burn but
        // weeps less and hurts more (deep tissue damage, slow to heal).
        class KAT_RadiationBurn {
            bleeding = 0.003;
            pain = 0.7;
            minDamage = 0;
        };
    };

    class damageTypes {
        class KAT_chemicalBurn {
            thresholds[] = {{0, 1}};
            selectionSpecific = 0;
            class KAT_ChemicalBurn {
                weighting[] = {{0, 1}};
            };
        };
        class KAT_radiationBurn {
            thresholds[] = {{0, 1}};
            selectionSpecific = 0;
            class KAT_RadiationBurn {
                weighting[] = {{0, 1}};
            };
        };
    };
};
