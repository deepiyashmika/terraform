provider "aws" {

access_key="${var.access_key}"
secret_key="${var.secret_key}"
region="${var.region}"

}

resource "aws_instance" "deepikatf"{
ami="ami-06a4d8bb2743a6e00"
instance_type="t2.medium"

tags={
Name = "deepikainstance"
}

}

resource "aws_instance" "deepikastf"{
ami="ami-04b29aaed8d74f8f3"
instance_type="t2.medium"

tags={
Name = "deepika1instance"
}

}


resource "aws_instance" "deepikamuthutf" {
ami="ami-04b29aaed8d74f8f3"
instance_type="t2.medium"
key_name="${aws_key_pair.deepitfkey.id}"

tags={
Name = "deepika3instance"
}
vpc_security_group_ids = ["${aws_security_group.deepitfsecgroup.id}"]


provisioner "local-exec" {
	when="create"
	command="echo ${aws_instance.deepikamuthutf.public_ip}>sample.txt"
	}

provisioner "chef"{
connection{
host ="${self.public_ip}"
type="ssh"
user="ec2-user"
private_key="${file("C:\\Image\\mykey.pem")}"
}
client_options=["chef_license 'accept'"]
run_list=["testenv_aws_tf_chef::default"]
node_name="tfdeepika.aac.come"
server_url="https://manage.chef.io/organizations/deepikamuthu"
user_name="deepiyashmi@gmail.com"
user_key="${file("C:\\Image\\chef-starter\\chef-repo\\.chef\\deepi.pem")}"
ssl_verify_mode=":verify_none"
}

}

resource "aws_key_pair" "deepitfkey" {
key_name="deepikakeypair"
public_key="${file("C:\\Image\\key.pub")}"
}

resource "aws_security_group" "deepitfsecgroup"{
name="deepikasecgroup"
description="to allow traffic"


ingress{
from_port="0"
to_port="0"
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}

egress{
from_port="0"
to_port="0"
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
}

output "deepikapublicip"{
	value="${aws_instance.deepikamuthutf.public_ip}"
}
//terraform import "'aws_eip.myip" "ami-04b29aaed8d74f8f3"

resource "aws_eip" "deepieip"{
tags={
name="deepikaeip"
}
instance="${aws_instance.deepikamuthutf.id}"
}



//terraform plan
//terraform apply
//install the putti software


resource "aws_s3_bucket" "deepibucket" {
bucket="deepikabucket"
key="terraform.tfstate"
region="private"
force_destroy="true"

}

terraform{

backend "s3"{
bucket="deepikabucket"
key="terraform.tfstate"
region="eu-west-1"
}
}

//terraform init -backend-config="access_key=AKIAZTIMJ7JHPVODYVZA" -backend-config="secret_key=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"


//terraform init 
//https://manage.chef.io/login

/**/
