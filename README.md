# Port Checker

Ejercicio de ciberseguridad para comprobar si un puerto TCP se encuentra abierto o cerrado.

El ejercicio contiene dos implementaciones:

* **Linux:** Shell Script ejecutado dentro de un contenedor Docker.
* **Windows:** PowerShell ejecutado directamente en Windows.

En ambos casos se realiza una conexión TCP hacia el puerto indicado y se determina si la conexión fue exitosa.

## Requisitos

### Para usuarios Windows

* Windows 11
* PowerShell
* Docker Desktop

No es necesario instalar herramientas adicionales.

### Para usuarios de Linux o MacOS

* Motor de Docker o Motor de Docker con Escritorio integrado (Docker Desktop)

No será posible ejecutar el PowerShell en este ambiente.


### Docker para ambos casos

Se asume que Docker ya está instalado y funcionando correctamente.

---

# 1. Estructura del proyecto

```text
port-checker/
│
├── Dockerfile
├── check-port.sh
├── check-port.ps1
└── README.md
```

---

# 2. Implementación Linux

El archivo `check-port.sh` contiene el Shell Script que comprueba el estado de un puerto TCP.

La imagen Docker utiliza Ubuntu y `netcat` para realizar la comprobación.

## Construir la imagen

Abrir PowerShell en el directorio del proyecto:

```powershell
docker build -t port-checker .
```

Esto construirá la imagen utilizando el `Dockerfile`.

## Ejecutar el contenedor

El script recibe dos argumentos:

```text
<host> <puerto>
```

Por ejemplo, para comprobar el puerto `8080` de Windows:

```powershell
docker run --rm port-checker host.docker.internal 8080
```

Si el puerto está abierto:

```text
Puerto 8080 en host.docker.internal: ABIERTO
```

Si el puerto está cerrado:

```text
Puerto 8080 en host.docker.internal: CERRADO
```

### ¿Por qué `host.docker.internal`?

El Shell Script se ejecuta dentro del contenedor.

Por lo tanto, `localhost` dentro del contenedor hace referencia al propio contenedor y no al sistema operativo Windows que ejecuta Docker.

Docker Desktop proporciona el nombre:

```text
host.docker.internal
```

para permitir que un contenedor acceda al host.

---

# 3. Implementación Windows

El archivo `check-port.ps1` contiene la implementación equivalente para Windows utilizando PowerShell.

PowerShell proporciona el comando:

```powershell
Test-NetConnection
```

para comprobar una conexión TCP.

## Ejecutar el script

Desde PowerShell, ubicarse en el directorio del proyecto:

```powershell
cd <ruta-del-proyecto>
```

Ejecutar:

```powershell
.\check-port.ps1 8080
```

Si el puerto está abierto:

```text
Puerto 8080 : ABIERTO
```

Si está cerrado:

```text
Puerto 8080 : CERRADO
```

---

# 4. Probar un puerto abierto

Para realizar una prueba, primero se puede iniciar un servidor HTTP temporal en Windows.

Por ejemplo, si Python está instalado:

```powershell
python -m http.server 8080
```

El servidor quedará escuchando en:

```text
localhost:8080
```

Mientras ese proceso esté ejecutándose, abrir otra ventana de PowerShell y ejecutar:

```powershell
.\check-port.ps1 8080
```

Debería mostrar:

```text
Puerto 8080 : ABIERTO
```

También se puede comprobar desde el contenedor:

```powershell
docker run --rm port-checker host.docker.internal 8080
```

Debería mostrar:

```text
Puerto 8080 en host.docker.internal: ABIERTO
```

---

# 5. Probar un puerto cerrado

Utilizar un puerto donde no haya ningún servicio escuchando.

Por ejemplo:

```powershell
.\check-port.ps1 54321
```

El resultado esperado es:

```text
Puerto 54321 : CERRADO
```

Y desde Docker:

```powershell
docker run --rm port-checker host.docker.internal 54321
```

Resultado:

```text
Puerto 54321 en host.docker.internal: CERRADO
```

---

# 6. Comandos utilizados

### Construir imagen

```powershell
docker build -t port-checker .
```

### Ejecutar comprobación desde Linux/Docker

```powershell
docker run --rm port-checker host.docker.internal <puerto>
```

### Ejecutar comprobación desde Windows

```powershell
.\check-port.ps1 <puerto>
```

### Ver contenedores

```powershell
docker ps
```

### Ver imágenes

```powershell
docker images
```

---

# 7. Limpieza

El contenedor utiliza `--rm`, por lo que se elimina automáticamente después de terminar.

Si se desea eliminar la imagen creada:

```powershell
docker rmi port-checker
```
