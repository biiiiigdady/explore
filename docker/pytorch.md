# 创建 pytorch 容器

- 能够使用 GPU

```bash
## 创建容器
docker create \
    -it \
    --privileged \
    --ipc=host \
    --gpus all \
    --name "pytorch-2208" \
    -e DOCKER_USER="${USER}" \
    -e USER="${USER}" \
    -e DOCKER_USER_ID="$(id -u ${USER})" \
    -e DOCKER_GRP="$(id -g -n)" \
    -e DOCKER_GRP_ID="$(id -g)" \
    -e DOCKER_IMG="nvcr.io/nvidia/pytorch" \
    -e DOCKER_IMG_TAG="22.08-py3" \
    -e TERM="xterm-256color" \
    --hostname "container" \
    -v /dev/null:/dev/raw1394 \
    -v /data/${USER}:/home/${USER} \
    -w /home/${USER} \
    --memory 8g \
    --memory-swap=16g \
    nvcr.io/nvidia/pytorch:22.08-py3
```

## 启动容器

```sh
docker exec pytorch-2208 /bin/bash -c "id -u ${USER}"
docker exec pytorch-2208 /bin/bash -c "useradd ${USER} -u $(id -u ${USER}) -p '123'"
docker exec pytorch-2208 /bin/bash -c "echo \"${user} ALL=(ALL) ALL\" >> /etc/sudoers"
docker exec pytorch-2208 /bin/bash -c "chmod +s /usr/bin/sudo"
docker exec pytorch-2208 /bin/bash -c "chmod 1777 /tmp"
docker exec -u "${USER}" -it pytorch-2208 /bin/bash
docker exec -it pytorch-2208 /bin/bash
```