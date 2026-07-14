_base_ = [
    './maptrv2_nusc_mobilenetv3_24ep.py'
]

# Expand perception range from 60x30 to 100x50
# nusc uses transposed axes: x=lateral, y=forward
# 60x30: x[-15,15]=30m lateral, y[-30,30]=60m forward
# 100x50: x[-25,25]=50m lateral, y[-50,50]=100m forward
point_cloud_range = [-25.0, -50.0, -10.0, 25.0, 50.0, 10.0]

grid_config = {
    'x': [-50.0, -50.0, 0.25],  # useless
    'y': [-25.0, -25.0, 0.25],  # useless
    'z': [-10, 10, 20],          # useless
    'depth': [1.0, 35.0, 0.5],  # useful
}

# voxel_size must satisfy: (range / voxel_size / downsample) == bev grid size
# 60x30 used voxel_size=0.15: x=30/0.15/2=100=bev_w_, y=60/0.15/2=200=bev_h_
# 100x50 needs voxel_size=0.25: x=50/0.25/2=100=bev_w_, y=100/0.25/2=200=bev_h_
voxel_size = [0.25, 0.25, 20.0]

# Keep the same BEV grid (bev_h_=200, bev_w_=100)
bev_h_ = 200
bev_w_ = 100

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
            post_center_range=[-30, -55, -30, -55, 30, 55, 30, 55],
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
