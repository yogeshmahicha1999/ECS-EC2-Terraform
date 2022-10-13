################################# for access #####################
variable "access_key" {}

variable "secret_key" {}

variable "region" {}

######################  VPC  ##############
variable "trf-vpc" {
    type = string
  description = "VPCname"
}
variable "cidr_block" {
    type = string
  description = "Cidr Value"
}

################# Availability_zones #################

variable "availability_zone1" {
    type = string
  description = "availability zone 1"
}
variable "availability_zone2" {
    type = string
  description = "availability zone 1"
}
variable "availability_zone3" {
    type = string
  description = "availability zone 1"
}


################  Public Subnets ######### ###################
variable "public_subnetName1" {
    type = string
  description = "Public subnet Name 1"
}
variable "public_subnet1_cidr" {
    type = string
  description = "cidr_block"
}

variable "public_subnetName2" {
    type = string
  description = "Public subnet Name 2"
}
variable "public_subnet2_cidr" {
    type = string
  description = "cidr_block"
}

variable "public_subnetName3" {
    type = string
  description = "Public subnet Name 3"
}
variable "public_subnet3_cidr" {
    type = string
  description = "cidr_block"
}

######################## Private Subnets ######## ###########################
variable "private_subnetName1" {
    type = string
  description = "Private subnet Name 1"
}
variable "private_subnet1_cidr" {
    type = string
  description = "cidr_block"
}

variable "private_subnetName2" {
    type = string
  description = "Private subnet Name 2"
}
variable "private_subnet2_cidr" {
    type = string
  description = "cidr_block"
}


######################### Internet Gateway ###############################
variable "IGName" {
    type = string
  description = "Internet Gateway Name"
}

#################### Route Table for the public subnet #####################

variable "nat_cidr" {
    type = string
  description = "cidr_block"
}

variable "public_rtbname" {
    type = string
  description = "Public Route Table Name"
}

#########################  Elastic IP for the NAT Gateway ###################

variable "NG-ElasticIPTag" {
    type = string
  description = "Nat Gateway Elastic IP Name "
}

 variable "NG-name" {
   type = string
   description = "Nat Gateway Name "
}

variable "NG_route_cidr" {
    type = string
  description = "Nat Gateway Cidr "
}

variable "NG_route_name" {
    type = string
  description = "Nat Gateway Cidr "
}



############################## Application Load Balancer #####################

variable "alb_Name" {
    type = string
  description = "Application Load Balancer "
}


variable "alb_type" {
    type = string
  description = "Load Balancer Type "
}

variable "target_group_name" {
    type = string
  description = "Target Group "
}


variable "tg_type" {
    type = string
  description = "Target Group Name "
}
variable "tg_port" {
    type = string
  description = "Target Group "
}

variable "tg_listner_protocol" {
    type = string
  description = "Target Group "
}

############################## Security Groups ##############################

variable "aws_security_group_ecs" {
    type = string
  description = "Cluster Security Group Name "
}

variable "aws_security_group_alb" {
    type = string
  description = "ALB Security Group Name "
}

variable "ingress_http" {
    type = string
  description = "HTTP Port "
}
variable "ingress_https" {
    type = string
  description = "HTTPS Port "
}
variable "ingress_allow_cidr" {
    type = string
  description = "HTTPS Port "
}

#################### Autoscaling Group with Launch Configuration for EC2 Cluster ##################

variable "asg_name" {
    type = string
  description = "Autoscaling Group Name"
}
variable "asg_autoscaling_policy" {
  type = string
  description = "Autoscaling Policy Name"
  
}
variable "max_size" {
    type = number
  description = "Max Instance Size in ASG with numbers"
}
variable "min_size" {
    type = number
  description = "Minimum instance size in asg with numbers"
}
variable "desired_capacity" {
    type = number
  description = "Desired Capacity for running Instance"
}

variable "ecs_lc_name" {
    type = string
  description = "ECS Launch Configuration Name "
}

variable "ami_id" {
    type = string
  description = "Ami Id "
}

variable "ec2_instance" {
    type = string
  description = "Instance type for cluster launch "
}

variable "volume_type" {
    type = string
  description = "Volume Type "
}

variable "volume_size" {
    type = number
  description = "Volume Size "
}

###################################### IAM User ##############################################

variable "ecs_ExecutionRole_name" {
    type = string
  description = "ECS Execution Role for Service Launch "
}
variable "ec2_InstanceRole_Policy_name" {
    type = string
  description = "EC2 instance role for cloudwatch and policy access "
}

variable "ecs_instance_profile_Name" {
    type = string
  description = "ECS instance Profile name "
}

#########################################  ECS Cluster Variables ################################

variable "ecs_cluster" {
  description = "ECS cluster name"
}

variable "ecs_key_pair_name" {
  description = "EC2 instance key pair name"
}

variable "task_family_name" {
  description = "ECS Taskdef Faimly name"
}



variable "ecs_service_name" {
  description = "ECS Service name"
}

variable "service_network_mode" {
  description = "ECS Service Network Mode"
}
variable "Service_desired_count" {
      type = number
  description = "ECS Service Desired Counts"
}

variable "ordered_placement_strategy_type" {
      type = string
  description = "ordered_placement_strategy_type"
}
variable "ordered_placement_strategy_field" {
      type = string
  description = "ordered_placement_strategy_field"
}

variable "container_name" {
      type = string
  description = "Container Name"
}


variable "container_port" {
      type = number
  description = "Container port"
}

variable "launch_type" {
      type = string
  description = "launch_type"
}

#################################################################################################
