_base_ = [
    'maptrv2_av2_3d_r50_6ep.py',
]


# NOTE: add data_root here and use it as pose_root
data_root = 'data/argoverse2_geosplit/sensor/' # NOTE: change to geosplit data

data = dict(
    train=dict(
        data_root=data_root,
        ann_file=data_root + 'av2_map_infos_train.pkl',
        ),
    val=dict(
        data_root=data_root,
        ann_file=data_root + 'av2_map_infos_val.pkl',
        map_ann_file=data_root + 'av2_gt_map_anns_val.json',
    ),
    test=dict(
        data_root=data_root,
        ann_file=data_root + 'av2_map_infos_val.pkl',
        map_ann_file=data_root + 'av2_gt_map_anns_val.json',
    )
)