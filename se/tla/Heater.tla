------------------------------ MODULE Heater ------------------------------
EXTENDS Integers, Sequences

CONSTANT TargetTemperature, LearningRate

VARIABLE CurrentTemperature, HeaterDuration

Init == /\ CurrentTemperature \in 0..100
        /\ HeaterDuration = 0

HeaterControl ==
                /\ CurrentTemperature < TargetTemperature
                    => HeaterDuration' = HeaterDuration + LearningRate
                /\ CurrentTemperature >= TargetTemperature
                    => HeaterDuration' = HeaterDuration - LearningRate

TemperatureModel ==
                /\ CurrentTemperature' = CurrentTemperature + 2 * HeaterDuration  (* Simple temperature model *)
                /\ HeaterDuration' = HeaterDuration  (* No change in heater duration by default *)

Next == HeaterControl /\ TemperatureModel


=============================================================================