
------------------- MODULE FireAlarmSystemPumps -------------------



EXTENDS TLC


VARIABLES Pump11Fault, Pump12Fault , Valve11Fault , Valve12Fault, Pump21Fault, Pump22Fault, Valve21Fault, Valve22Fault,
OffSightPowerFault , DieselGenerator1Fault, TankFault




\* Initialize the system with all components in a working state, and no fire detected
Init ==
    /\ Pump11Fault = FALSE
    /\ Pump12Fault = FALSE
    /\ Valve11Fault = FALSE
    /\ Valve12Fault = FALSE
    /\ Pump21Fault = FALSE
    /\ Pump22Fault = FALSE
    /\ Valve21Fault = FALSE
    /\ Valve22Fault = FALSE
    /\ OffSightPowerFault = FALSE
    /\ DieselGenerator1Fault = FALSE
    /\ TankFault = FALSE
   
   


PowerFailure ==
    \/ OffSightPowerFault' \in {TRUE , FALSE}
    /\ DieselGenerator1Fault' \in {TRUE , FALSE}


Pump1Failure ==
    /\ Pump11Fault' \in {TRUE , FALSE}
    /\ Pump12Fault' \in {TRUE , FALSE}
    /\ PowerFailure


Valve1Failure ==
    /\ Valve11Fault' \in {TRUE , FALSE}
    /\ Valve12Fault' \in {TRUE , FALSE}


Pump2Failure ==
    /\ Pump21Fault' \in {TRUE , FALSE}
    /\ Pump22Fault' \in {TRUE , FALSE}
    /\ PowerFailure
   


Valve2Failure ==
    /\ Valve21Fault' \in {TRUE , FALSE}  
    /\ Valve22Fault' \in {TRUE , FALSE}  


Nozzle1Failure ==
    /\ Pump1Failure
    /\ Valve1Failure
    /\ TankFault' \in {TRUE , FALSE}


Nozzle2Failure ==
    /\ Pump2Failure
    /\ Valve2Failure
    /\ TankFault' \in {TRUE , FALSE}


Next ==
   /\ Nozzle1Failure
    /\ Nozzle2Failure
   


Vars == <<Pump11Fault, Pump12Fault , Valve11Fault , Valve12Fault, Pump21Fault, Pump22Fault, Valve21Fault, Valve22Fault,
OffSightPowerFault , DieselGenerator1Fault, TankFault>>




Spec ==
    /\ Init
    /\ [][Next]_Vars




=============================================================================




