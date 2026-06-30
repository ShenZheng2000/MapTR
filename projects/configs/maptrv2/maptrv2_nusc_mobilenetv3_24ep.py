_base_ = [
    './maptrv2_nusc_r50_24ep.py'
]

_dim_ = 256
_num_levels_ = 1

model = dict(
    pretrained=dict(img='ckpts/mobilenet_v3_large-8738ca79.pth'),
    img_backbone=dict(
        _delete_=True,
        type='MobileNetV3',
        arch='large',
        out_indices=(16,),
        frozen_stages=1,
        norm_eval=True,
        pretrained=False),
    img_neck=dict(
        _delete_=True,
        type='FPN',
        in_channels=[960],
        out_channels=_dim_,
        start_level=0,
        add_extra_convs='on_output',
        num_outs=_num_levels_,
        relu_before_extra_convs=True),
)
