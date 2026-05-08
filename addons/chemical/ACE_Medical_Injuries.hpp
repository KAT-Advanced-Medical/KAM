// Custom wound + damage type for chemical-warfare blister agents (mustard,
// future lewisite-class agents)
//
// ACE's parseConfigForInjuries (medical_damage/functions) walks
// configFile >> "ACE_Medical_Injuries" at preInit and merges all addon
// contributions automatically, so no further wiring is needed.

class ACE_Medical_Injuries {
    class wounds {
        class ChemicalBurn {
            bleeding = 0.005;  // mustard blisters weep — slow but persistent
            pain = 0.6;
            minDamage = 0;
        };
    };

    class damageTypes {
        class chemicalBurn {
            thresholds[] = {{0, 1}};
            selectionSpecific = 0;
            class ChemicalBurn {
                weighting[] = {{0, 1}};
            };
        };
    };
};
