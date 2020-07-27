#!/bin/bash

clone_layer () {
    url=${1}
    branch=${2}
    revision=${3}
    dir=${4}

    if [ ! -d "$dir" ]; then
        git clone --branch $branch $url $dir
    fi
    pushd $dir > /dev/null
    git checkout $branch
    git pull
    git reset $revision --hard
    popd > /dev/null
}

mkdir -p sources
pushd sources

clone_layer "git://git.yoctoproject.org/poky" "zeus" "d6c3a4db81576aec3a7ceab17969faff97e94aa0" "poky"
clone_layer "git://git.openembedded.org/meta-openembedded" "zeus" "2b5dd1eb81cd08bc065bc76125f2856e9383e98b" "openembedded"
clone_layer "https://github.com/meta-qt5/meta-qt5/" "zeus" "9d4490a0f4e1bfeba2660e79e1357f39b64f8027" "meta-qt5"
clone_layer "https://github.com/agherzan/meta-raspberrypi.git" "zeus" "0e05098853eea77032bff9cf81955679edd2f35d" "meta-raspberrypi"

popd > /dev/null

cp ./meta-rpi/rpi-init-env .
