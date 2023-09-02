class CfgMovesBasic {
    class Default;
};

class CfgMovesMaleSdr: CfgMovesBasic {
    class States {
        class DeadState;
        class kat_recoveryposition: DeadState {
            speed = 100;
            file = QPATHTO_T(anim\recovery_position.rtm);
        };
        class kat_headTurn: Default {
            file = "a3\anims_f\data\anim\sdr\inj\healing\AinvPknlMstpSnonWnonDr_medic3.rtm";
            speed = 0.13;
            looped = 0;
            disableWeapons = 1;
            disableWeaponsLong = 1;
            showWeaponAim = 0;
            canPullTrigger = 0;
            duty = 0.2;
            limitGunMovement = 0;
            aiming = "empty";
            aimingBody = "empty";
            ConnectFrom[] = {
                "kat_headTurn", 
                0.1
            };
            ConnectTo[] = {};
            forceAim = 1;
            InterpolateTo[]=
            {
                "kat_headTurn", 
                0.1,
                "AinvPknlMstpSnonWnonDnon_medic",
                0.1,
                "AinvPknlMstpSnonWnonDr_medic0S",
                0.1,
                "Unconscious",
                0.02,
                "AinvPknlMstpSnonWnonDnon_medicEnd",
                0.2
            };
        };
    };
};