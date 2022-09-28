#!/bin/bash
# Owner: bmmc

# 当前工作目录
CUR_DIR=${PWD}

# 设备 architecture (x86 x64 etc.)
HOST_ARCH="$(uname -m)"

# 设备 操作系统(Linux Darwin etc.)
HOST_OS="$(uname -s)"

# docker 容器运行命令
DOCKER_RUN_CMD="docker run"

# 容器名称
DEV_CONTAINER="container.sample"

# 镜像名称
DEV_IMAGE="ubuntu-22.04"

# 容器中的用户名 container
DEV_INSIDE="container.sample"

# 密码
DEF_PASSWD="123"

# 打印错误
function error() {
  (echo >&2 -e "[${RED}ERROR${NO_COLOR}] $*")
}

# 打印信息
function info() {
  (echo >&2 -e "[${WHITE}${BOLD}INFO${NO_COLOR}] $*")
}

# 用户、用户ID、组名、组ID
user="${USER}"
uid="$(id -u $user)"
group="$(id -g -n)"
gid="$(id -g)"

function mount_user_disk() {
    set -x
    num=$(mount | grep "/mnt/${user}" | wc -l)
    if [ $num == '0' ];then
        if [ -f "/mnt/disk/${user}.img" ];then
            mount /mnt/disk/${user}.img /mnt/${user}
	        chown -R ${new_usr}:auto /mnt/${new_usr}
	        chmod 700 /mnt/${new_usr}
	    fi
    fi
}

function docker_run() {
    
    ssh_port=$((50000 + $uid))
    if [ ${DEV_CONTAINER} == "horizon_dev_${USER}-${DEV_IMAGE_16}" ];then
        ssh_port=$((ssh_port + 5000))
    fi
    #for new docker user.
    mount_user_disk
    info "Creating docker container \"${DEV_CONTAINER}\" ..."
    ${DOCKER_RUN_CMD} -itd \
        --privileged \
        --name "${DEV_CONTAINER}" \
        -e DOCKER_USER="${user}" \
        -e USER="${user}" \
        -e DOCKER_USER_ID="${uid}" \
        -e DOCKER_GRP="${group}" \
        -e DOCKER_GRP_ID="${gid}" \
        -e DOCKER_IMG="${DEV_IMAGE}" \
        -e TERM="xterm-256color" \
        --hostname "${DEV_INSIDE}" \
        -v /dev/null:/dev/raw1394 \
        -v /data/${user}:/home/${user} \
	    -w /home/${user} \
	    -p ${ssh_port}:22 \
	    --memory 12g \
	    --memory-swap=16g \
        ${DEV_IMAGE} \
        /bin/bash

    if [ $? -ne 0 ]; then
        error "Failed to start docker container \"${DEV_CONTAINER}\" based on image: ${DEV_IMAGE}"
        exit 1
    fi
}

function main() {
    if [ $# -eq 1 ];then
    	if [ "$1" == "-h" ];then
		    info "Command \"docker_start\" to start a container."
		    info "Usage:"
		    info "	docker_start or docker_start $image_name"
            info "	docker_start is same \"docker_start ${DEV_IMAGE}\""
            info "	only support base on \"${DEV_IMAGE}\", \"${DEV_IMAGE_16}\""
            docker images
            exit 0;
	    fi
        docker images |grep "$1" -w
        if [ $? -eq 0 ];then
            DEV_IMAGE=${1}
            DEV_CONTAINER=${DEV_CONTAINER}-${DEV_IMAGE}
        else
            error "Not exist this docker image:$1"
            info "help: docker_start docker_image_name"
            info "$(docker images)"
            exit 1
        fi
    fi

    info "Docker container checking \"${DEV_CONTAINER}\" ..."
    docker ps | grep -w "${DEV_CONTAINER}$"
    #container alive?
    if [ $? -ne 0 ];then
    	#exist container?
	    docker ps -a | grep -w "${DEV_CONTAINER}$"
    	if [ $? -eq 0 ];then
            info "Activating container \"${DEV_CONTAINER}\"..."
            docker start "$DEV_CONTAINER"
            #start ssh service first#
            docker exec ${DEV_CONTAINER} /bin/bash -c "service ssh start"
	    else
	        docker_run
	    fi
    fi


    info "Starting docker container \"${DEV_CONTAINER}\" ..."
    docker exec ${DEV_CONTAINER} /bin/bash -c "id -u $user"
    if [ $? -ne 0 ];then
        info "Adding docker user \"${user}\",uid:\"${uid}\",default passwd: \"${DEF_PASSWD}\""
	    docker exec ${DEV_CONTAINER} /bin/bash -c "useradd ${user} -u ${uid} -p '${DEF_PASSWD}' && echo '${user}:${DEF_PASSWD}'| chpasswd"
	    docker exec ${DEV_CONTAINER} /bin/bash -c "echo \"${user} ALL=(ALL) ALL\" >> /etc/sudoers"
	    docker exec ${DEV_CONTAINER} /bin/bash -c "usermod -s /bin/bash ${user}"
        #start ssh service first#
        docker exec ${DEV_CONTAINER} /bin/bash -c "service ssh start"
    fi
    #workaround after move docker to /mnt#
    docker exec ${DEV_CONTAINER} /bin/bash -c "chmod +s /usr/bin/sudo"
    docker exec ${DEV_CONTAINER} /bin/bash -c "chmod 1777 /tmp"

    docker exec \
            -u "${USER}" \
            -it "${DEV_CONTAINER}" \
	    /bin/bash
}

main "$@"
