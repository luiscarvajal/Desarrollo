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
#GET > `/Users.xml`
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

#POST > `/Users.xml`
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