# Main Infrastructure Integration

# 1. VPC Module
module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = var.vpc_cidr
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

# 2. Subnet Module
module "subnet" {
  source               = "./modules/subnet"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  name_prefix          = local.name_prefix
  tags                 = local.common_tags
}

# 3. Internet Gateway Module
module "internet_gateway" {
  source      = "./modules/internet_gateway"
  vpc_id      = module.vpc.vpc_id
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

# 4. NAT Gateway Module
module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = module.subnet.public_subnet_ids[0]
  name_prefix      = local.name_prefix
  tags             = local.common_tags
}

# 5. Route Table Module
module "route_table" {
  source             = "./modules/route_table"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.internet_gateway.igw_id
  nat_gateway_id     = module.nat_gateway.nat_gateway_id
  public_subnet_ids  = module.subnet.public_subnet_ids
  private_subnet_ids = module.subnet.private_subnet_ids
  name_prefix        = local.name_prefix
  tags               = local.common_tags
}

# 6. Security Group Module
module "security_group" {
  source           = "./modules/security_group"
  vpc_id           = module.vpc.vpc_id
  vpc_cidr         = var.vpc_cidr
  allowed_ssh_cidr = var.allowed_ssh_cidr
  name_prefix      = local.name_prefix
  tags             = local.common_tags
}

# 7. KeyPair Module
module "keypair" {
  source   = "./modules/keypair"
  key_name = var.ssh_key_name
  tags     = local.common_tags
}

# 8. IAM Module
module "iam" {
  source      = "./modules/iam"
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

# 9. Bastion Host EC2 Instance (Public Subnet)
module "bastion_ec2" {
  source               = "./modules/ec2"
  instance_name        = "bastion"
  instance_type        = var.bastion_instance_type
  subnet_id            = module.subnet.public_subnet_ids[0]
  key_name             = module.keypair.key_name
  security_group_ids   = [module.security_group.bastion_security_group_id]
  associate_public_ip  = true
  iam_instance_profile = module.iam.instance_profile_name
  name_prefix          = local.name_prefix
  tags                 = local.common_tags
}

# 10. Monitoring Host EC2 Instance (Private Subnet)
module "monitoring_ec2" {
  source               = "./modules/ec2"
  instance_name        = "monitoring-server"
  instance_type        = var.monitoring_instance_type
  subnet_id            = module.subnet.private_subnet_ids[0]
  key_name             = module.keypair.key_name
  security_group_ids   = [module.security_group.monitoring_security_group_id]
  associate_public_ip  = false
  iam_instance_profile = module.iam.instance_profile_name
  volume_size          = 30
  name_prefix          = local.name_prefix
  tags                 = local.common_tags
}

# 11. CloudWatch Integration Module
module "cloudwatch" {
  source                 = "./modules/cloudwatch"
  monitoring_instance_id = module.monitoring_ec2.instance_id
  name_prefix            = local.name_prefix
  tags                   = local.common_tags
}
