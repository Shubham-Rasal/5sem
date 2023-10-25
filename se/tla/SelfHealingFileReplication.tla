------------------- MODULE SelfHealingFileReplication -------------------

EXTENDS Naturals, TLC

CONSTANT NumBackups  \* The number of backup servers (adjust as needed)

VARIABLES PrimaryStatus, BackupStatus

\* Initialize the primary and backup server statuses
INITIAL_PREDICATE ==
  /\ PrimaryStatus = "Online"  \* Primary server is initially online
  /\ BackupStatus = [i \in 1..NumBackups |-> "Offline"]  \* All backup servers are initially offline

\* Simulate a failure and recovery process for the primary server
PrimaryFailure == 
  /\ PrimaryStatus = "Online"
  /\ PrimaryStatus' = "Offline"
  /\ BackupStatus' = [BackupStatus EXCEPT ![1] = "Online"]  \* Promote the first backup to be the new primary

PrimaryRecovery == 
  /\ PrimaryStatus = "Offline"
  /\ BackupStatus[1] = "Online"
  /\ PrimaryStatus' = "Online"
  /\ BackupStatus' = [BackupStatus EXCEPT ![1] = "Offline"]

\* Simulate a failure and recovery process for a backup server
BackupFailure(i) == 
  /\ BackupStatus[i] = "Online"
  /\ PrimaryStatus = "Online"  \* Ensure that the primary server is online when a backup fails
  /\ BackupStatus' = [BackupStatus EXCEPT ![i] = "Offline"]
  /\ PrimaryStatus' = "Online"  \* Update the primary server status

BackupRecovery(i) == 
  /\ BackupStatus[i] = "Offline"
  /\ PrimaryStatus = "Online"  \* Ensure that the primary server is online for a backup to recover
  /\ PrimaryStatus' = "Online"
  /\ BackupStatus' = [BackupStatus EXCEPT ![i] = "Online"]



Next ==
  \/ PrimaryFailure   \* Primary server failure
  \/ PrimaryRecovery  \* Primary server recovery
  \/ \E i \in 1..NumBackups : BackupFailure(i)   \* Backup server failure
  \/ \E i \in 1..NumBackups : BackupRecovery(i)  \* Backup server recovery

\* The main specification
Spec ==
  /\ INITIAL_PREDICATE
  /\ [][Next]_<<PrimaryStatus, BackupStatus>>
  /\ WF_ <<PrimaryStatus, BackupStatus>> (Next)

=============================================================================
