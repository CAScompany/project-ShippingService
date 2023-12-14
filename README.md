Documentación del Proyecto Shipping Service

Este repositorio contiene los flujos de trabajo de GitHub Actions para el microservicio Shipping Service. El proyecto tiene como objetivo proporcionar un MS con procesos integrales de prueba, análisis e implementación.

Descripción General de los Flujos de Trabajo para Diferentes Ramas
Los flujos de trabajo implementados en los archivos workflow-prod.yml, workflow-stage.yml, y workflow-dev.yml están diseñados para gestionar distintos entornos del proyecto Shipping Service (producción, staging y desarrollo) utilizando GitHub Actions. Aunque se activan en ramas diferentes, comparten una estructura y lógica similares. Aquí hay una descripción general de lo que hacen en términos técnicos:

Estructura Común
Activación de Eventos:

Todos los flujos de trabajo se activan en eventos de push a la rama correspondiente (main, test, dev), repository_dispatch, y  workflow_dispatch.


Gestión de Concurrencia:

Se configura la concurrencia utilizando el bloque concurrency, asegurando que solo se ejecute una instancia del flujo de trabajo para un grupo de concurrencia específico. Además, se cancelan instancias en progreso si se inicia otra.
Trabajo Principal:

Cada flujo de trabajo utiliza el mismo trabajo principal (build-<branch>), donde <branch> corresponde a la rama específica (producción, staging o desarrollo).
Este trabajo utiliza el flujo de trabajo definido en shippingservice.yml@<branch> para el entorno correspondiente.
Configuración de Variables de Entorno y Secretos:


Análisis:

Checkout y Análisis de Código: Realiza la extracción del código desde el repositorio mediante el comando de checkout y lleva a cabo un análisis de código estático utilizando SonarQube.

Aseguramiento de la Calidad del Código: Verifica la calidad del código, asegurando el cumplimiento de estándares de codificación y señalando posibles áreas de mejora.

Pruebas Funcionales:
Checkout, Pruebas Unitarias y Arranque de la Aplicación: Extrae el código del repositorio, ejecuta pruebas unitarias y pone en marcha la aplicación para las pruebas funcionales.

Ejecución de Pruebas Funcionales con Newman: Utiliza Newman para ejecutar pruebas definidas en la colección de Postman, asegurando la funcionalidad correcta de la aplicación.

Generación de Informe HTML: Crea un informe detallado en formato HTML que resume los resultados de las pruebas realizadas.

Descripción de Archivos
Dockerfile:

Especifica el proceso de construcción de la imagen de Docker.
Utiliza Maven para construir la aplicación y OpenJDK para el tiempo de ejecución.

collection.json:

Contiene la definición de una colección de Postman para pruebas funcionales. El script de prueba en la colección valida el código de estado de las respuestas HTTP.


shippingservice.yml:

Este archivo representa el flujo de trabajo principal de GitHub Actions. Se compone de varios trabajos para realizar análisis estático, pruebas funcionales, creación de versiones y construcción/publicación de la imagen Docker.

BUILD_AND_PUBLISH

Construye la imagen Docker y la publica en Amazon ECR.

Invocación del Flujo de Trabajo:
Los flujos de trabajo se activan de manera versátil:

Automáticamente por Eventos de Envío al Repositorio: Se inician automáticamente en respuesta a eventos de envío de código al repositorio.
Automáticamente por push a Ramas Específicas: Se activan al detectar cambios en ramas particulares del repositorio.
Manualmente mediante Activadores Manuales: Pueden ser invocados manualmente a través de la interfaz de usuario de GitHub.