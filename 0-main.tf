# Create AWS Key Pair
resource "aws_key_pair" "aws_key" {
  key_name   = "my-personal-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
