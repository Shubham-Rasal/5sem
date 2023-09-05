------------------------------ MODULE Network ------------------------------

EXTENDS Naturals, Sequences , TLC

CONSTANT NetworkStatus, FaultDetected

VARIABLES MainLinkStatus, BackupLinkStatus, RecoveryAction

Init ==
  /\ NetworkStatus \in {"Online", "Offline"}
  /\ FaultDetected = FALSE
  /\ MainLinkStatus = "Online"
  /\ BackupLinkStatus = "Online"
  /\ RecoveryAction = "None"

NetworkRecovery ==
  /\ FaultDetected = TRUE
  /\ MainLinkStatus = "Offline"
  /\ BackupLinkStatus = "Online"
  /\ RecoveryAction = "SwitchToBackup"

MainLinkRecovery ==
  /\ FaultDetected = FALSE
  /\ MainLinkStatus = "Online"
  /\ BackupLinkStatus = "Online"
  /\ RecoveryAction = "None"
  /\ NetworkStatus' = "Online"

  /\ (NetworkStatus = "Online") =>
      /\ MainLinkStatus' = "Online"
      /\ BackupLinkStatus' = "Online"
      /\ RecoveryAction' = "None"
  /\ (NetworkStatus = "Offline") =>
      /\ MainLinkStatus' = "Offline"
      /\ BackupLinkStatus' = "Online"
      /\ RecoveryAction' = "SwitchToBackup"

Next ==
  \/ NetworkRecovery
  \/ MainLinkRecovery

SelfHealingProperty ==
  /\ NetworkStatus \in {"Online", "Offline"}
  /\ IF NetworkStatus = "Online"
       THEN (MainLinkStatus = "Online") /\ (BackupLinkStatus = "Online")
       ELSE (MainLinkStatus = "Offline") /\ (BackupLinkStatus = "Online")
  /\ RecoveryAction \in {"None", "SwitchToBackup"}
  /\ (FaultDetected = TRUE) => (RecoveryAction = "SwitchToBackup")
  /\ (FaultDetected = FALSE) => (RecoveryAction = "None")


Spec ==
  /\ Init
  /\ [][Next]_<<NetworkStatus, FaultDetected, MainLinkStatus, BackupLinkStatus, RecoveryAction>>
  /\ SelfHealingProperty

=============================================================================
