resource "aws_elastic_beanstalk_environment" "vprofile-bean-prod" {
  name                = "vprofile-bean-prod"
  application         = aws_elastic_beanstalk_application.vprofile-prod.name
  solution_stack_name = "64bit Amazon Linux 2 v4.3.1 running Tomcat 8.5 Corretto 11"
#  solution_stack_name = "64bit Amazon Linux 2 v4.2.2 running Tomcat 8.5 Corretto 11"
  cname_prefix        = "vprofile-bean-prod-domain"
  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = "vprofile.vpc.id"

  }
  setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:lauchconfiguration"
    value     = "t2.micro"
  }
  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:lauchconfiguration"
    value     = "false"
  }
#  setting {
#    name      = "ELBSubnets"
#    namespace = "aws:ec2:vpc"
#    value     = join(",", [aws_subnet.public-sub1, aws_subnet.public-sub2, aws_subnet.public-sub3])
#  }
#  setting {
#    name      = "Subnets"
#    namespace = "aws:ec2:vpc"
#    value     = join(", ", [aws_subnet.priv-sub1, aws_subnet.priv-sub2, aws_subnet.priv-sub3])
#  }


  depends_on = [aws_security_group.vprofile-bean-elb-sg, aws_security_group.vprofile-prod-sg]

}





