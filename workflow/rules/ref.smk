rule download_OSD14_metadata:
    output:
        "resource/OSD2014-env_data_2017-11-23.csv",
    log:
        "logs/download_OSD14_metadata.log"
    conda:
        "../envs/.yaml"
    shell:
        "(curl \"http://mb3is.megx.net/osd-files/download?path=/2014/samples&files=OSD2014-env_data_2017-11-23.csv\" --output {output}) 2> {log}"