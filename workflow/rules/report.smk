rule snakemake_reports:
    input:
        "results/plots/deep_arg_all_calls.svg",
    output:
        "results/OSD14-ARG-Report.zip",
    log:
        "logs/report.log",
    shell:
        "(snakemake --nolock {input} --report {output}) > {log} 2>&1"