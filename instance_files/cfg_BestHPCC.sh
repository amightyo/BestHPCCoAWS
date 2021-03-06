# cfg_BestHPCC.sh
user=ec2-user
private_ips=private_ips.txt
public_ips=public_ips.txt
created_environment_file=/etc/HPCCSystems/source/newly_created_environment.xml
supportnodes=1
non_support_instances=6
roxienodes=0
slavesPerNode=16
hpcc_platform=hpccsystems-platform_community-with-plugins-5.0.0-3.el6.x86_64.rpm
S3_ACCESS_KEY=<your aws access key>
S3_SECRET_KEY=<your aws secret key>
bucket_name=<your bucket>
slave_instance_type=i2.8xlarge
master_instance_type=c3.4xlarge
pem=<your pem file>
infolder=instance_files
instance_ids=instance_ids.txt
region=<your region>

