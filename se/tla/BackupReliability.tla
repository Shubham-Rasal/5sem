------------------- MODULE BackupReliability -------------------

EXTENDS Integers

CONSTANT MaxComponents  \* Maximum number of components (adjust as needed)
CONSTANT MaxBackups     \* Maximum number of backups (adjust as needed)

VARIABLES Components, Backups, Reliability, Cost

\* Initialize the system with all components and backups offline
Init ==
    /\ Components = [c \in 1..MaxComponents |-> "Offline"]
    /\ Backups = [b \in 1..MaxBackups |-> "Offline"]
    /\ Reliability = 0.0
    /\ Cost = 0.0

\* Action to add one backup to the system
AddOneBackup(b) ==
    /\ 1 <= b <= MaxBackups
    /\ Backups[b] = "Offline"  \* Check if the backup is offline
    /\ Backups' = [Backups EXCEPT ![b] = "Online"]  \* Add one backup
    /\ Cost' = Cost + ComputeBackupCost(b)  \* Update the cost
    /\ Reliability' = ComputeReliability()  \* Update the reliability

\* Function to compute the cost of adding a backup
ComputeBackupCost(b) ==
    IF b = 1 THEN 100 ELSE 50  \* Example cost function (adjust as needed)

\* Function to compute the system reliability
ComputeReliability() ==
    LET
        componentFailureRate(i) == IF Components[i] = "Offline" THEN 0.0 ELSE 0.01  \* Example failure rate
    IN
        1 - Product(i \in 1..MaxComponents, 1 - componentFailureRate(i))  \* Example reliability computation

\* Product of a sequence of values
Product(seq) ==
    IF seq = <<>> THEN 1 ELSE Head(seq) * Product(Tail(seq))

\* System behavior
Next ==
    \/ \E b \in 1..MaxBackups : AddOneBackup(b)  \* Add one backup

\* Safety Property: Reliability should increase with each added backup
SafetyProperty ==
    /\ Cost <= MaxComponents * 100  \* Cost should not exceed the cost of adding backups to all components
    /\ \A b \in 1..MaxBackups :
        IF Backups[b] = "Online" THEN Reliability' >= Reliability ELSE TRUE

\* The main specification
Spec ==
    /\ Init
    /\ [][Next]_<<Components, Backups, Reliability, Cost>>
    /\ WF_ <<Components, Backups, Reliability, Cost>> (Next)

=============================================================================
