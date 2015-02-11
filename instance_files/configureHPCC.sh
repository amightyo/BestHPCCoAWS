#!/bin/bash -e
# This code is executed on ESP after installing HPCCSystems on all instances.

# The following usage example is what you do to configure an hpccsystem for best high performance on AWS when i2.8xlarge
# instances are used for the slave nodes. This example, configures 16 thor slave nodes per instance. And, there are 7
# instances. Making the total number of thor slave nodes 112 thor slave nodes. Also, this newly configured system will
# do mirroring.

# There are ALWAYS 7 input arguments
private_ips=$1;
created_environment_file=$2;
supportnodes=$3;
non_support_instances=$4;
roxienodes=$5;
slavesPerNode=$6;

envgen=/opt/HPCCSystems/sbin/envgen;

# Make new environment.xml file for newly configured HPCC System.
echo "sudo $envgen -env $created_environment_file -override thor,@replicateAsync,true -override thor,@replicateOutputs,true -ipfile $private_ips -supportnodes $supportnodes -thornodes $non_support_instances -roxienodes $roxienodes -slavesPerNode $slavesPerNode -roxieondemand 1"
sudo $envgen  -env $created_environment_file -override thor,@replicateAsync,true -override thor,@replicateOutputs,true -ipfile $private_ips -supportnodes $supportnodes -thornodes $non_support_instances -roxienodes $roxienodes  -slavesPerNode $slavesPerNode -roxieondemand 1


# Copy the newly created environment file  to /etc/HPCCSystems on all nodes of the THOR
out_environment_file=/etc/HPCCSystems/environment.xml
sudo -u hpcc /opt/HPCCSystems/sbin/hpcc-push.sh -s $created_environment_file -t $out_environment_file
