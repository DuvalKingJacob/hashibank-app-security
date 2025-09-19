# This file is the "execution plan" - where, when, and how to build.
# This version has been updated with the correct GA syntax for upstream_input.

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

# This is the magic of Linked Stacks. It uses the new 'source' attribute.
# Replace the org and project names with your exact values from the HCP UI.
upstream_input "main_vpc" {
  source = "app.terraform.io/Vearadyn/Inculta Charis/tfstacks-vpc-eks-hashibank"
}

deployment "app_security" {
  inputs = {
    # It now correctly references the 'vpc_id' output from the upstream source.
    vpc_id             = upstream_input.main_vpc.vpc_id
    
    # It also provides the necessary values for the AWS provider.
    role_arn           = "arn:aws:iam::177099687113:role/tfstacks-role" # Use your role ARN
    aws_identity_token = identity_token.aws.jwt
  }
}