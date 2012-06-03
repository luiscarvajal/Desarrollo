### Bienvenidos al Sistema XpresatE.
XpresatE es una plataforma orientada a servicios que utiliza un modelo de base de datos no relacional (NoSQL,) denominado [Mongo DB](http://www.mongodb.org/)y desarrollada bajo el ambiente del framework  [Ruby on Rails](http://rubyonrails.org/). Esta plataforma permite la gestión (envío y recepción) de mensajes con contenido multimedia, al igual que el uso de plataformas o clientes desarrollados por terceros para evaluar el correcto funcionamiento de los servicios implementados.

Es importante destacar que la plataforma cuenta los siguientes requerimientos funcionales:
* **Autorización de operaciones:** permite realizar las operaciones de modificación, eliminación o creación de nuevos registros mediante las reglas de negocio implementadas y la generación de Tokens de seguridad, los cuales deben ser generados por dos elementos: usuario y clave de acceso.

* **Publicación de Comentarios:** facilita a los usuarios registrados la capacidad de poder publicar mensajes o comentarios de longitud indefinida. Dichos comentarios pueden estar identificados por un tag para identificar dichos mensajes por un tópico en especifico. Estos comentarios pueden adjuntar información multimedia o de cualquier otro formato. A su vez facilita a los usuarios dar respuestas sobre otros comentarios e indicar si le gusta o no y poder totalizar esos votos. El usuario puede indicar si el comentario que genera puede o no tener respuestas. Es importante destacar que ciertas operaciones realizadas a los comentarios, requieren la generación de tonkens de seguridad para poder ser ejecutada.

A continuación se detallan los pasos que usted debe seguir:

### 1- Instalar Ruby on Rails
* Descargue la versión de Ruby 1.9.3-p0 y el DevKit-tdm-32-4.5.2-20110712-1620-sfx.exe, ubicados en el siguiente link [Descar Ruby on Rails](http://rubyinstaller.org/downloads/archives, en la imagen se indica que archivos descargarse. Ejecute primero el instalador de Ruby luego el de DevKit.

![Descargar Ruby y DevKit](C:\Users\LILIANA>C:\Users\LILIANA\Desktop\ultimo servidor desarrollo\Desarrollo\ my_app\my_app\DescargarRuby.png) 

* Terminada la instalación abrimos la linea de comandos de Ruby  (Start Command Prompt with Ruby)
```gem update --system```






### Metodos Disponibles en la aplicacion:

##Users
#Listar: GET > `/Users.xml`
Retorna todos los usuarios registrados en el sistema.
Ejemplo de xml de respond:
```
<users type="array">
   <user>
      <apellido>Carvajal</apellido>
      <biografia>biografia</biografia>
      <correo>lcarvajal@gmail.com</correo>
      <foto>.</foto>
      <id>4fcac0aaca2f25210c00009c</id>
      <nick-name>123</nick-name>
      <nombre>Luis</nombre>
      <pais>vzla</pais>
      <password>123</password>
   </user>
   <user>
      <apellido>Sanchez</apellido>
      <biografia>biografia</biografia>
      <correo>asanchez@gmail.com</correo>
      <foto>.</foto>
      <id>4fcac0bdca2f25210c00009e</id>
      <nick-name>1234</nick-name>
      <nombre>Andres</nombre>
      <pais>vzla</pais>
      <password>123</password>         
   </user>
</users>
```

#Crear: POST > `/Users`
Registra un usuario nuevo en el sistema.

Ejemplo de xml request:
```
<user>
<nombre>Luis</nombre>
<apellido>Carvajal</apellido>
<nick-name>lcarvajal</nick-name>
<password>123</password>
<biografia>biografia</biografia>
<correo>lcarvajal@gmail.com</correo>
<pais>vzla</pais>
<foto></foto>
</user>
```
Ejemplo de xml de respond:
```
<user>
	<apellido>Carvajal</apellido>
	<biografia>biografia</biografia>
	<correo>lcarvajal@gmail.com</correo>
	<id>4fcac0bdca2f25210c00009e</id>
	<nick-name>lcarvajal</nick-name>
	<nombre>Luis</nombre>
	<pais>vzla</pais>
	<password>123</password>
	<foto></foto>
	<tokens type="array"/>
</user>
```

#Update: PUT > `/Users/:id_usuario`
Se modifica un usuario existente en el sistema
Ejemplo de xml request:
```
<user>
	<nombre>Luis</nombre>
	<apellido>Carvajal</apellido>
	<nick-name>lcarvajal</nick-name>
	<password>123</password>
	<biografia>biografia</biografia>
	<correo>lcarvajal@gmail.com</correo>
	<pais>vzla</pais>
	<foto></foto>
</user>
```
Ejemplo de xml respond:
```
<user>
   <apellido>Apellido Modificado</apellido>
   <biografia>biografia modificada</biografia>
   <correo>nmodificado@gmail.com</correo>
   <foto>.</foto>
   <id>4fcac0bdca2f25210c00009e</id>
   <nick-name>lcarvajal</nick-name>
   <nombre>Nombre Modificado</nombre>
   <pais>vzla</pais>
   <password>123</password>
</user>
```

#Delete: DELETE > `/Users/:id_usuario`
permite eliminar el usuario cuyo id corresponda con 
el :id_usuario pasado como parametro
Ejemplo de xml de respond
```
<mensaje>
   <id>4fcb6be5ca2f251c0c000ddc</id>
   <salida>Usuario Eliminado con exito</salida>
</mensaje>
```

#Show: GET > `/Users/:id_usuario.xml`
permite ver todos los detalles de el usuario con el id pasado como parametro
Ejemplo de xml de respond
```
<user>
   <apellido>Carvajal</apellido>
   <biografia>biografia</biografia>
   <correo>asanchez@gmail.com</correo>
   <foto>.</foto>
   <id>4fcb6beaca2f251c0c000dde</id>
   <nick-name>123</nick-name>
   <nombre>Luis</nombre>
   <pais>vzla</pais>
   <password>123</password>
</user>
```

#Login: POST > `/Users/login`
permite iniciar sesion en el sistema, recibe un objeto con el nick_name y el password
retorna un usuario con los tokens asociados a ese usuario
Ejemplo de request
```
<session>
	<nick_name>123</nick_name>
	<password>123</password>
</session>
```
Ejemplo de respond
```
<user>
   <apellido>Carvajal</apellido>
   <biografia>biografia</biografia>
   <correo>asanchez@gmail.com</correo>
   <foto>.</foto>
   <id>4fcb6beaca2f251c0c000dde</id>
   <nick-name>123</nick-name>
   <nombre>Luis</nombre>
   <pais>vzla</pais>
   <password>123</password>
   <tokens type="array">
      <token>
        <hora-ini>2012-06-03 09:36:05 -0430</hora-ini>
        <id>4fcb6f4dca2f251c0c000e8c</id>
        <ip>192.168.1.116</ip>
        <mensaje>El token solicitado es:4fcb6f4dca2f251c0c000e8c</mensaje>
        <status>activo</status>
      </token>
      <token>
        <hora-ini>2012-06-03 09:40:17 -0430</hora-ini>
        <id>4fcb7049ca2f251c0c000ec3</id>
        <ip>127.0.0.1</ip>
        <mensaje>El token solicitado es:4fcb7049ca2f251c0c000ec3</mensaje>
        <status>activo</status>
      </token>
   </tokens>
</user>
```

##Comentarios
#Listar: GET > `/Users/:user_id/comentarios.xml`
permite listar todos los comentarios asociados al usuario pasado como parametro
Ejemplo de Respond:
```
<comentarios type="array">
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 09:33:09 -0430</hora-publicacion>
      <id>4fcb6e9dca2f251c0c000e6f</id>
      <mensaje>esto es el primer comentario Usuario: nombre</mensaje>
      <tag-ids type="array"/>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </comentario>
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 09:36:55 -0430</hora-publicacion>
      <id>4fcb6f72083611020c000f38</id>
      <mensaje>hola  &amp;nbsp;&lt;a href="http://www.youtube.com/watch?v=kffacxfA7G4">http://www.youtube.com/watch?v=kffacxfA7G4&lt;/a>&amp;nbsp;&lt;br></mensaje>
      <tag-ids type="array"/>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </comentario>
</comentarios>
```
Si el atributo admite-respuesta es true el comentario admite respuesta de lo contrario no esta permitido

#Crear: POST > `/Users/:user_id/comentarios`
permite crear un comentario asociado al usuario indicado por el parametro :user_id
Ejemplo de request:
```
<comentario>
   <admite_respuesta>true</admite_respuesta>
   <mensaje>esto es el primer comentario Usuario: nombre</mensaje>
</comentario>
```
Ejemplo de respond:
```
<comentario>
   <admite-respuesta type="boolean">true</admite-respuesta>
   <comentario-id nil="true"/>
   <hora-publicacion>2012-06-03 09:33:09 -0430</hora-publicacion>
   <id>4fcb6e9dca2f251c0c000e6f</id>
   <mensaje>esto es el primer comentario Usuario: nombre</mensaje>
   <tag-ids type="array"/>
   <user-id>4fcb6beaca2f251c0c000dde</user-id>
</comentario>
```

#Modificar: PUT > `/Users/:user_id/comentarios/:comentario_id`
Permite modificar el comentarios dado por el parametro :comentario_id 
perteneciente al usuario :user_id
Ejemplo de request:
```
<comentario>
   <mensaje>esto es el primer comentario modificado Usuario: nombre</mensaje>
</comentario>
```
Ejemplo de respond:
```
<comentario>
   <admite-respuesta type="boolean">true</admite-respuesta>
   <comentario-id nil="true"/>
   <hora-publicacion>2012-06-02 21:13:06 -0430</hora-publicacion>
   <id>4fcac12aca2f25210c0000b2</id>
   <mensaje>esto es el sexto comentario Usuario: nombre</mensaje>
   <tag-ids type="array"/>
   <user-id>4fcac0aaca2f25210c00009c</user-id>
</comentario>
```

#Eliminar: DELETE > `/users/:user_id/comentarios/:comentario_id`
Permite eliminar un comentario junto con todas las respuestas a ese comentario
Ejemplo de respond:
```
<mensaje>
   <id>4fcad95bca2f251c0c0004eb</id>
   <salida>Comentario Eliminado con exito</salida>
</mensaje>
```

#Show: GET > `/users/:user_id/comentarios/:comentario_id.xml`
Muestra toda la informacion de el comentario dado
Ejemplo de respond:
```
<comentario>
   <admite-respuesta type="boolean">true</admite-respuesta>
   <comentario-id nil="true"/>
   <hora-publicacion>2012-06-03 09:33:09 -0430</hora-publicacion>
   <id>4fcb6e9dca2f251c0c000e6f</id>
   <me-gusta>0</me-gusta>
   <mensaje>esto es el primer comentario Usuario: nombre</mensaje>
   <no-me-gusta>0</no-me-gusta>
   <tag-ids type="array"/>
   <user-id>4fcb6beaca2f251c0c000dde</user-id>
</comentario>
```

#Comentarios Hijos: GET > `/comentarios/:comentario_id/get_comentarios_hijos`
Muestra todas las respuestas del comentario pasado en el parametro :comentario_id
Ejemplo de respond:
```
<comentarios type="array">
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id>4fcb6e9dca2f251c0c000e6f</comentario-id>
      <hora-publicacion>2012-06-03 10:14:45 -0430</hora-publicacion>
      <id>4fcb785dca2f251c0c000fde</id>
      <mensaje>respuesta de respuesta de un comentario</mensaje>
      <tag-ids type="array"/>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </comentario>
</comentarios>
```

#Todos los Comentarios: GET > `/comentarios/view`
Muestra todos los comentarios hechos en el sistema
Ejemplo de respond:
```
<comentarios type="array">
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 09:36:55 -0430</hora-publicacion>
      <id>4fcb6f72083611020c000f38</id>
      <mensaje>hola  &amp;nbsp;&lt;a href="http://www.youtube.com/watch?v=kffacxfA7G4">http://www.youtube.com/watch?v=kffacxfA7G4&lt;/a>&amp;nbsp;&lt;br></mensaje>
      <tag-ids type="array"/>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </comentario>
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 09:33:09 -0430</hora-publicacion>
      <id>4fcb6e9dca2f251c0c000e6f</id>
      <me-gusta>0</me-gusta>
      <mensaje>esto es el primer comentario Usuario: nombre</mensaje>
      <no-me-gusta>0</no-me-gusta>
      <tag-ids type="array"/>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </comentario>
</comentarios>
```

#Respuesta de un Comentario: POST > `/users/:user_id/comentarios/:comentario_id/respuesta`
permite responder un comentario 
Ejemplo de request:
```
<comentario>
   <mensaje>respuesta de respuesta de un comentario</mensaje>
</comentario>
```
Ejemplo de respond:
```
<comentario>
   <admite-respuesta type="boolean">true</admite-respuesta>
   <comentario-id nil="true"/>
   <hora-publicacion>2012-06-03 09:33:09 -0430</hora-publicacion>
   <id>4fcb6e9dca2f251c0c000e6f</id>
   <me-gusta>0</me-gusta>
   <mensaje>esto es el primer comentario Usuario: nombre</mensaje>
   <no-me-gusta>0</no-me-gusta>
   <tag-ids type="array"/>
   <user-id>4fcb6beaca2f251c0c000dde</user-id>
</comentario>
```

##Puntuaciones
#lista todas las puntuaciones hechas en el sistema: GET > `/puntuaciones/lista_puntuaciones`
permite listar todas las puntuaciones hechas sobres los comentarios en el sistema
Ejemplo de respond:
```
<puntuaciones type="array">
   <puntuacione>
      <comentario-id>4fcb6f72083611020c000f38</comentario-id>
      <id>4fcb7c2eca2f251c0c001096</id>
      <no-me-gusta type="integer">1</no-me-gusta>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </puntuacione>
</puntuaciones>
```

#Nueva Puntuacion: POST > `/users/:user_id/comentarios/:comentario_id/puntuaciones`
permite crear una puntuacion nueva sobre un comentario
Ejemplo de request (para el caso de no-me-gusta):
```
<puntuacione>
   <no-me-gusta type="integer">1</no-me-gusta>
</puntuacione>
```
Ejemplo de request (para el caso de me-gusta):
```
<puntuacione>
   <me-gusta type="integer">1</me-gusta>
</puntuacione>
```

#Eliminar una puntuacion: DELETE > `/users/:user_id/comentarios/:comentario_id/puntuaciones/:puntuacion_id`
permite eliminar una puntuacion sobre un comentario
Ejemplo de respond:
```
<puntuacione>
   <comentario-id>4fcb6f72083611020c000f38</comentario-id>
   <id>4fcb7cb4ca2f251c0c0010b8</id>
   <no-me-gusta type="integer">1</no-me-gusta>
   <user-id>4fcb6bf8ca2f251c0c000de0</user-id>
</puntuacione>
```

#listar puntuaciones sobre un comentario: GET > `/users/:user_is/comentarios/:comentario_id/puntuaciones`
permite listar las puntuaciones hechas sobre un comentario
Ejemplo de respond:
```
<puntuaciones type="array">
   <puntuacione>
      <comentario-id>4fcb6f72083611020c000f38</comentario-id>
      <id>4fcb7c2eca2f251c0c001096</id>
      <no-me-gusta type="integer">1</no-me-gusta>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </puntuacione>
</puntuaciones>
```

##Tags
#listar Tags: GET > `/users/:user_id/comentarios/:comentario_id/tags`
permite listar los tags asociados a un comentario
Ejemplo de respond
```
<tags type="array">
   <tag>
      <comentario-ids type="array">
         <comentario-id>4fcb6f72083611020c000f38</comentario-id>
      </comentario-ids>
      <id>4fcb81ffca2f251c0c001125</id>
      <nombre>carros</nombre>
   </tag>
</tags>
```

#Nuevo tag: POST > `/users/:user_id/comentarios/:comentario_id/tags/`
permite crear un tag y asociarselo a un comentario
Ejemplo de request:
```
<tag>
   <nombre>carros</nombre>
</tag>
```
Ejemplo de respond:
```
<objects type="array">
   <object>
      <apellido>Carvajal</apellido>
      <biografia>biografia</biografia>
      <correo>asanchez@gmail.com</correo>
      <foto>.</foto>
      <id>4fcb6beaca2f251c0c000dde</id>
      <nick-name>123</nick-name>
      <nombre>Luis</nombre>
      <pais>vzla</pais>
      <password>123</password>
      <tokens type="array">
         <token>
            <hora-ini>2012-06-03 09:36:05 -0430</hora-ini>
            <id>4fcb6f4dca2f251c0c000e8c</id>
            <ip>192.168.1.116</ip>
            <mensaje>El token solicitado es:4fcb6f4dca2f251c0c000e8c</mensaje>
            <status>activo</status>
         </token>
         <token>
            <hora-ini>2012-06-03 10:41:35 -0430</hora-ini>
            <id>4fcb7ea7ca2f251c0c001118</id>
            <ip>127.0.0.1</ip>
            <mensaje>El token solicitado es:4fcb7ea7ca2f251c0c001118</mensaje>
            <status>activo</status>
         </token>
      </tokens>
   </object>
   <object>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 09:36:55 -0430</hora-publicacion>
      <id>4fcb6f72083611020c000f38</id>
      <mensaje>hola  &amp;nbsp;&lt;a href="http://www.youtube.com/watch?v=kffacxfA7G4">http://www.youtube.com/watch?v=kffacxfA7G4&lt;/a>&amp;nbsp;&lt;br></mensaje>
      <tag-ids type="array">
         <tag-id>4fcb81ffca2f251c0c001125</tag-id>
      </tag-ids>
      <user-id>4fcb6beaca2f251c0c000dde</user-id>
   </object>
   <object>
      <comentario-ids type="array">
         <comentario-id>4fcb6f72083611020c000f38</comentario-id>
      </comentario-ids>
      <id>4fcb81ffca2f251c0c001125</id>
      <nombre>carros</nombre>
   </object>
</objects>
```

### Manejo de errores:
En el caso de presentarse un error durante el flujo del proceso el servidor retornara un 
mensaje en formate xml.
Ejemplo de Mensaje de error:
```
<mensaje>
   <id>4fcb8395ca2f251c0c00112d</id>
   <salida>No hay token Vigente</salida>
</mensaje>
```