variable "vpc_cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch."
  default     = "default"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name in AWS"
}

variable "env" {
  type        = string
  description = "Environment in which VPC is created in i.e dev, staging or production"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "The IPv4 CIDR block for the public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "The IPv4 CIDR block for the private subnets"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "az" {
  type        = list(string)
  description = "AWS Availability Zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "ecs_cluster_igw_name" {
  type        = string
  description = "Internet Gateway Name in AWS"
}

variable "secondary_route_table_name" {
  type        = string
  description = "Name of the secondary route table"
}