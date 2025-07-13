class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_TicketConversion {
                    displayName = CSTRING(TicketConversion);
                    condition = QUOTE([ARR_2(objNull, _target)] call FUNC(ticketConversionCondition));
                    statement = QUOTE([ARR_2(objNull, _target)] call FUNC(ticketConversion));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };
};