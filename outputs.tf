output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.ec2.public_dns
}

output "rds_endpoint" {
  description = "RDS PostgreSQL database endpoint"
  value       = aws_db_instance.db.endpoint
}

output "s3_bucket_name" {
  description = "Name of the existing S3 bucket used by the backend"
  value       = data.aws_s3_bucket.main.id
}

output "backend_api_url" {
  description = "URL for the backend API"
  value       = "http://${aws_instance.ec2.public_ip}:8000"
}

output "frontend_api_env" {
  description = "Value to place in First-heart/.env so the frontend calls the deployed backend"
  value       = "EXPO_PUBLIC_API_URL=http://${aws_instance.ec2.public_ip}:8000"
}

output "ssh_command" {
  description = "SSH command for connecting to the backend server"
  value       = "ssh -i ${var.ssh_private_key_path} ${var.ssh_user}@${aws_instance.ec2.public_ip}"
}
