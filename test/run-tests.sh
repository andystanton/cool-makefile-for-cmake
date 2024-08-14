#!/usr/bin/env bash

pushd $(dirname $0) >/dev/null
script_path=$PWD
parent_path=$(dirname $script_path)
popd >/dev/null

docker_image_name=andystanton/cool-makefile-for-cmake-test-env

function test_lang() {
    target_lang=$1
    mount_path=/data/cool-makefile-for-cmake
    test_path="${mount_path}-test"

    makefile_output=$(docker run --rm \
        -v $parent_path:$mount_path \
        $docker_image_name \
        sh -c 'mkdir -p '$test_path' \
            && cd '$test_path' \
            && cp '$mount_path'/Makefile '$test_path' \
            && make project_name=test-project project_lang='$target_lang' cmake_min_version=3.5 run')

    if [ $? = 0 ] && echo "$makefile_output" | egrep -q '^hello, world!'; then
        return 0
    else
        return 1
    fi
}

function log_result() {
    target_lang=$1
    result_value=$2

    if [ $result_value = 0 ]; then 
        printf "[\x1b[32m✔\x1b[0m] $target_lang\n"
    else
        printf "[\x1b[31m✘\x1b[0m] $target_lang\n"
    fi
}

echo "Building test environment..."

docker build $script_path -t $docker_image_name

echo "Running tests..."

test_lang c
c_result=$?

test_lang cpp
cpp_result=$?

echo "Test results..."

log_result c $c_result
log_result cpp $cpp_result

echo "Cleaning up Docker image"

docker rmi $docker_image_name

if [ $c_result = 0 ] && [ $cpp_result = 0 ]; then
    exit 0
else
    exit 1
fi

