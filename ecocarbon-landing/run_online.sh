#!/bin/bash
sudo docker image build -t eco_web/nginx .
sudo docker container run -d -p 8086:80 eco_web/nginx
