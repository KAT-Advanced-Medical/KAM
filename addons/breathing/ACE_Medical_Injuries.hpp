class ACE_Medical_Injuries {
    class damageTypes {
        class woundHandlers;
        class bullet {
            class woundHandlers: woundHandlers {
                GVAR(pulmoHit) = QFUNC(woundsHandlerPulmoHit);
            };
        };
    };
};
