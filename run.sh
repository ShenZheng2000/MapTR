# NOTE: must specify --geosplit!!!!!!!!!!!!!!!!!!!
python tools/maptrv2/custom_nusc_map_converter.py --root-path ./data/nuscenes --out-dir ./data/nuscenes --extra-tag nuscenes --version v1.0 --canbus ./data/nuscenes --geosplit

# Training
bash tools/dist_train.sh projects/configs/maptrv2/maptrv2_nusc_r50_24ep.py 8