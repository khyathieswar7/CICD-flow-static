#!/bin/bash
yum update -y 
yum install httpd -y
sudo systemctl enable httpd 
sudo systemctl start httpd


