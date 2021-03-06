### Bienvenidos al Sistema XpresatE.
XpresatE es una plataforma orientada a servicios que utiliza un modelo de base de datos no relacional (NoSQL,) denominado [Mongo DB](http://www.mongodb.org/)y desarrollada bajo el ambiente del framework  [Ruby on Rails](http://rubyonrails.org/). Esta plataforma permite la gesti�n (env�o y recepci�n) de mensajes con contenido multimedia, al igual que el uso de plataformas o clientes desarrollados por terceros para evaluar el correcto funcionamiento de los servicios implementados.

Es importante destacar que la plataforma cuenta los siguientes requerimientos funcionales:
* **Autorizaci�n de operaciones:** permite realizar las operaciones de modificaci�n, eliminaci�n o creaci�n de nuevos registros mediante las reglas de negocio implementadas y la generaci�n de Tokens de seguridad, los cuales deben ser generados por dos elementos: usuario y clave de acceso.

* **Publicaci�n de Comentarios:** facilita a los usuarios registrados la capacidad de poder publicar mensajes o comentarios de longitud indefinida. Dichos comentarios pueden estar identificados por un tag para identificar dichos mensajes por un t�pico en especifico. Estos comentarios pueden adjuntar informaci�n multimedia o de cualquier otro formato. A su vez facilita a los usuarios dar respuestas sobre otros comentarios e indicar si le gusta o no y poder totalizar esos votos. El usuario puede indicar si el comentario que genera puede o no tener respuestas. Es importante destacar que ciertas operaciones realizadas a los comentarios, requieren la generaci�n de tonkens de seguridad para poder ser ejecutada.

A continuaci�n se detallan los pasos que usted debe seguir:

### 1- Instalar Ruby on Rails
* Descargue la versi�n de Ruby 1.9.3-p0 y el DevKit-tdm-32-4.5.2-20110712-1620-sfx.exe, ubicados en el siguiente link [Descar Ruby on Rails](http://rubyinstaller.org/downloads/archives, en la imagen se indica que archivos descargarse. Ejecute primero el instalador de Ruby luego el de DevKit.
* Terminada la instalaci�n abrimos la linea de comandos de Ruby  (Start Command Prompt with Ruby)
`gem update --system`

* Una vez instalado el Ruby y con ayuda del RubyGems, podemos proceder a instalar el Framework Rails que se trata de una �gema�, nuevamente en la l�nea de comandos escribimos: `gem install rails`

* Cree su primera aplicaci�n de la siguiente forma
``````
rails new demo
cd demo
rails generate scaffold persona nombre:string tlf:integer
rake db:create
rake db:migrate
rails server
``````
### 2- Instalar Mongo DB
* Descargar la version2.0.5 de Mongo DB en siguiente link [Descargar Mongo DB](http://www.mongodb.org/downloads) y de acuerdo al sistema operativo que posea su equipo.

* Para instalar Mongo DB en Ruby on Rails siga los pasos del siguiente link: [Mongo DB en Ruby](http://www.mongodb.org/display/DOCS/Ruby+Language+Center).

* Se facilita este sencillo manual sobre los comandos b�sicos utilizados en Mongo DB para la generaci�n o creaci�n de las bases de datos. [Usos b�sicos Mongo DB](http://blog.jam.net.ve/2011/01/09/usos-basicos-de-mongodb-console/)  


```
git@github.com:luiscarvajal/Desarrollo.git
```

#METODOS

##Users
###GET > `/users.xml`
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

###POST > `/users.xml`
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
   <tokens type="array"/>
</user>
```

###POST > `/users/login.xml`
Permite a los usuarios ingresar a la plataforma de servicios y hacer uso de las herramientas.

Ejemplo de xml request:
````
<session>
	<nick_name>lili1</nick_name>
	<password>12345</password>
</session>
````

Ejemplo de xml de respond:
````
<user>
   <apellido>chacon</apellido>
   <biografia/>
   <correo>lili1@gmail.com</correo>
   <id>4fc4fe3a438bbd0a48000003</id>
   <nick-name>lili1</nick-name>
   <nombre>liliana</nombre>
   <pais>Venezuela</pais>
   <password>12345</password>
   <tokens type="array">
      <token>
         <hora-ini>2012-06-03 08:40:09 -0430</hora-ini>
         <id>4fcb6231438bbd12a000000f</id>
         <ip>127.0.0.1</ip>
         <mensaje>El token solicitado es:4fcb6231438bbd12a000000f</mensaje>
         <status>activo</status>
      </token>
   </tokens>
</user>
/users
````

###PUT > `/users/{user_id}.xml`
Permite modificar los datos del usuario especifico. Se debe pasar el user_id como par�metro.
Ejemplo de xml request:
````
<user>
<nombre>LILIANA</nombre>
<apellido>MOLINA</apellido>
<nick-name>12345</nick-name>
<password>12345</password>
<biografia>biografia</biografia>
<correo>lili1@gmail.com</correo>
<pais>vzla</pais>
````

Ejemplo de xml respond:
````
<user>
   <apellido>MOLINA</apellido>
   <biografia>biografia</biografia>
   <correo>lili1@gmail.com</correo>
   <id>4fc4fe3a438bbd0a48000003</id>
   <nick-name>12345</nick-name>
   <nombre>LILIANA</nombre>
   <pais>vzla</pais>
   <password>12345</password>
   <tokens type="array">
      <token>
         <hora-ini>2012-06-03 10:18:58 -0430</hora-ini>
         <id>4fcb795a438bbd12a000006a</id>
         <ip>127.0.0.1</ip>
         <mensaje>El token solicitado es:4fcb795a438bbd12a000006a</mensaje>
         <status>activo</status>
      </token>
   </tokens>
</user>
````

###DELETE > `/users/{user_id}.xml`
Permite eliminar a un determinado usuario. Se debe pasar el user_id como par�metro.

Ejemplo de xml respond:
````
<mensaje>
   <id>4fcb7a38438bbd12a0000084</id>
   <salida>Usuario Eliminado con exito</salida>
</mensaje>
````

###GET > `/users/{user_id}.xml`
Permite buscar y ver un usurio espec�fico. Se debe pasar por par�metro el user_id
Ejemplo de xml respond:
````
<user>
   <apellido></apellido>
   <biografia>biografia</biografia>
   <correo>oma@gmail.com</correo>
   <id>4fcada75438bbd0f94000011</id>
   <nick-name>oma</nick-name>
   <nombre>Omaira</nombre>
   <pais>vzla</pais>
   <password>12345</password>
   <tokens type="array"/>
</user>
````

##Comentarios
###GET > `users/{user_id}/comentarios.xml`
Permite listar todos los comentarios existentes que tiene un usuario en espec�fico, se debe pasar por parametro el user_id.

Ejemplo de xml respond:
````
<comentarios type="array">
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-02 23:07:50 -0430</hora-publicacion>
      <id>4fcadc0e438bbd0f9400002c</id>
      <mensaje>esto es el primer comentario Usuario: lili1, estoy probando</mensaje>
      <tag-ids type="array"/>
      <user-id>4fc4fe3a438bbd0a48000003</user-id>
   </comentario>
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 09:45:54 -0430</hora-publicacion>
      <id>4fcb719a438bbd12a0000036</id>
      <mensaje>Mi segundo comentario, probando</mensaje>
      <tag-ids type="array"/>
      <user-id>4fc4fe3a438bbd0a48000003</user-id>
   </comentario>
</comentarios>
````

###POST > `users/{user_id}/comentarios.xml`
Permite a un usuario especifico crear los comentarios que desee. Se debe pasar por parametro el user_id de ese usuario.

Ejemplo de xml request:
````
<comentario>
<admite_respuesta>true</admite_respuesta>
<mensaje>Mi segundo comentario, probando</mensaje>
</comentario>
````

Ejemplo de xml respond:
````
<comentario>
   <admite-respuesta type="boolean">true</admite-respuesta>
   <comentario-id nil="true"/>
   <hora-publicacion>2012-06-03 09:45:54 -0430</hora-publicacion>
   <id>4fcb719a438bbd12a0000036</id>
   <mensaje>Mi segundo comentario, probando</mensaje>
   <tag-ids type="array"/>
   <user-id>4fc4fe3a438bbd0a48000003</user-id>
</comentario>
````

###PUT > `/users/{id_usuario}/comentarios/{id_comentario}.xml`
Permite a un usuario comentar sus propios comentarios. Se debe pasar por par�metro el id_usuario y el id_del comentario

Ejemplo de xml request:
````
<comentario>
<mensaje>comentario modificado hoy</mensaje>
</comentario>
````

Ejemplo de xml respond:
````
<comentario>
   <admite-respuesta type="boolean">true</admite-respuesta>
   <comentario-id nil="true"/>
   <hora-publicacion>2012-06-03 09:45:54 -0430</hora-publicacion>
   <id>4fcb719a438bbd12a0000036</id>
   <mensaje>comentario modificado hoy</mensaje>
   <tag-ids type="array"/>
   <user-id>4fc4fe3a438bbd0a48000003</user-id>
</comentario>
````

###DELETE >  `/users/{id_usuario}/comentarios/{id_comentario}.xml`
Permite a un usuario eliminar sus comentarios. Se debe pasar por par�metro el id_usuario y el id_comentario.

Ejemplo de xml respond:
````
<mensaje>
   <id>4fcb7602438bbd12a000004a</id>
   <salida>Comentario Eliminado con exito</salida>
</mensaje>
````

###GET > `/users/{id_usuario}/comentarios/{id_comentario}.xml`
Permite buscar y ver un comentario especifico de un usuario determinado. Se debe pasar por par�metro el id_usuario y el id_comentario
Ejemplo de xml respond:
````
<comentario>
   <admite-respuesta type="boolean">true</admite-respuesta>
   <comentario-id nil="true"/>
   <hora-publicacion>2012-06-02 23:07:50 -0430</hora-publicacion>
   <id>4fcadc0e438bbd0f9400002c</id>
   <me-gusta>0</me-gusta>
   <mensaje>esto es el primer comentario Usuario: lili1, estoy probando</mensaje>
   <no-me-gusta>0</no-me-gusta>
   <tag-ids type="array"/>
   <user-id>4fc4fe3a438bbd0a48000003</user-id>
</comentario>
````

###GET > `/comentarios/view.xml`
Permite listar todos los comentarios existentes.

Ejemplo xml respond:
````
<comentarios type="array">
   <comentario>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-05-16 19:49:19 -0430</hora-publicacion>
      <id>4fb44407438bbd0fac00001a</id>
      <me-gusta>0</me-gusta>
      <mensaje>Arpueban cupos CADIVI para ver a Maldonado y para hacer postGrado de Economia niegan dolares el CADIVI</mensaje>
      <no-me-gusta>0</no-me-gusta>
      <tag-ids type="array">
         <tag-id>4fb447ba438bbd0fac00002a</tag-id>
      </tag-ids>
      <user-id>4fb43cc7438bbd0fac000001</user-id>
   </comentario>
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-02 23:07:50 -0430</hora-publicacion>
      <id>4fcadc0e438bbd0f9400002c</id>
      <me-gusta>0</me-gusta>
      <mensaje>esto es el primer comentario Usuario: lili1, estoy probando</mensaje>
      <no-me-gusta>0</no-me-gusta>
      <tag-ids type="array"/>
      <user-id>4fc4fe3a438bbd0a48000003</user-id>
   </comentario>
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 10:32:12 -0430</hora-publicacion>
      <id>4fcb7c74438bbd12a0000098</id>
      <mensaje>Antes de la entrega</mensaje>
      <tag-ids type="array"/>
      <user-id>4fcada75438bbd0f94000011</user-id>
   </comentario>
   <comentario>
      <admite-respuesta type="boolean">true</admite-respuesta>
      <comentario-id nil="true"/>
      <hora-publicacion>2012-06-03 10:39:09 -0430</hora-publicacion>
      <id>4fcb7e15438bbd12a00000ac</id>
      <mensaje>diossss</mensaje>
      <tag-ids type="array"/>
      <user-id>4fcada75438bbd0f94000011</user-id>
   </comentario>
</comentarios>
````

### GET > `/comentarios/{comentario_id}/get_comentarios_hijos.xml}`
Permite mostrar los comentarios hijos de los comentarios, es decir las respuestas de los comentarios. Se debe pasar el par�metro comentario_id 

Ejemplo xml respond:
````
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
````

##Puntuaciones
###POST > `/users/{user_id}/comentarios/{comentarios_id}/puntuaciones.xml`
Permita a un usuario determinado puntuar los comentarios. Se debe pasar el user_id y el comentarios_id

Ejemplo xml request:
````
<puntuacione>
<me-gusta type="integer">1</me-gusta>
</puntuacione>
````

Ejemplo xml respond:
````
<puntuacione>
<comentario-id>4fcac0f0ca2f25210c0000ac</comentario-id>
<id>4fcac39aca2f25210c000173</id>
<mensaje>El comentario fue Puntuado Con exito</mensaje>
<no-me-gusta type="integer">1</no-me-gusta>
<user-id>4fcac0aaca2f25210c00009c</user-id>
</puntuacione>
````

###GET > `/puntuaciones/lista_puntuaciones.xml`
Perimite listar todas las puntuaciones

Ejemplo xml respond:
````
<puntuaciones type="array">
<puntuacione>
<comentario-id>4fcb6f72083611020c000f38</comentario-id>
<id>4fcb7c2eca2f251c0c001096</id>
<no-me-gusta type="integer">1</no-me-gusta>
<user-id>4fcb6beaca2f251c0c000dde</user-id>
</puntuacione>
<puntuacione>
<comentario-id>4fcb6f72083611020c000f38</comentario-id>
<id>4fcb7cb4ca2f251c0c0010b8</id>
<no-me-gusta type="integer">1</no-me-gusta>
<user-id>4fcb6bf8ca2f251c0c000de0</user-id>
</puntuacione>
</puntuaciones>
````

###DELETE > `/users/{user_id}/comentarios/{comentario_id}/puntuaciones/{puntuacione_id}.xml`
Perimite a un usuario eliminar las puntuaciones de los comentarios. Se debe pasar por parametro user-id, comentario_id y la puntuacion_id.
Ejemplo xml respond:
````
<puntuacione>
<comentario-id>4fcb6f72083611020c000f38</comentario-id>
<id>4fcb7cb4ca2f251c0c0010b8</id>
<no-me-gusta type="integer">1</no-me-gusta>
<user-id>4fcb6bf8ca2f251c0c000de0</user-id>
</puntuacione>
````

##Respuesta 
###POST > `/users/{id_user}/comentarios/{id_comentario}/respuesta.xml`
Permite generar una respuesta a un comentario especifico, se debe pasar por par�metro el id_user y el id_comentario

Ejemplo xml request:
````
<comentario>
<mensaje>22respuesta de respuesta de un comentario</mensaje>
</comentario>
````

Ejemplo xml respond:
````
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
````

##Tag
###GET > `/users/{id_users}/comentarios/{id_comentarios}/tags.xml`
Lista todos los tags que existen para los comentarios, se debe pasar por par�metro el id_user y el id_comentario.

Ejemplo xml respond:
````
<tags type="array">
<tag>
<comentario-ids type="array">
<comentario-id>4fcb6f72083611020c000f38</comentario-id>
</comentario-ids>
<id>4fcb81ffca2f251c0c001125</id>
<nombre>carros</nombre>
</tag>
</tags>


````

###POST > `/users/{id}/comentarios/{idcomentarios}/tags.xml `
Permite crear una nueva etiqueta, se depe pasar por par�metro el id del usuario y el id de comentarios.
Ejemplo xml resquest:
````
<tag>
<nombre>carros</nombre>
</tag>
````

Ejemplo xml respond:
````
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
<mensaje>hola &amp;nbsp;&lt;a href="http://www.youtube.com/watch?v=kffacxfA7G4 http://www.youtube.com/watch?v=kffacxfA7G4</a &amp;nbsp;&lt;br /mensaje
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
````