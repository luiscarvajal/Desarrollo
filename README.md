### Bienvenidos al Sistema XpresatE.
XpresatE es una plataforma orientada a servicios que utiliza un modelo de base de datos no relacional (NoSQL,) denominado [Mongo DB](http://www.mongodb.org/)y desarrollada bajo el ambiente del framework  [Ruby on Rails](http://rubyonrails.org/). Esta plataforma permite la gestión (envío y recepción) de mensajes con contenido multimedia, al igual que el uso de plataformas o clientes desarrollados por terceros para evaluar el correcto funcionamiento de los servicios implementados.

Es importante destacar que la plataforma cuenta los siguientes requerimientos funcionales:
* **Autorización de operaciones:** permite realizar las operaciones de modificación, eliminación o creación de nuevos registros mediante las reglas de negocio implementadas y la generación de Tokens de seguridad, los cuales deben ser generados por dos elementos: usuario y clave de acceso.

* **Publicación de Comentarios:** facilita a los usuarios registrados la capacidad de poder publicar mensajes o comentarios de longitud indefinida. Dichos comentarios pueden estar identificados por un tag para identificar dichos mensajes por un tópico en especifico. Estos comentarios pueden adjuntar información multimedia o de cualquier otro formato. A su vez facilita a los usuarios dar respuestas sobre otros comentarios e indicar si le gusta o no y poder totalizar esos votos. El usuario puede indicar si el comentario que genera puede o no tener respuestas. Es importante destacar que ciertas operaciones realizadas a los comentarios, requieren la generación de tonkens de seguridad para poder ser ejecutada.

A continuación se detallan los pasos que usted debe seguir:

### 1- Instalar Ruby on Rails
* Descargue la versión de Ruby 1.9.3-p0 y el DevKit-tdm-32-4.5.2-20110712-1620-sfx.exe, ubicados en el siguiente link [Descar Ruby on Rails](http://rubyinstaller.org/downloads/archives, en la imagen se indica que archivos descargarse. Ejecute primero el instalador de Ruby luego el de DevKit.
* Terminada la instalación abrimos la linea de comandos de Ruby  (Start Command Prompt with Ruby)
`gem update --system`

* Una vez instalado el Ruby y con ayuda del RubyGems, podemos proceder a instalar el Framework Rails que se trata de una “gema”, nuevamente en la línea de comandos escribimos: `gem install rails`

* Cree su primera aplicación de la siguiente forma
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

* Se facilita este sencillo manual sobre los comandos básicos utilizados en Mongo DB para la generación o creación de las bases de datos. [Usos básicos Mongo DB](http://blog.jam.net.ve/2011/01/09/usos-basicos-de-mongodb-console/)  



```
$ cd your_repo_root/repo_name
$ git fetch origin
$ git checkout gh-pages
```


##METODOS

###Users
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

##POST > `/users.xml`
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

##Comentarios
###GET > `users/{user_id}/comentarios.xml`
Permite listar todos los comentarios existentes que tiene un usuario en específico, se debe pasar por parametro el user_id.

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
