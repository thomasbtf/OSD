import sys
sys.stderr = open(snakemake.log[0], "w")

import pandas as pd 


def aggregate(sm_input, sm_output, samples):
    single_outputs = []

    for file_path, sample in zip (sm_input, samples):
        single_deep_arg_output = pd.read_csv(file_path, sep="\t")
        single_deep_arg_output["sample"] = sample
        single_outputs.append(single_deep_arg_output)

    deep_arg_output = pd.concat(single_outputs, ignore_index=True)
    deep_arg_output.to_csv(sm_output, sep="\t", index=False)


if __name__ == "__main__":
    samples = snakemake.params.get("samples", "")
    aggregate(snakemake.input, snakemake.output[0], samples)
