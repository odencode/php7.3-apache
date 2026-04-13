#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

case "$1" in
  "init")
    # Crear nuevo proyecto CI3
    if [ -z "$2" ]; then
      echo -e "${RED}Especifica nombre del proyecto${NC}"
      exit 1
    fi
    echo -e "${GREEN}Creando proyecto CI3: $2${NC}"
    docker-compose exec codeigniter3 bash -c "composer create-project codeigniter/framework /var/www/html/$2"
    ;;
  "composer")
    if [ -z "$2" ]; then
      echo -e "${RED}Especifica proyecto${NC}"
      exit 1
    fi
    docker-compose exec codeigniter3 bash -c "cd /var/www/html/$2 && composer ${@:3}"
    ;;
  "shell")
    docker-compose exec codeigniter3 bash
    ;;
  "list")
    echo -e "${GREEN}Proyectos disponibles:${NC}"
    docker-compose exec codeigniter3 bash -c "ls -la /var/www/html/"
    ;;
  "logs")
    docker-compose logs -f
    ;;
  "restart")
    docker-compose restart
    ;;
  "down")
    docker-compose down
    ;;
  *)
    echo "Uso: $0 {init|composer|shell|list|logs|restart|down}"
    echo ""
    echo "  init <nombre>     - Crear nuevo proyecto CI3"
    echo "  composer <proy>   - Ejecutar composer en proyecto"
    echo "  shell             - Entrar al contenedor"
    echo "  list              - Listar proyectos"
    echo "  logs              - Ver logs"
    echo "  restart           - Reiniciar servicio"
    echo "  down              - Detener servicio"
    ;;
esac