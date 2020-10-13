data "aws_route_table" "table" {
  vpc_id = var.vpc_id
}

resource "aws_route" "route" {
  route_table_id         = data.aws_route_table.table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gw_id
}
