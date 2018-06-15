#!/bin/bash

sudo yum install -y unzip curl wget nfs-utils
sudo yum update -y ecs-init

echo ECS_CLUSTER="${cluster_name}" >> /etc/ecs/ecs.config
echo ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=1h >> /etc/ecs/ecs.config

sudo chmod 777 /etc/sysconfig/docker-storage
echo "DOCKER_STORAGE_OPTIONS=\"--storage-driver overlay2\"" > /etc/sysconfig/docker-storage
sudo chmod 644 /etc/sysconfig/docker-storage

cd /home/ec2-user/

sudo service docker restart
sudo start ecs
