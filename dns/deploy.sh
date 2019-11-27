#!/bin/bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
PROJECT_NAME="dj-dns"
APP_NAMESPACE=${PROJECT_NAME}
MESH_NAME=${PROJECT_NAME}

deploy_app() {
    EXAMPLES_OUT_DIR="${DIR}/_output/"
    mkdir -p ${EXAMPLES_OUT_DIR}

    eval "cat <<EOF
$(<${DIR}/manifest.yaml.template)
EOF
" >${EXAMPLES_OUT_DIR}/manifest.yaml

    eval "cat <<EOF
$(<${DIR}/metal_service_update.yaml.template)
EOF
" >${EXAMPLES_OUT_DIR}/metal_service_update.yaml


    eval "cat <<EOF
$(<${DIR}/jazz_service_update.yaml.template)
EOF
" >${EXAMPLES_OUT_DIR}/jazz_service_update.yaml

    kubectl apply -f ${EXAMPLES_OUT_DIR}/manifest.yaml
}

main() {
    deploy_app
}

main