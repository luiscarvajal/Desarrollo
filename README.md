### Bienvenidos al Sistema XpresatE.
XpresatE es una plataforma orientada a servicios que utiliza un modelo de base de datos no relacional (NoSQL,) denominado [Mongo DB](http://www.mongodb.org/)y desarrollada bajo el ambiente del framework  [Ruby on Rails](http://rubyonrails.org/). Esta plataforma permite la gesti�n (env�o y recepci�n) de mensajes con contenido multimedia, al igual que el uso de plataformas o clientes desarrollados por terceros para evaluar el correcto funcionamiento de los servicios implementados.

Es importante destacar que la plataforma cuenta los siguientes requerimientos funcionales:
* **Autorizaci�n de operaciones:** permite realizar las operaciones de modificaci�n, eliminaci�n o creaci�n de nuevos registros mediante las reglas de negocio implementadas y la generaci�n de Tokens de seguridad, los cuales deben ser generados por dos elementos: usuario y clave de acceso.

* **Publicaci�n de Comentarios:** facilita a los usuarios registrados la capacidad de poder publicar mensajes o comentarios de longitud indefinida. Dichos comentarios pueden estar identificados por un tag para identificar dichos mensajes por un t�pico en especifico. Estos comentarios pueden adjuntar informaci�n multimedia o de cualquier otro formato. A su vez facilita a los usuarios dar respuestas sobre otros comentarios e indicar si le gusta o no y poder totalizar esos votos. El usuario puede indicar si el comentario que genera puede o no tener respuestas. Es importante destacar que ciertas operaciones realizadas a los comentarios, requieren la generaci�n de tonkens de seguridad para poder ser ejecutada.

A continuaci�n se detallan los pasos que usted debe seguir:

### 1- Instalar Ruby on Rails
* Descargue la versi�n de Ruby 1.9.3-p0 y el DevKit-tdm-32-4.5.2-20110712-1620-sfx.exe, ubicados en el siguiente link [Descar Ruby on Rails](http://rubyinstaller.org/downloads/archives, en la imagen se indica que archivos descargarse. Ejecute primero el instalador de Ruby luego el de DevKit.

![Descargar Ruby y DevKit](C:\Users\LILIANA>C:\Users\LILIANA\Desktop\ultimo servidor desarrollo\Desarrollo\ my_app\my_app\DescargarRuby.png) 

* Terminada la instalaci�n abrimos la linea de comandos de Ruby  (Start Command Prompt with Ruby)
```gem update --system```




### Metodos Disponibles en la aplicacion:

##Users
#GET > `/Users.xml`