class ACE_Medical_Treatment {
	class IV {
		class BloodIV_O_RhP {
			volume = 1000;
			ratio[] = {"Plasma", 1};
		};
		class BloodIV_O_RhN : BloodIV_O_RhP{};
		class BloodIV_A_RhP: BloodIV_O_RhP {};
		class BloodIV_A_RhN: BloodIV_O_RhP {};
		class BloodIV_B_RhP: BloodIV_O_RhP {};
		class BloodIV_B_RhN: BloodIV_O_RhP {};
		class BloodIV_AB_RhP: BloodIV_O_RhP {};
		class BloodIV_AB_RhN: BloodIV_O_RhP {};
		
		class BloodIV_O_500_RhP {
			volume = 500;
			ratio[] = {"Plasma", 1};
		};
		class BloodIV_O_500_RhN : BloodIV_O_500_RhP{};
		class BloodIV_A_500_RhP: BloodIV_O_500_RhP {};
		class BloodIV_A_500_RhN: BloodIV_O_500_RhP {};
		class BloodIV_B_500_RhP: BloodIV_O_500_RhP {};
		class BloodIV_B_500_RhN: BloodIV_O_500_RhP {};
		class BloodIV_AB_500_RhP: BloodIV_O_500_RhP {};
		class BloodIV_AB_500_RhN: BloodIV_O_500_RhP {};
		
		class BloodIV_O_250_RhP {
			volume = 250;
			ratio[] = {"Plasma", 1};
		};
		class BloodIV_O_250_RhN : BloodIV_O_250_RhP{};
		class BloodIV_A_250_RhP: BloodIV_O_250_RhP {};
		class BloodIV_A_250_RhN: BloodIV_O_250_RhP {};
		class BloodIV_B_250_RhP: BloodIV_O_250_RhP {};
		class BloodIV_B_250_RhN: BloodIV_O_250_RhP {};
		class BloodIV_AB_250_RhP: BloodIV_O_250_RhP {};
		class BloodIV_AB_250_RhN: BloodIV_O_250_RhP {};
	};
};
