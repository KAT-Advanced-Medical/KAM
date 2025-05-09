#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Begins Flumazenil unsedating process
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_pharma_fnc_treatmentAdvanced_FlumazenilOverdoseLocal;
 *
 * Public: No
 */
params ["_patient"];
systemChat str "flumanzinilODLocal";
private _hrAdjust = 20 + floor random ((40 - 20) + 1);
[_patient, "TACHYCARDIA", 120, 1200, _hrAdjust] call EFUNC(vitals,addMedicationAdjustment);
if QEGVAR(feedback,effectOverdose) then
    {
    PP_wetD = ppEffectCreate ["WetDistortion",300];
    PP_wetD ppEffectEnable true;
    PP_wetD ppEffectAdjust [10,0.2,0.2,1.84,1.46,0.33,0.86,0.05,0.05,0.05,0.05,0.1,0.1,0.2,0.2];
    PP_wetD ppEffectCommit 0;
    [{PP_wetD ppEffectEnable false; PP_wetD ppEffectCommit 0;}, [], 600] call CBA_fnc_waitAndExecute;};
    // Date YYYY-MM-DD-HH-MM: [2035,6,24,8,0]. Overcast: 0.3. Fog: 0.0806154. Fog params: [0.0800015,0.013,0] 
    // GF PostProcess Editor parameters: Copy the following line to clipboard and click Import in the editor.
    //[[false,100,[0.2,0.2,0.26,0.3]],[false,200,[0.05,0.05,true]],[true,300,[10,0.2,0.2,1.84,1.46,0.33,0.86,0.05,0.05,0.05,0.05,0.1,0.1,0.2,0.2]],[false,1500,[1,1,0,[2,2,2,-0.1],[5,5,5,1],[4,0.33,0.33,0],[0.66,0,0.96,0,0,0,4]]],[false,500,[2.06]],[false,2000,[0.44,1,1,0.5,0.5,true]],[false,2500,[1,1,1]]]
    