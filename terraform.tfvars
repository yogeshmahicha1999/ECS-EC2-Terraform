##################################### access  ##################################

access_key = ""
secret_key = ""
region     = "ap-south-1"

######## Vpc Name and Cidr Block Value ###########3

trf-vpc = "ecs-terraform-vpc"
cidr_block = "10.0.0.0/16"

########### Availability_zones #####################
availability_zone1 = "ap-south-1a"
availability_zone2 = "ap-south-1b"
availability_zone3 = "ap-south-1c"

##### Public Subnets with cidr_block ############
public_subnetName1  = "public-subnet-1"
public_subnet1_cidr = "10.0.0.0/24"

public_subnetName2  = "public-subnet-2"
public_subnet2_cidr = "10.0.1.0/24"

public_subnetName3  = "public-subnet-3"
public_subnet3_cidr = "10.0.2.0/24"

############# Private Subnets with Cidr ###############
private_subnetName1  = "private-subnet-1"
private_subnet1_cidr = "10.0.3.0/24"

private_subnetName2  = "public-subnet-2"
private_subnet2_cidr = "10.0.4.0/24"


################## Internet_Gateway ##################
IGName = "igw-ecs"

########### Route Table for the public subnet ################
nat_cidr       = "0.0.0.0/0"
public_rtbname = "public-route-table"

##################  NAT Gateway #############
NG-ElasticIPTag = "default"
NG-name       = "nat-gateway-ecs"
NG_route_cidr = "0.0.0.0/0"
NG_route_name = "nat-route"

################# Application Load Balancer #######################
alb_Name            = "load-1"
asg_autoscaling_policy = "web-cluster"
alb_type            = "application"
target_group_name   = "target-group-1"
tg_type             = "ip"
tg_port             = "80"
tg_listner_protocol = "HTTP"

########### Security Groups ###########################
aws_security_group_ecs = "ecs-sg"
aws_security_group_alb = "alb-sg"
ingress_http           = "80"
ingress_https          = "443"
ingress_allow_cidr     = "0.0.0.0/0"
#ingress_ssh = "22"
#ingress_allow_custom = ""

############# Autoscaling Group with Launch Configuration for EC2 Cluster ##################
ecs_lc_name      = "lc-ecs-1"
ami_id           = "ami-0416723f8e455592c"
ec2_instance     = "t2.medium"
volume_type      = "gp2"
volume_size      = "1024"
asg_name         = "trf-asg-1"

max_size         = "2"
min_size         = "1"
desired_capacity = "1"

############## IAM User & Role ##########################
ecs_ExecutionRole_name       = "iam-role-1"
ec2_InstanceRole_Policy_name = "policy-name-1"
ecs_instance_profile_Name    = "instance-1"

##############  ECS Cluster Variables ####################
ecs_cluster                      = "cluster-ecs"
ecs_key_pair_name                = "ecs-key"
task_family_name                 = "family-ecs"
ecs_service_name                 = "service-ecs"
service_network_mode             = "awsvpc"
Service_desired_count            = "1"
ordered_placement_strategy_type  = "spread"
ordered_placement_strategy_field = "instanceId"
container_name                   = "container-ecs"
container_port                   = "80"
launch_type		         = "EC2"
