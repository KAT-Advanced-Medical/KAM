class CfgMovesBasic {
    class ManActions {
        kat_stretcher = "kat_stretcher";
    };
};

class CfgMovesMaleSdr: CfgMovesBasic {
    class States {
        class Crew;
        class kat_stretcher: Crew {
            file = "a3\anims_f\data\anim\sdr\inj\ainjppnemstpsnonwnondnon.rtm";
            interpolateTo[] = {"Unconscious", 0.02};
            leftHandIKCurve[] = {};
            rightHandIKCurve[] = {};
        };
    };
};
