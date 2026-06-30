_base_ = [
    'maptrv2_av2_3d_r50_6ep_geosplit.py',
]

# Expand perception range from 60x30 to 100x50
# x: [-30, 30] -> [-50, 50] (100m), y: [-15, 15] -> [-25, 25] (50m)
point_cloud_range = [-50.0, -25.0, -5.0, 50.0, 25.0, 3.0]

grid_config = {
    'x': [-50.0, -50.0, 0.25],  # useless
    'y': [-25.0, -25.0, 0.25],  # useless
    'z': [-10, 10, 20],          # useless
    'depth': [1.0, 35.0, 0.5],  # useful
}

# voxel_size must satisfy: (range / voxel_size / downsample) == bev grid size
# 60x30 used voxel_size=0.15: x=60/0.15/2=200=bev_w_, y=30/0.15/2=100=bev_h_
# 100x50 needs voxel_size=0.25: x=100/0.25/2=200=bev_w_, y=50/0.25/2=100=bev_h_
voxel_size = [0.25, 0.25, 8.0]

# Keep the same BEV grid (bev_h_=100, bev_w_=200)
bev_h_ = 100
bev_w_ = 200

model = dict(
    pts_bbox_head=dict(
        bev_h=bev_h_,
        bev_w=bev_w_,
        transformer=dict(
            encoder=dict(
                pc_range=point_cloud_range,
                voxel_size=voxel_size,
                grid_config=grid_config,
            ),
        ),
        bbox_coder=dict(
            # post_center_range adds ~5m padding beyond point_cloud_range edges
            post_center_range=[-55, -30, -55, -30, 55, 30, 55, 30],
            pc_range=point_cloud_range,
            voxel_size=voxel_size,
        ),
        positional_encoding=dict(
            row_num_embed=bev_h_,
            col_num_embed=bev_w_,
        ),
    ),
    train_cfg=dict(pts=dict(
        voxel_size=voxel_size,
        point_cloud_range=point_cloud_range,
        assigner=dict(
            pc_range=point_cloud_range,
        ),
    )),
)

data = dict(
    train=dict(
        bev_size=(bev_h_, bev_w_),
        pc_range=point_cloud_range,
    ),
    val=dict(
        bev_size=(bev_h_, bev_w_),
        pc_range=point_cloud_range,
    ),
    test=dict(
        bev_size=(bev_h_, bev_w_),
        pc_range=point_cloud_range,
    ),
)
