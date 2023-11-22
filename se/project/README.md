# Tools used in the project

## TLA+

The TLA+ tools are used to model and verify the system. The tools are available from the [TLA+ website](http://lamport.azurewebsites.net/tla/tla.html). 

NOTE: For pretty-print to work, you need to install a LaTeX distribution. We recommend [MiKTeX](https://miktex.org/download).


### Instructions to run the files

The given tla+ files can be opened in the TLA+ toolbox. The toolbox can be used to run the model checker and the simulator. The model checker can be used to verify the system. The simulator can be used to simulate the system.

For the configuration of the model checker, please refer to the corresponsing `.cfg` file. The configuration file can be loaded in the model checker.

In our case, the only configuration required is to set the specification to `Spec` and the model to `Model`. The model checker can be run by clicking on the `Model Check` button on the top left corner of the toolbox. The results of the model checker can be seen in the `Model Checking Results` tab.

After running the model checker, you will be able to see the distinct states of the system. If everything goes well, there shouldn't be any error states. The model checker can be run for different values of the parameters by changing the values in the `Model` tab. The results of the model checker can be seen in the `Model Checking Results` tab.

## SHARPE Tool

This tool is used for Fault Tree constructions and FTA(Fault Tree Analysis). The tool is available from the [SHARPE website](https://sharpe.pratt.duke.edu/node/3#:~:text=SHARPE%20(Symbolic%20Hierarchical%20Automated%20Reliability,availability%2C%20performance%2C%20and%20performability)).

The original software is not open source or free for public download. We got the academic access to the software through our institute. 

### Instructions to run the files

1. Open the SHARPE tool.
2. Place the `.flt` and `.rgl` files in the same folder (You can place them in the FTA examples folder for ease of use).
3. Now open the `.rgl` file in the SHARPE tool.

Now you run the analysis on the fault tree. The analysis can be run by clicking on the `Analysis` button on the top left corner of the tool. The analysis can be run for different values of the parameters by changing the values in the `Parameter` tab. The results of the analysis can be seen in the `Results` tab.

For the results, you can choose various parameters like reliability and MTTF with custom duration before clicking run.

Graph options are also available in the tool. The graph can be viewed by clicking on the `Graph` button on the top left corner of the `Results` tab. The graph can be viewed in different formats by changing the options in the `Graph` tab.
