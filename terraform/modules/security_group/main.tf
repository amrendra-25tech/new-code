# Security Group for Bastion Host
resource "aws_security_group" "bastion" {
  name        = "${var.name_prefix}-bastion-sg"
  description = "Security group for Bastion host"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from allowed CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-bastion-sg"
    }
  )
}

# Security Group for Monitoring Server
resource "aws_security_group" "monitoring" {
  name        = "${var.name_prefix}-monitoring-sg"
  description = "Security group for Private Monitoring server"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow SSH strictly from Bastion Host SG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description     = "Allow Grafana access from Bastion/VPC"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
    cidr_blocks     = [var.vpc_cidr]
  }

  ingress {
    description     = "Allow Prometheus access from Bastion/VPC"
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
    cidr_blocks     = [var.vpc_cidr]
  }

  ingress {
    description = "Allow Node Exporter scraping within VPC"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-monitoring-sg"
    }
  )
}
