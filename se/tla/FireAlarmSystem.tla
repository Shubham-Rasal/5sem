------------------- MODULE FireAlarmSystem -------------------

EXTENDS Integers

CONSTANT MaxNozzles  \* Maximum number of nozzles (adjust as needed)
CONSTANT MaxEPumps   \* Maximum number of E_Pumps (adjust as needed)

VARIABLES Nozzles, EPumps, FireDetected

\* Initialize the number of nozzles, number of E_Pumps, and fire detection status
Init ==
    /\ Nozzles = [n \in 1..MaxNozzles |-> FALSE]  \* All nozzles are initially closed (represented as FALSE)
    /\ EPumps = [p \in 1..MaxEPumps |-> "Functional"]  \* All E_Pumps are initially functional
    /\ FireDetected = FALSE

\* Simulate fire detection
DetectFire ==
    /\ \E n \in 1..MaxNozzles : Nozzles[n] = TRUE  \* Fire detected if at least one nozzle is open
    /\ FireDetected' = TRUE
    /\ Nozzles' = Nozzles  \* Nozzle status remains the same
    /\ EPumps' = EPumps  \* E_Pump status remains the same

\* Action to open one nozzle
OpenOneNozzle(n) ==
    /\ Nozzles[n] = FALSE  \* Check if the nozzle is closed
    /\ Nozzles' = [Nozzles EXCEPT ![n] = TRUE]  \* Open one nozzle
    /\ FireDetected' = FireDetected  \* Fire detection status remains the same
    /\ EPumps' = EPumps  \* E_Pump status remains the same

\* Action to turn off one E_Pump
TurnOffOneEPump(p) ==
    /\ EPumps[p] = "Functional"  \* Check if the E_Pump is functional
    /\ EPumps' = [EPumps EXCEPT ![p] = "Off"]  \* Turn off one E_Pump
    /\ Nozzles' = Nozzles  \* Nozzle status remains the same
    /\ FireDetected' = FireDetected  \* Fire detection status remains the same

\* System behavior
Next ==
    \/ DetectFire  \* Fire detection
    \/ \E n \in 1..MaxNozzles : OpenOneNozzle(n)  \* Open one nozzle
    \/ \E p \in 1..MaxEPumps : TurnOffOneEPump(p)  \* Turn off one E_Pump

\* Safety Property: If fire is detected, at least one nozzle should be open and at least one E_Pump should be on
SafetyProperty ==
    /\ FireDetected => (\E n \in 1..MaxNozzles : Nozzles[n] = TRUE)
     /\ (\E p \in 1..MaxEPumps : EPumps[p] = "Functional")


\* The main specification
Spec ==
    /\ Init
    /\ [][Next]_<<Nozzles, EPumps, FireDetected>>
    /\ WF_ <<Nozzles, EPumps, FireDetected>> (Next)

=============================================================================
