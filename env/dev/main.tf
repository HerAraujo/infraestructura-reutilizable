# -------------------------
# Define el provider de AWS
# -------------------------
provider "aws" {
  region = local.region
}

locals {
  region  = "us-east-2"
  ami     = var.ubuntu_ami[local.region]
  entorno = "dev"
}

# -----------------------------------------------
# Data source que obtiene el id del AZ us-east-1a
# -----------------------------------------------
data "aws_subnet" "public_subnet" {
  for_each          = var.servidores
  availability_zone = "${local.region}${each.value.az}"
}

module "servidores_ec2" {
  source = "../../modules/instances-ec2"

  puerto_servidor = 8080
  tipo_instancia  = "t2.nano"
  ami_id          = local.ami
  servidores = {
    for id_servidor, datos in var.servidores :
    id_servidor => { nombre = datos.nombre, subnet_id = data.aws_subnet.public_subnet[id_servidor].id }
  }
  entorno = local.entorno
}

module "loadbalancer" {
  source = "../../modules/loadbalancer"

  subnet_id       = [for subnet in data.aws_subnet.public_subnet : subnet.id]
  instancia_ids   = module.servidores_ec2.instancia_ids
  puerto_lb       = 80
  puerto_servidor = 8080
  entorno         = local.entorno

}
