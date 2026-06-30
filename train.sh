# export PYTHONPATH=/home/shenzheng_google_com/Projects/Inf_Perception/Methods/MapTR:$PYTHONPATH



# # # => train maptrv2 on av2 geosplit

# preprocess
# python tools/maptrv2/custom_av2_map_converter.py --data-root ./data/argoverse2_geosplit/

# train
# bash ./tools/dist_train.sh \
#     ./projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep_geosplit.py \
#     8 \
#     --work-dir work_dirs/maptrv2_av2_3d_r50_6ep_geosplit

# train (100m x 50m)
bash ./tools/dist_train.sh \
    ./projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep_geosplit_100x50.py \
    8 \
    --work-dir work_dirs/maptrv2_av2_3d_r50_6ep_geosplit_100x50

# # # # => train maptrv2 on av2 geosplit (mobilnet backbone)
# bash tools/dist_train.sh projects/configs/maptrv2/maptrv2_av2_3d_mobilenetv3_6ep_geosplit.py 8

# test
# bash tools/dist_test_map.sh \
#     projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep_geosplit.py \
#     work_dirs/maptrv2_av2_3d_r50_6ep_geosplit/latest.pth 8

# test on all frames
# mkdir -p work_dirs/maptrv2_av2_3d_r50_6ep_geosplit_allframes

# cp work_dirs/maptrv2_av2_3d_r50_6ep_geosplit/latest.pth \
#     work_dirs/maptrv2_av2_3d_r50_6ep_geosplit_allframes

# bash tools/dist_test_map.sh \
#     projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep_geosplit_allframes.py \
#     work_dirs/maptrv2_av2_3d_r50_6ep_geosplit_allframes/latest.pth 8



# # # # => train maptrv2 on nuscenes geosplit

# preprocess (NOTE: must specific geosplit)
# python tools/maptrv2/custom_nusc_map_converter.py --root-path ./data/nuscenes --out-dir ./data/nuscenes --extra-tag nuscenes --version v1.0 --canbus ./data/nuscenes --geosplit

# train
# bash tools/dist_train.sh projects/configs/maptrv2/maptrv2_nusc_r50_24ep.py 8

# train (100m x 50m)
bash tools/dist_train.sh projects/configs/maptrv2/maptrv2_nusc_r50_24ep_100x50.py 8

# # # # => train maptrv2 on nuscenes geosplit (mobilnet backbone)
# bash tools/dist_train.sh projects/configs/maptrv2/maptrv2_nusc_mobilenetv3_24ep.py 8


# test 
# bash tools/dist_test_map.sh projects/configs/maptrv2/maptrv2_nusc_r50_24ep.py work_dirs/maptrv2_nusc_r50_24ep/latest.pth 8



# visualize nuscenes dataset
# python tools/maptrv2/nusc_vis_pred.py \
#     projects/configs/maptrv2/maptrv2_nusc_r50_24ep.py \
#     work_dirs/maptrv2_nusc_r50_24ep/epoch_24.pth

# visualize argoverse2 dataset
# python tools/maptrv2/av2_vis_pred.py \
#     projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep_geosplit.py \
#     work_dirs/maptrv2_av2_3d_r50_6ep_geosplit/epoch_6.pth


# merge vis
# python tools/maptr/generate_video.py work_dirs/maptrv2_nusc_r50_24ep/vis_pred