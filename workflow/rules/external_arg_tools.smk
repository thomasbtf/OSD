rule downlaod_deep_arg:
    output:
        directory("resources/deeparg"),
    log:
        "logs/download_deep_arg.log"
    conda:
        "../envs/deeparg.yaml"
    shell:
        "(deeparg download_data -o {output}) 2> {log}"


rule deep_arg_short_reads:
    input:
        fq1 = "analysis_public/2014/datasets/workable/metagenomes/non-merged/OSD1_R1_shotgun_workable.fastq.gz",
        fq2 = "analysis_public/2014/datasets/workable/metagenomes/non-merged/OSD1_R2_shotgun_workable.fastq.gz",
        data = "resources/deeparg",
    output:
        directory("results/deeparg/{sample}"),
    log:
        "logs/deep_arg_short_reads/{sample}.log"
    conda:
        "../envs/deeparg.yaml"
    shell:
        """
        (deeparg short_reads_pipeline \
        --forward_pe_file {input.fq1} \
        --reverse_pe_file {input.fq2} \
        --output_file {output} \
        -d {input.data}) 2> {log}
        """