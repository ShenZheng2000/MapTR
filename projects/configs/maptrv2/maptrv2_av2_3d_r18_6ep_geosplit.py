_base_ = [
    './maptrv2_av2_3d_r50_6ep_geosplit.py'
]

_dim_ = 256
_num_levels_ = 1

model = dict(
    pretrained=dict(img='ckpts/resnet18-f37072fd.pth'),
    img_backbone=dict(
        _delete_=True,
        type='ResNet',
        depth=18,
        num_stages=4,
        out_indices=(3,),
        frozen_stages=-1,
        norm_cfg=dict(type='SyncBN', requires_grad=True),
        norm_eval=False,
        style='pytorch'),
    img_neck=dict(
        _delete_=True,
        type='FPN',
        in_channels=[512],
        out_channels=_dim_,
        start_level=0,
        add_extra_convs='on_output',
        num_outs=_num_levels_,
        relu_before_extra_convs=True),
)
