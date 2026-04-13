## Configuracion

Comandos iniciales para montar

```bash
# 1. Crear las carpetas localmente (si no existen)
mkdir -p www shadaai apps api

# 2. Si ya tenías código en algún lado, cópialo a las carpetas correspondientes
# Por ejemplo, si ya tenías proyectos en /www local:
# cp -r /ruta/original/* ./www/

# 3. Detener el contenedor actual
docker-compose down

# 4. Reconstruir la imagen
docker-compose build --no-cache

# 5. Levantar el contenedor
docker-compose up -d

# 6. Verificar que todo está correcto
docker exec -it php73 ls -la /var/www/
docker exec -it php73 apachectl configtest

# 7. Ver logs
docker-compose logs

```