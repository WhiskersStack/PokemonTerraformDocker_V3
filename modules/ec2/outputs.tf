output "instance_id" {
  value = aws_instance.pokemon_game.id
}
output "public_ip" {
  value = aws_instance.pokemon_game.public_ip
}
output "db_id" {
  value = aws_instance.pokemon_db.id
}
output "db_public_ip" {
  value = aws_instance.pokemon_db.public_ip
}
output "ssh_command" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.pokemon_game.public_ip}"
}
output "db_ssh_command" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.pokemon_db.public_ip}"
}
output "public_ip_db" {
  value = aws_instance.pokemon_db.public_ip
}