_base_ = [
    'maptrv2_av2_3d_r50_6ep_geosplit.py',
]


data = dict(
    test=dict(
        load_interval=1,    # every frame (no subsampling), to match skeptic's frame set
    ),
)