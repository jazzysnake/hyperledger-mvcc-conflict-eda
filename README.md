# Exploratory Data Analysis of Multiversion Concurrency Control Conflict in Hyperledger Fabric

In Hyperledger-Fabric each transaction is first executed, then ordered by data dependencies, then validated against the current state of the blockchain. Because of this architecture transactions can be executed in parallel, however if a key is written to, its version number is updated and all transactions that have not yet been validated and read the previous version number, get invalidated. They receive the validation code of MVCC_READ_CONFILCT.

If a lot of transactions receive this code, it will negatively affect performance of the system. This project aims to uncover the patterns that cause a lot of these conflicts, so the chaincode can be rewritten in a way that avoids this.

## Running the notebook

If docker is installed, after extracting the sample data in the data folder, a local Hyperledger Explorer database instance can be stated with the included shell script by running the following command:

```
./setup-db.sh data/<name of the dataset>
```

## The mvcc-finder notebook

The mvcc-finder uses kotlin to process the data in parallel. It uses the kotlin kernel which can be installed by following the instructions listed [here](https://github.com/Kotlin/kotlin-jupyter). Follow the instructions in the mvcc-eda notebook to run it or process the data in python sequentially.