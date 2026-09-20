# NOTE: experiment for various test-time pose
run_noise_eval () {
    local CONFIG=$1
    local CKPT=$2
    local GPUS=${3:-8}
    local TAG=${4:-$(basename "${CONFIG}" .py)}

    local LOGDIR="work_dirs/noise_logs/${TAG}"
    mkdir -p "${LOGDIR}"

    local TRANS_NOISES=(0.05 0.1 0.5 1.0)
    local ROT_NOISES=(0.005 0.01 0.02 0.05)

    for T in "${TRANS_NOISES[@]}"; do
        local LOG="${LOGDIR}/trans_${T}.log"
        echo -e "\n▶ σ_t=${T} m  ─ $(date)  ─ log: ${LOG}\n"

        bash tools/dist_test_map.sh \
             "${CONFIG}" "${CKPT}" "${GPUS}" \
             --cfg-options \
             "data.test.noise=translation" \
             "data.test.noise_std=${T}" \
             2>&1 | tee "${LOG}"
    done

    for R in "${ROT_NOISES[@]}"; do
        local LOG="${LOGDIR}/rot_${R}.log"
        echo -e "\n▶ σ_r=${R} rad  ─ $(date)  ─ log: ${LOG}\n"

        bash tools/dist_test_map.sh \
             "${CONFIG}" "${CKPT}" "${GPUS}" \
             --cfg-options \
             "data.test.noise=rotation" \
             "data.test.noise_std=${R}" \
             2>&1 | tee "${LOG}"
    done
}

# av2 geosplit
run_noise_eval \
  projects/configs/maptrv2/maptrv2_av2_3d_r50_6ep_geosplit.py \
  work_dirs/maptrv2_av2_3d_r50_6ep_geosplit/epoch_6.pth \
  8
  
# # nuscenes geosplit
# run_noise_eval \
#   projects/configs/maptrv2/maptrv2_nusc_r50_24ep.py \
#   work_dirs/maptrv2_nusc_r50_24ep/epoch_24.pth \
#   8