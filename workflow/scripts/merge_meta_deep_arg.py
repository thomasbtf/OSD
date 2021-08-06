if "snakemake" in locals():
    debug = False
else:
    debug = True

if not debug:
    import sys

    sys.stderr = open(snakemake.log[0], "w")

import pandas as pd


def merge_deep_arg_calls(mapping, meta_data, deep_arg_calls, output):
    mapping = pd.read_excel(mapping)
    meta_data = pd.read_csv(meta_data, sep="|")

    merged_data = pd.merge(
        mapping,
        meta_data,
        how="left",
        left_on="label",
        right_on="label",
        validate="1:1",
    )
    merged_data = merged_data.drop(columns=["osd_id_y"]).rename(
        columns={"osd_id_x": "osd_id"}
    )

    deep_arg_calls = pd.read_csv(deep_arg_calls, sep="\t")
    deep_arg_calls["osd_id"] = deep_arg_calls["sample"].str.extract(r"OSD(\d{1,3})")
    deep_arg_calls["osd_id"] = deep_arg_calls["osd_id"].astype(int)

    merged_data = pd.merge(
        merged_data,
        deep_arg_calls,
        how="left",
        left_on="file_name",
        right_on="sample",
        validate="1:m",
    )
    merged_data.to_csv(output, sep="\t", index=False)


if __name__ == "__main__":
    if debug:
        mapping = "/local/thomas/OSD/resources/ME_osd_id_alloction.xlsx"
        meta_data = "/local/thomas/OSD/resources/OSD2014-env_data_2017-11-23.csv"
        deep_arg_calls = "/local/thomas/OSD/results/tables/deep_arg_all_calls.tsv"
        output = "results/tables/deep_arg_calls_with_meta_data.tsv"
        merge_deep_arg_calls(mapping, meta_data, deep_arg_calls, output)
    else:
        merge_deep_arg_calls(
            snakemake.input.mapping,
            snakemake.input.meta_data,
            snakemake.input.deep_arg_calls,
            snakemake.output[0],
        )
