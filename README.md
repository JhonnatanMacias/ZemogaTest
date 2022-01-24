# ZemogaTest

Aplicación Mobile para iOS 13+ que muestra información de posts y su respectiva descripción

## Comenzando 🚀

_Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas._



### Pre-requisitos 📋

_MackBook_

```
MacBook con Xcode
```

### Instalación 🔧

_Descargar el proyecto de github_

```
Descargar el proyecto de github
Abrir la terminal con la ubicación del proyecto 
Los ultimos cambios estan en el brach _main_ o _develop_, ubicarse en cualquiera de ellos
y ejecutar el comando: pod install
Abrir el proyecto con Xcode y ejecutarlo.

```

### Funcionamiento 🔧

_Los datos vienen del servicio https://my-json-server.typicode.com/ y posteriormente son almacenados usando Realm_

```
Al iniciar el proyecto, se traen todos los post del servicio,
Se almacenan y se muestran en pantalla.

Al deslizar hacía la derecha se pueden borrar post, lo cual lo borrara de la memoria
y de la base de datos local(cache). también se puede abrir el post en detalle seleccionando
el post y marcandolo como favorito.

Al volver hacia la lista de posts, el indicador azul ya no sera mostrado para este post y un
icono de estralla se mostrará en su lugar.

Si cerramos la aplicacion y la abrimos nuevamente, el post eliminado ya no se mostrará, porque 
se cargan los post almacenados en cache, y se mostrará el icono de estrella para los post marcados
como favoritos, igualmente no mostrará el indicador de leido para los post ya abiertos.
 
 Al presionar el boton de "Delete All" se borraran todos los post, para mostrarlos nuevamente
 se puede presionar el boton de refresh para traer los post nuevamente del servicio.

 El botón de refresh siempre traerá los cambios del servicio y reemplazará los post almacenados
 en cache y sus cambios.

```

## Ejecutando las pruebas ⚙️

_Pruebas unitarias en la clase ZemogaTestTests, se hicieron prueba de simulacion de servicios_


## Construido con 🛠️

_Menciona las herramientas que utilizaste para crear tu proyecto_

* [Xcode] - IDE 
* [CocoaPods] - Manejador de dependencias: permite automatizar la búsqueda, descarga e integración de nuevas versiones
                 de librerías externas en el proyecto.
* [MVVM] - ViewModel es el componente principal de este patrón de arquitectura. ViewModel permite que la arquitectura 
         sea más comprobable y elimina la complejidad de la vista. Permite una mayor capacidad de prueba de los estados de vista.
         Permite un mejor mantenimiento de la vista compleja.
* [Binding] - MVVM Bindings: El enlace MVVM juega un papel vital en el proyecto. La forma en que se comunica entre el modelo de vista   y el controlador de de vital importancia.
* [Realm] - Usado para almacenar información en forma de cache: base de datos móvil orientada a objetos simple y rápida, muy intuitiva.
* [Alamofire] - usado para las peticiones a APIs: Las interacciones de las llamadas a la API (POST/GET/PUT/etc.) serán más fáciles y comprensibles. Alamofire simplifica una serie de tareas de red comunes que hacen que el desarrollo sea más rápido y fácil.

## Autores ✒️

_Jhonnatan Macias_

* **Jhonnatan Macias** - *Trabajo Inicial* - [jhonnatanmacias](https://github.com/JhonnatanMacias)

