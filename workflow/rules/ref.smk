rule download_OSD14_metadata:
    output:
        "resources/OSD2014-env_data_2017-11-23.csv",
    log:
        "logs/download_OSD14_metadata.log"
    shell:
        "(curl \"http://mb3is.megx.net/osd-files/download?path=/2014/samples&files=OSD2014-env_data_2017-11-23.csv\" --output {output}) 2> {log}"


rule download_OSD14_ancillary_data:
    output:
        "resources/OSD2014_db_calculated_environmental_ancillary_data_2015-12-05.xlsx",
    log:
        "logs/download_OSD14_ancillary_data.log"
    shell:
        "(curl \"http://mb3is.megx.net/osd-files/download?path=/2014/samples&files=OSD2014_db_calculated_environmental_ancillary_data_2015-12-05.xlsx\" --output {output}) 2> {log}"


rule download_OSD14_workable_data:
    output:
        "resources/workable.tar",
    log:
        "logs/download_OSD14_workable_data.log"
    shell:
        "(curl -kJO \"https://mb3is.megx.net/index.php/s/XXqTven495RZmoA/download\" --output {output}) 2> {log}"