# Inception

## Objetivos del Proyecto

1.   Utilizar Docker y Docker Compose: Crear y gestionar contenedores con servicios interdependientes.
    
2.   Seguridad y buenas prácticas: Configurar usuarios, permisos y restricciones adecuadas en los contenedores.
    
3.   Orquestación de servicios: Usar Docker Compose para definir y ejecutar múltiples contenedores.
  
4.   Almacenamiento persistente: Usar volúmenes para preservar datos incluso después de detener los contenedores.

## 🚀 Servicios a Implementar

Se desplegarán los siguientes servicios dentro de contenedores:

**Nginx**:
        Actúa como servidor proxy inverso.
        Maneja las conexiones HTTPS con un certificado SSL.
        Redirige las peticiones a WordPress.

**WordPress**:
        CMS que se conecta con MariaDB.
        Instalado sobre PHP-FPM para un rendimiento óptimo.

**MariaDB**:
        Base de datos para almacenar la información de WordPress.
        Se configura con usuario, contraseña y permisos adecuados.

```
    +------------------+
    |     Cliente      |
    |   (Navegador)    |
    +--------+---------+
             |
            | HTTP/HTTPS
            |
    +--------v---------+
    |      Nginx       |
    | (Servidor web)   |
    +--------+---------+
            |
            | Proxy inverso
            |
    +--------v---------+
    |    WordPress     |
    | (Aplicación PHP) |
    +--------+---------+
            |
            | Consultas SQL
            |
    +--------v---------+
    |     MariaDB      |
    | (Base de datos)  |
    +------------------+
```

# Estructura
```
├── Makefile
├── README.md
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── conf
        │   │   └── server_conf.cnf
        │   ├── Dockerfile
        │   └── tools
        │       └── setup.sh
        ├── nginx
        │   ├── conf
        │   │   ├── nginx.conf
        │   │   └── server.conf
        │   └── Dockerfile
        └── wordpress
            ├── conf
            │   ├── wp-config.php
            │   └── www.conf
            ├── Dockerfile
            └── tools
                └── setup.sh

```