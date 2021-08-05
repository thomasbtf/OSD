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
        "logs/plot_osd_locations.log"
    conda:
        "../envs/altair.yaml"
    notebook:
        "../notebooks/plot_osd_locations.py.ipynb"