class CfgMovesBasic {
    class ManActions {
        KAM_stretcher = "KAM_stretcher";
    };
};

class CfgMovesMaleSdr: CfgMovesBasic {
    class States {
        class Crew;
        class KAM_stretcher: crew {
            file = "a3\anims_f\data\anim\sdr\inj\ainjppnemstpsnonwnondnon.rtm";
            interpolateTo[] = {"Unconscious", 0.02};
            leftHandIKCurve[] = {};
            rightHandIKCurve[] = {};
        };
    };
};
