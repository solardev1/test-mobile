
# Proyecto


Prueba Técnica para Desarrollador Mobile - Flutter

Objetivo: Evaluar las habilidades del candidato en el desarrollo de aplicaciones móviles con Flutter.


## Requisitos

* Experiencia trabajando con Flutter, Dart
* Capacidad de análisis y resolución de problemas
* Habilidad para trabajar de forma autónoma y en equipo



## Descripción de la prueba

Desarrollar una aplicación móvil simple para gestionar una lista de tareas. La aplicación debe permitir a los usuarios agregar, editar y eliminar las tareas, así como poder visualizarlas en un listado/grilla. Además, las tareas deben poder ser categorizadas por su prioridad (alta, media, baja).
## Funcionalidades

* Lista de Tareas: Obtener listado de tareas base desde: https://65f43f68f54db27bc02120e0.mockapi.io/api/v1/task y almacenarlas localmente, puede utilizar "shared_preferences" 
* Mostrar todas las tareas agregadas, con la opción de poder editarlas y/o eliminarlas.
* Agregar Tarea: Permitir al usuario agregar nuevas tareas a la lista. Cada tarea debe incluir un título, una descripción, una prioridad y id autogenerado.
* Editar Tarea: Permitir al usuario editar una tarea seleccionada.
* Eliminar Tarea: Permitir al usuario eliminar una tarea de la lista.
* Filtrar por Prioridad: Permitir al usuario filtrar las tareas por su prioridad (alta, media, baja).
## Requisito Técnicos

* Implementar un manejo de estado eficiente para gestionar los datos de la app (Stateful / Stateless Widgets, Provider, Bloc, etc.).
* Utilizar el sistema de navegación de Flutter para moverse entre pantallas.
* Conceptos de programación asincrónica en Dart (Future, async, await).
* Conocimiento y aplicación en el uso de streams en Dart/Flutter. No excluyente.
* La aplicación debe ser responsiva y funcionar correctamente en dispositivos móviles.
* Debe tener al menos 2 pantallas / actividades, 1 para el listado y la 2 para las funciones de registro/edición.
## Entregables

* Código fuente de la aplicación.
* Instrucciones claras sobre cómo ejecutar la aplicación localmente.
## Evaluación

La prueba se evaluará en base a los siguientes criterios:

* Funcionalidad: ¿La aplicación cumple con todos los requisitos funcionales especificados?
* Calidad del Código: ¿El código está bien estructurado, limpio y sigue las mejores prácticas de desarrollo?
* Diseño y Usabilidad: ¿La interfaz de usuario es intuitiva y fácil de usar? ¿El diseño es atractivo y responsive?
* Pruebas Unitarias: ¿Se han implementado pruebas unitarias para garantizar la calidad del código? No Excluyente
* Documentación: ¿Se proporciona una documentación clara y concisa sobre cómo ejecutar la aplicación y las decisiones de diseño? No Excluyente
## Tiempo estimado

* 8 horas
## Instrucciones de carga

* Crear un fork del proyecto, registrarlo como "dev" seguido de los 3 últimos números de su CI. Ejemplo: "dev123"
* Crear una rama feature a partir del main, con la misma metodología indicada arriba. Ejemplo: "feature/dev123"
* Solicitar el PR

