class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_Torso {
                displayName = CSTRING(Torso);
                selection = "spine1";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_Chest {
                displayName = CSTRING(Chest);
                selection = "spine3";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_Head {
                displayName = CSTRING(Head);
                selection = "pilot";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_Neck {
                displayName = CSTRING(Neck);
                selection = "Neck";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_ArmLeft {
                displayName = CSTRING(ArmLeft);
                selection = "LWrist";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_ArmUpperLeft {
                displayName = CSTRING(ArmUpperLeft);
                selection = "LeftForeArm";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_ArmRight {
                displayName = CSTRING(ArmRight);
                selection = "RWrist";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_ArmUpperRight {
                displayName = CSTRING(ArmUpperRight);
                selection = "RightForeArm";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_LegLeft {
                displayName = CSTRING(LegLeft);
                selection = "LeftFoot";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_LegUpperLeft {
                displayName = CSTRING(LegUpperLeft);
                selection = "LKnee";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_LegRight {
                displayName = CSTRING(LegRight);
                selection = "RightFoot";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
            class ACE_LegUpperRight {
                displayName = CSTRING(LegUpperRight);
                selection = "RKnee";
                distance = 1.5;
                condition = "";
                statement = "";
                exceptions[] = {"isNotSwimming"};
            };
        };
    };
};