# NOTE: experiment for various test-time pose
# TODO; then do experiment for maptrv2
run_noise_eval () {
    local CONFIG=$1
    local CKPT=$2
    local GPUS=${3:-8}

    local TRANS_NOISES=(0 0.05 0.1 0.2)
    local ROT_NOISES=(0 0.005 0.01 0.02)

    for T in "${TRANS_NOISES[@]}"; do
        for R in "${ROT_NOISES[@]}"; do
            echo -e "\n▶ σ_t=${T} m , σ_r=${R} rad  ─ $(date)\n"

            bash tools/dist_test_map.sh \
                 "${CONFIG}" "${CKPT}" "${GPUS}" \
                 --cfg-options \
                 "data.test.noise=both" \
                 "data.test.noise_std=[${R},${T}]"
        done
    done
}

run_noise_eval \
  projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep.py \
  work_dirs/maptrv2_av2_3d_r50_6ep/epoch_6.pth \
  8

run_noise_eval \
  projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep_geosplit.py \
  work_dirs/maptrv2_av2_3d_r50_6ep_geosplit/epoch_6.pth \
  8
  
# bash test_noise.sh | tee work_dirs/master_7_6.log