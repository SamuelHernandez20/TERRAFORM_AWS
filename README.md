# TERRAFORM_AWS

En esta práctica se busca automatizar el proceso de creación de grupos, instancias y creación y asociación de direcciones ip elásticas con las instancias.
Para ello lo estaré realizando desde **Terraform**.

A continuación muestro la estructura de los scripts de **automatización**:
 # Estructura de Directorios:

```
    |   ├── .gitignore
    │   ├── main.tf
    │   ├── output.tf
    │   ├── variables.tf

```
 ## 1. Desde el script del main.tf:
 
```
# Configuramos el proveedor de AWS
provider "aws" {
  region     = var.Region
  access_key = var.clave_acceso
  secret_key = var.clave_secreta
  token      = var.token
}
```

Creación de los grupos de seguridad [Frontends, Backend, NFS y Balanceador]:

```
resource "aws_security_group" "Grupo_frontend" {
  name        = var.Group_name_Frontends
  description = var.Group_description_Frontends
}
```
```
resource "aws_security_group" "Grupo_Backend" {
  name        = var.Group_name_Backend
  description = var.Group_description_Backend
}
```
```
resource "aws_security_group" "Grupo_NFS" {
  name        = var.Group_name_NFS
  description = var.Group_description_NFS
}
```
```
resource "aws_security_group" "Grupo_Balanceador" {
  name        = var.Group_name_Balanceador
  description = var.Group_description_Balanceador
}
```

Creación de las reglas de entrada de los grupos de seguridad.
**Reglas de entrada para los frontales**:
```
resource "aws_security_group_rule" "ingress_frontends" {
  security_group_id = aws_security_group.Grupo_frontend.id
  type              = "ingress" # <- Se define el tipo entrada

  count     = length(var.allowed_ingress_ports_frontends)      # <- Saca la longitud de la lista de los puertos definidos.
  from_port = var.allowed_ingress_ports_frontends[count.index] # <- |
  to_port   = var.allowed_ingress_ports_frontends[count.index] # <- | -> recoge en cada interación individualemente los puertos de la lista estableciendo un rango con su mismo puerto para asegurarse de que no se defina un rango más amplio.

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
```

Reglas de entrada para el **Backend**:

```
resource "aws_security_group_rule" "ingress_backend" {
  security_group_id = aws_security_group.Grupo_Backend.id
  type              = "ingress"

  count     = length(var.allowed_ingress_ports_backend)
  from_port = var.allowed_ingress_ports_backend[count.index]
  to_port   = var.allowed_ingress_ports_backend[count.index]

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
```
Reglas de entrada para el **NFS**:

```
resource "aws_security_group_rule" "ingress_NFS" {
  security_group_id = aws_security_group.Grupo_NFS.id
  type              = "ingress"

  count     = length(var.allowed_ingress_ports_NFS)
  from_port = var.allowed_ingress_ports_NFS[count.index]
  to_port   = var.allowed_ingress_ports_NFS[count.index]

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
```

Reglas de entrada para el **Balanceador**:

```
resource "aws_security_group_rule" "ingress_balanceador" {
  security_group_id = aws_security_group.Grupo_Balanceador.id
  type              = "ingress"

  count     = length(var.allowed_ingress_ports_Balanceador)
  from_port = var.allowed_ingress_ports_Balanceador[count.index]
  to_port   = var.allowed_ingress_ports_Balanceador[count.index]

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
```
Creación de las reglas de salida de los grupos de seguridad:

Creamos las reglas de salida del grupo de seguridad del **frontend**:

```
resource "aws_security_group_rule" "egress_frontend" {
  security_group_id = aws_security_group.Grupo_frontend.id

  type = "egress" # <- regla de tipo salida

  from_port   = 0    # <- |
  to_port     = 0    # <- | -> se permite la salida de todo el rango de puertos
  protocol    = "-1" # <- El valor -1 indica que esta regla se aplica a cualquier protocolo.
  cidr_blocks = ["0.0.0.0/0"]
}
```

Creamos las reglas de salida del grupo de seguridad del **backend**:

```
resource "aws_security_group_rule" "egress_backend" {
  security_group_id = aws_security_group.Grupo_Backend.id

  type = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
```

Creamos las reglas de salida del grupo de seguridad del **balanceador**:

```
resource "aws_security_group_rule" "egress_balanceador" {
  security_group_id = aws_security_group.Grupo_Balanceador.id

  type = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
```
Creamos las reglas de salida del grupo de seguridad del **NFS**:

```
resource "aws_security_group_rule" "egress_NFS" {
  security_group_id = aws_security_group.Grupo_NFS.id

  type = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
```
# Creación de las instancias [Frontends, Backend, NFS y Balanceador]:

resource "aws_instance" "instancia_del_Frontend01" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.Grupo_frontend.name]

  tags = {
    Name = var.instances_names[0]
  }
}

resource "aws_instance" "instancia_del_Frontend02" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.Grupo_frontend.name]

  tags = {
    Name = var.instances_names[1]
  }
}

resource "aws_instance" "instancia_del_Backend" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.Grupo_Backend.name]

  tags = {
    Name = var.instances_names[2]
  }
}

resource "aws_instance" "instancia_del_NFS" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.Grupo_NFS.name]

  tags = {
    Name = var.instances_names[3]
  }
}

resource "aws_instance" "instancia_del_Balanceador" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.Grupo_Balanceador.name]

  tags = {
    Name = var.instances_names[4]
  }
}
# Creación y asociación de la IP elástica a las instancias [Frontends, NFS y Balanceador]:

resource "aws_eip" "ip_elastica_f1" {
  instance = aws_instance.instancia_del_Frontend01.id
}

resource "aws_eip" "ip_elastica_f2" {
  instance = aws_instance.instancia_del_Frontend02.id
}

resource "aws_eip" "ip_elastica_NFS" {
  instance = aws_instance.instancia_del_NFS.id
}

resource "aws_eip" "ip_elastica_Bal" {
  instance = aws_instance.instancia_del_Balanceador.id
}
```
