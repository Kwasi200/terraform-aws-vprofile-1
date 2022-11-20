

resource "aws_db_subnet_group" "vprofile-rds-subgrp" {
  #name       = "main"
  subnet_ids = [aws_subnet.priv-sub1.id, aws_subnet.priv-sub2.id, aws_subnet.priv-sub3.id]

  tags = {
    Name = "subnet group for RDS"
  }
}


resource "aws_elasticache_subnet_group" "vprofile-ecache-subgrp" {
  name       = "vprofile-ecache-subgrp"
  subnet_ids = [aws_subnet.priv-sub1.id, aws_subnet.priv-sub2.id, aws_subnet.priv-sub3.id]

  tags = {
    Name = "subnet group for ECACHE"
  }
}



resource "aws_db_instance" "vprofile-rds" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  db_name                = var.dbname
  username               = var.username
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  publicly_accessible    = "false"
  multi_az               = "false"
  db_subnet_group_name   = aws_db_subnet_group.vprofile-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.vprofile-backend-sg.id]
}



resource "aws_elasticache_cluster" "vprofile-cache" {
  cluster_id           = "vprofile-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.vprofile-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-ecache-subgrp.name
}



resource "aws_mq_broker" "vprofile-rmq" {
  broker_name        = "vprofile-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.vprofile-backend-sg.id]
 # subnet_ids         = [aws_subnet.priv-sub1.id, aws_subnet.priv-sub2.id, aws_subnet.priv-sub3.id]
  subnet_ids         = [aws_subnet.priv-sub1.id]
  user {
    password = var.rmqpass
    username = var.rmquser
  }
}











