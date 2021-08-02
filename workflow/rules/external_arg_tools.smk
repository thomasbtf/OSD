rule downlaod_deep_arg:
    output:
        directory("resources/deeparg/"),
    log:
        "logs/download_deep_arg.log",
    conda:
        "../envs/deeparg.yaml"
    shell:
        "([ -d {output} ] || mkdir -p {output} && cd {output} && "
        'wget --cut-dirs=5 --no-check-certificate --no-host-directories -np -r -R "index.html*" https://bench.cs.vt.edu/ftp/data/gustavo1/deeparg//database/ &&'
        'wget --cut-dirs=5 --no-check-certificate --no-host-directories -np -r -R "index.html*" https://bench.cs.vt.edu/ftp/data/gustavo1/deeparg//model/v2/metadata_LS.pkl &&'
        'wget --cut-dirs=5 --no-check-certificate --no-host-directories -np -r -R "index.html*" https://bench.cs.vt.edu/ftp/data/gustavo1/deeparg//model/v2/metadata_SS.pkl &&'
        'wget --cut-dirs=5 --no-check-certificate --no-host-directories -np -r -R "index.html*" https://bench.cs.vt.edu/ftp/data/gustavo1/deeparg//model/v2/model_LS.pkl &&'
        'wget --cut-dirs=5 --no-check-certificate --no-host-directories -np -r -R "index.html*" https://bench.cs.vt.edu/ftp/data/gustavo1/deeparg//model/v2/model_SS.pkl '
        ") 2> {log}"


rule deep_arg_short_reads:
    input:
        fq1="analysis_public/2014/datasets/workable/metagenomes/non-merged/OSD1_R1_shotgun_workable.fastq.gz",
        fq2="analysis_public/2014/datasets/workable/metagenomes/non-merged/OSD1_R2_shotgun_workable.fastq.gz",
        data="resources/deeparg",
    output:
        directory("results/deeparg/short_reads/{sample}"),
    log:
        "logs/deep_arg_short_reads/{sample}.log",
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


rule deep_arg_predict:
    input:
        fasta=(
            "resources/workable-OSD-2014/workable/metagenomes/merged/{sample}.fastq.gz"
        ),
        data="resources/deeparg",
    output:
        "results/deeparg/{sample}/{sample}.mapping.ARG",
    params:
        outdir=lambda w, output: output[0].split(".", 1)[0],
    log:
        "logs/deep_arg_short_reads/{sample}.log",
    conda:
        "../envs/deeparg.yaml"
    shell:
        "(deeparg predict --model SS --type nucl -d {input.data} --input {input.fasta} --out {params.outdir}) 2> {log}"


rule aggregate_deep_arg:
    input:
        get_deep_arg_call,
    output:
        "results/tables/deep_arg_calls.tsv",
    params:
        samples=get_osd_samples,
    log:
        "logs/aggregate_deep_arg.log",
    conda:
        "../envs/pandas.yaml"
    script:
        "../scripts/aggregate_deep_arg.py"


rule plot_deep_arg:
    input:
        "results/tables/deep_arg_calls.tsv",
    output:
        all_calls="results/plots/deep_arg_all_calls.svg",
    log:
        "logs/plot_deep_arg.log",
    conda:
        "../envs/altair.yaml"
    notebook:
        "../notebooks/plot_deep_arg.py.ipynb"
