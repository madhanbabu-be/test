resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = var.port
  protocol = var.proto
  vpc_id   = var.vpcid
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = var.targetinstance
  port             = var.port
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_sg
  subnets            = var.subnets
  enable_deletion_protection = false

}

resource "aws_lb_listener" "listen" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = var.port
  protocol          = var.proto

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.test.arn}"
  }
}
