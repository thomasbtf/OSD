from snakemake.utils import validate
import pandas as pd
import os

##### load config and sample sheets #####

# validate(config, schema="../schemas/config.schema.yaml")

# samples = pd.read_csv(config["samples"], sep="\t").set_index("sample", drop=False)
# samples.index.names = ["sample_id"]
# validate(samples, schema="../schemas/samples.schema.yaml")


def get_merged_metagenomes():
    merged_metagenomes = os.listdir(
        "resources/workable-OSD-2014/workable/metagenomes/merged"
    )
    merged_metagenomes = [
        filename.replace(".fastq.gz", "")
        for filename in merged_metagenomes
        if filename.endswith(".fastq.gz")
    ]

    merged_metagenomes = [
        filename for filename in merged_metagenomes if "_ME_" in filename
    ]

    return merged_metagenomes


def get_osd_samples(wildcards):
    checkpoint_output = checkpoints.extract_OSD.get(**wildcards).output[0]
    return get_merged_metagenomes()


def get_deep_arg_call(wildcards):
    samples = get_osd_samples(wildcards)
    return expand("results/deeparg/{sample}/{sample}.mapping.ARG", sample=samples)


def get_deep_arg_plots(wildcards):
    samples = get_osd_samples(wildcards)
    return expand("results/plots/deeparg/{sample}.svg", sample=samples)
