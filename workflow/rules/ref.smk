rule download_OSD14_metadata:
    output:
        "resources/OSD2014-env_data_2017-11-23.csv",
    log:
        "logs/download_OSD14_metadata.log",
    shell:
        '(curl "http://mb3is.megx.net/osd-files/download?path=/2014/samples&files=OSD2014-env_data_2017-11-23.csv" --output {output}) 2> {log}'


rule download_OSD14_ancillary_data:
    output:
        "resources/OSD2014_db_calculated_environmental_ancillary_data_2015-12-05.xlsx",
    log:
        "logs/download_OSD14_ancillary_data.log",
    shell:
        '(curl "http://mb3is.megx.net/osd-files/download?path=/2014/samples&files=OSD2014_db_calculated_environmental_ancillary_data_2015-12-05.xlsx" --output {output}) 2> {log}'


rule download_OSD2014_workable_data:
    output:
        "resources/workable.tar",
    log:
        "logs/download_OSD14_workable_data.log",
    shell:
        '(curl -k --output {output} "http://mb3is.megx.net/index.php/s/XXqTven495RZmoA/download?path=%2F2014%2Fdatasets&files=workable") 2> {log}'


checkpoint extract_OSD:
    input:
        "resources/workable.tar",
    output:
        directory("resources/workable-OSD-2014"),
    log:
        "logs/extract_OSD.log",
    shell:
        "([ -d {output} ] || mkdir -p {output} & unzip {input} -d {output}) 2> {log}"


rule download_CARD:
    output:
        temp("resources/card-v3.1.3.tar.bz2"),
    log:
        "logs/download_CARD.log",
    shell:
        '(curl "https://card.mcmaster.ca/download/0/broadstreet-v3.1.3.tar.bz2" --output {output}) 2> {log}'


rule extract_CARD:
    input:
        "resources/card-v3.1.3.tar.bz2",
    output:
        directory("resources/card"),
    log:
        "logs/extract_CARD.log",
    shell:
        "([ -d {output} ] || mkdir -p {output} & tar -xf {input} -C {output}) 2> {log}"
