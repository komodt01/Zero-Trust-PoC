
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.zt_vpc.id

  tags = {
    Name = "ZeroTrustIGW"
  }
}
