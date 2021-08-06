rule plot_osd_locations:
    input:
        "resources/OSD2014-env_data_2017-11-23.csv",
    output:
        report(
            "results/plots/osd-locations.svg",
            caption="../report/osd-locations.rst",
            category="1. Overview",
            subcategory="1. OSD Location",
        ),
    log:
        "logs/plot_osd_locations.log",
    conda:
        "../envs/altair.yaml"
    notebook:
        "../notebooks/plot_osd_locations.py.ipynb"


rule merge_meta_deep_arg:
    input:
        mapping="resources/ME_osd_id_alloction.xlsx",
        meta_data="resources/OSD2014-env_data_2017-11-23.csv",
        deep_arg_calls="results/tables/deep_arg_all_calls.tsv",
    output:
        "results/tables/deep_arg_calls_with_meta_data.tsv",
    log:
        "logs/merge_meta_deep_arg.log",
    conda:
        "../envs/pandas.yaml"
    script:
        "../scripts/merge_meta_deep_arg.py"
