variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0ec10929233384c7f"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "moviedb"
}

variable "db_username" {
  description = "PostgreSQL username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "S3 bucket name for project storage"
  type        = string
  default     = "showgo-images"
}

variable "key_pair_name" {
  description = "Existing AWS key pair name for the EC2 instance"
  type        = string
  default     = "showgo"
}

variable "ssh_private_key_path" {
  description = "Path to the private key file, relative to the terraform directory"
  type        = string
  default     = "../showgo.pem"
}

variable "ssh_user" {
  description = "SSH username for the EC2 instance"
  type        = string
  default     = "ubuntu"
}
