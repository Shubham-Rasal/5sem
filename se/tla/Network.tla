------------------- MODULE Network -------------------

EXTENDS Integers

VARIABLES LiveServer, BackupServer, FailureDetected

\* Initialize the system with the live server online, the backup server offline, and no failure detected
Init ==
    /\ LiveServer = "Online"
    /\ BackupServer = "Offline"
    /\ FailureDetected = FALSE

\* Simulate a server failure
ServerFailure ==
    /\ LiveServer = "Online"
    /\ LiveServer' = "Offline"
    /\ BackupServer' = "Online"
    /\ FailureDetected' = TRUE

\* Simulate a server recovery
ServerRecovery ==
    /\ LiveServer = "Offline"
    /\ BackupServer = "Online"
    /\ LiveServer' = "Online"
    /\ BackupServer' = "Offline"
    /\ FailureDetected' = FALSE

\* System behavior
Next ==
    \/ ServerFailure  \* Live server failure
    \/ ServerRecovery  \* Live server recovery

\* Safety Property: If a failure is detected, the backup server should be online
SafetyProperty ==
    /\ FailureDetected => (BackupServer = "Online")

\* The main specification
Spec ==
    /\ Init
    /\ [][Next]_<<LiveServer, BackupServer, FailureDetected>>
    /\ WF_ <<LiveServer, BackupServer, FailureDetected>> (Next)

=============================================================================
