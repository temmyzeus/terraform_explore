resource "local_file" "new_file" {
  filename = "hello_world.txt"
  content = var.text_content
}
