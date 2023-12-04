#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y docker.io
sudo usermod -aG docker adminuser
export niki=$USER  