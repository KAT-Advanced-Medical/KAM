class ACE_Medical_Injuries {
    class wounds {
        // each sub-class defines a valid wound type
        class ChemicalBurn {
            bleeding = 0; // maximum blood loss per wound as a multiple of cardiac output, will be scaled by wound size. (default: 0)
            pain = 0.8; // maximum pain produced on a scale of 0..1, will be scaled by wound size (default: 0)
            causeLimping = 1; // 0 to ignore this wound type when determining whether damage to the legs is sufficient to cause limping (default: 0)
            causeFracture = 0; // 0 to prevent this wound type from causing fractures (default: 0)
            minDamage = 0;
        };
    };
    class damageTypes{
        thresholds[] = {{0.1, 1}};
        selectionSpecific = 1;

        class chemburn {
            thresholds[] = {{0, 1}};
            selectionSpecific = 0;
            noBlood = 1;
            class ChemicalBurn {
                weighting[] = {{0, 1}};
            };
        };
        
    };
};
