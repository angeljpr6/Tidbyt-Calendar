# Applet: Calendario

## Resumen

Este applet muestra los próximos eventos en tu calendario de Google.

## Descripción

El applet de Calendario obtiene los eventos próximos de tu Calendario de Google y los muestra en la pantalla. Organiza los eventos por día y muestra el nombre del evento y la hora de inicio. Si no hay eventos próximos en las próximas 24 horas, muestra un mensaje indicando que tienes un día libre.

## Instalación

Para instalar y ejecutar este proyecto, sigue estos pasos:

1. Clona el repositorio en tu máquina local:

    ```bash
    git clone https://github.com/angeljpr6/CalendarApp.git
    ```

2. Navega al directorio del proyecto:

    ```bash
    cd CalendarApp
    ```

3. Asegúrate de tener Pixlet instalado. Puedes instalarlo siguiendo las instrucciones en [la página de Pixlet](https://pixlet.github.io/).

## Uso

Para usar el applet de Calendario, sigue estos pasos:

1. Abre tu terminal y navega al directorio del proyecto.

2. Ejecuta el script principal:

    ```bash
    pixlet serve calendar_app.star
    ```

3. Abre la URL que se muestra en tu terminal en un navegador web para ver el applet.

4. El applet mostrará los próximos eventos de tu calendario de Google.

## Estructura del Proyecto

El proyecto está organizado de la siguiente manera:

- `calendar_app.star`: Script principal que contiene la lógica del applet.
- `render.star`: Biblioteca para renderizar los elementos de la interfaz de usuario (UI).
- `http.star`: Biblioteca para realizar solicitudes HTTP.
- `encoding/base64.star`: Biblioteca para decodificar imágenes en base64.
- `time.star`: Biblioteca para gestionar operaciones relacionadas con el tiempo.
- `encoding/json.star`: Biblioteca para manejar datos en formato JSON.

## Contribuir

Si deseas contribuir a este proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature-nueva-caracteristica`).
3. Realiza los cambios necesarios y haz commit (`git commit -am 'Agrega nueva característica'`).
4. Sube los cambios a tu fork (`git push origin feature-nueva-caracteristica`).

## Contacto

Si tienes alguna pregunta, no dudes en contactar al autor:

GitHub: angeljpr6
