class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_TicketConversion {
                    displayName = CSTRING(TicketConversion);
                    condition = QUOTE(_target call FUNC(ticketConversionCondition));
                    statement = QUOTE(_target call FUNC(ticketConversion));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };
};