------------------- MODULE FireAlarmSystem -------------------

EXTENDS TLC


VARIABLES Pump1Fault , Valve1Fault, Pump2Fault, Valve2Fault,
OffSightPowerFault , DieselGenerator1Fault, DieselGenerator2Fault

\* Initialize the system with all components in a working state, and no fire detected
Init == 
    /\ Pump1Fault = FALSE
    /\ Valve1Fault = FALSE
    /\ Pump2Fault = FALSE
    /\ Valve2Fault = FALSE
    /\ OffSightPowerFault = FALSE
    /\ DieselGenerator1Fault = FALSE
    /\ DieselGenerator2Fault = FALSE

PowerFailure ==
    \/ OffSightPowerFault' \in {TRUE , FALSE}
    /\ DieselGenerator1Fault' \in {TRUE , FALSE}
    /\ DieselGenerator2Fault' \in {TRUE , FALSE}

Pump1Failure == 
    /\ Pump1Fault' \in {TRUE , FALSE}
    /\ PowerFailure

Valve1Failure ==
    /\ Valve1Fault' \in {TRUE , FALSE}

Pump2Failure ==
    /\ Pump2Fault' \in {TRUE , FALSE}
    /\ PowerFailure
    

Valve2Failure ==
    /\ Valve2Fault' \in {TRUE , FALSE}   

Nozzle1Failure ==
    /\ Pump1Failure
    /\ Valve1Failure

Nozzle2Failure ==
    /\ Pump2Failure
    /\ Valve2Failure

Next == 
   /\ Nozzle1Failure
   /\ Nozzle2Failure
  

Vars == <<Pump1Fault, Valve1Fault, Pump2Fault, Valve2Fault, OffSightPowerFault, DieselGenerator1Fault , DieselGenerator2Fault>>

Spec == 
    /\ Init
    /\ [][Next]_Vars


=============================================================================
