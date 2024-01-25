#--------------------------------------------------
# Configuración del proveedor de AWS:
#---------------------------------------------------
variable "Region" {
  description = "Región de AWS donde se creará la instancia"
  type        = string
  default     = "us-east-1"
}

variable "clave_acceso" {
  description = "aws_access_key_id"
  type        = string
  default     = "ASIAQJ32ZQSMKNVSLM2K"
}

variable "clave_secreta" {
  description = "aws_secret_access_key"
  type        = string
  default     = "ZNkxf9aqqDZu/62zLJqgNFV7gWVgHfFGIUVrKlGs"
}

variable "token" {
  description = "aws_session_token"
  type        = string
  default     = "FwoGZXIvYXdzEOj//////////wEaDG263aJGeRwPY2t5GSLKAeoUahVlZjuI1ufEQGQJzcLiXza6pEWsVtTAmtJJL8tp0m+RfDYi6B1+y1mK7DpFk7FrsQgEfejT3AeYa48rHcuWSD0lrii6GaiQq/pBpApZhjNiiEnh/ZBcGzkvvNl55NYaCND3CAYEE7yCow4dgTu3b1fuq5ovGE512XlhphY8OblCuV0cEP/DL87sUaj4KyThmwXD79ogBZRaHi8x+jp1A7xnjqWUBRLiQ3XyHi6lwOvgOJ4hj14T1dwBvVz2ISw5g2QRz9Sbn3so8uHJrQYyLQVYtX2tIl6xFkOhx6ockJm/JB0RzyepFEGG76bH/wqs8Vp2Op9PA77JKg4uIw=="
}
#-----------------------------------------------------------------
# Definición de variables de los grupos de seguridad:


# - Creación del grupo para los Frontales:

variable "Group_name_Frontends" {
  description = "Grupo para las instancias frontales"
  type        = string
  default     = "Grupo_frontend"
}

variable "Group_description_Frontends" {
  description = "Grupo para las instancias frontales"
  type        = string
  default     = "Grupo de seguridad para las instancias de los frontales"
}

# - Creación del grupo para el Backend:

variable "Group_name_Backend" {
  description = "Grupo para la instancia del Backend"
  type        = string
  default     = "Grupo_Backend"
}

variable "Group_description_Backend" {
  description = "Grupo para el Backend"
  type        = string
  default     = "Grupo de seguridad para la instancia del Backend"
}

# - Creación del grupo para el NFS:

variable "Group_name_NFS" {
  description = "Grupo para la instancia del NFS"
  type        = string
  default     = "Grupo_NFS"
}

variable "Group_description_NFS" {
  description = "Grupo para el NFS"
  type        = string
  default     = "Grupo de seguridad para la instancia del NFS"
}

# - Creación del grupo para el Balanceador:

variable "Group_name_Balanceador" {
  description = "Grupo para la instancia del Balanceador"
  type        = string
  default     = "Grupo_Balanceador"
}

variable "Group_description_Balanceador" {
  description = "Grupo para el Balanceador"
  type        = string
  default     = "Grupo de seguridad para la instancia del Balanceador"
}

#-------------------------------------------------------------------------------
# Definición de las reglas de entrada para los diferentes grupos:

# Creación de las reglas de entrada para los frontales:

variable "allowed_ingress_ports_frontends" {
  description = "Puertos de entrada del grupo de seguridad de los frontales"
  type        = list(number)
  default     = [22, 80]
}

# Creación de las reglas de entrada para el Backend:

variable "allowed_ingress_ports_backend" {
  description = "Puertos de entrada del grupo de seguridad del Backend"
  type        = list(number)
  default     = [22, 3306]
}

# Creación de las reglas de entrada para el NFS:

variable "allowed_ingress_ports_NFS" {
  description = "Puertos de entrada del grupo de seguridad del NFS"
  type        = list(number)
  default     = [22, 2049]
}

# Creación de las reglas de entrada para el Balanceador:

variable "allowed_ingress_ports_Balanceador" {
  description = "Puertos de entrada del grupo de seguridad del Balanceador"
  type        = list(number)
  default     = [22, 80, 443]
}
#-----------------------------------------------------------------------------
# Definición de las variables para el despliegue de las instancias:

variable "ami_id" {
  description = "Identificador de la AMI"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.small"
}

variable "key_name" {
  description = "Nombre de la clave pública"
  type        = string
  default     = "vockey"
}

variable "instances_names" {
  description = "Nombre de las instancias"
  type        = list(string)
  default     = ["Frontend_01", "Frontend_02", "Backend", "NFS", "Balanceador"]
}

