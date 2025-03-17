# Trabajo Práctico N° 1 (parte 1)

### Nombres _(por órden alfabético)_
_Gil Cernich Manuel (manuel.gil.cernich@mi.unc.edu.ar)_  
_González Damián M. (damian.gonzalez@mi.unc.edu.ar)_  
_Zuñiga Ivan A. (ivan.zuniga@mi.unc.edu.ar)_

### Nombre del grupo  
_epsilon_  

### Nombre del centro educativo

_Facultad de Ciencias Exactas, Físicas y Naturales; Universidad Nacional de Córdoba_

### Nombre del curso

_Redes de Computadoras_

### Profesores _(por órden alfabético)_

_Henn Santiago M._  
_Oliva Cuneo Facundo_

### Fecha

_26-03-2025_

---

# Resumen

Este trabajo indaga en los protocolos:
- **ARP**, perteneciente a la capa de **acceso a la red** (de acuerdo al modelo TCP/IP, y de ahora en más salvo que se diga lo contrario nos referiremos siempre a este modelo). Traduce direcciones IP a MAC en redes locales.
- **IPv4** e **IPv6**, pertenecientes a la capa de **internet**. Direccionan y enrutan paquetes de datos entre dispositivos de una red.
- **NDP**, perteneciente a la capa de **internet** y que puede considerarse un protocolo hijo del protocolo **IPv6**. Resuelve direcciones IP a MAC, y realiza otras funciones de descubrimiento en la red. Es análogo a ARP, utilizado para IPv4.
- **ICMP**, perteneciente a la capa de **internet**, que tiene sus versiones compatibles con IPv4 e IPv6 respectivamente. Permite el envío de mensajes de control de errores en redes, como `ping` y `traceroute`.

**Palabras clave**: _IPv4, ARP, IPv6, NDP, ICMP, DHCP, emuladores de redes, simuladores de redes._

---

# Introducción

En esta primera parte del trabajo práctico construiremos un diagrama de red utilizando el software de simulación Packet Tracer. Se procederá a configurar los 5 dispositivos, tal como está definido en la **Tabla de asignación de direcciones propuestas**. A continuación, a posteriori de abarcar cuestiones del plano teórico, se procederá a realizar una serie de pruebas entre los hosts, dejando constancia del resultado, y respondiendo una serie de preguntas al respecto.

---

# Marco teórico

De los protocolos mencionados, el mas explotado en este trabajo es ICMP, que tiene como objetivo principal, proveer funcionalidades de chequeo de performance y errores. Este protocolo tiene su versión _podada_ tanto para IPv4, como para IPv6; ambas dos se utilizan aquí.  
A su vez, ICMP dependiendo de la versión para la cual se use, IPv4 o IPv6, hará uso de ARP o NDP respectivamente. Esto se debe a que cuando uno hace uso de una de las funcionalidades, por ejemplo `ping`, uno pasa el IP de la máquina _target_. En una red local, los dispositivos se comunican a nivel Capa OSI 2, es decir que debe haber un mapeo entre el IP destino, y la MAC de ese destino. Este mapeo debe encontrarse en la tabla ARP del host origen. Si no se encuentra, se envía un mensaje de tipo _broadcast_ a la red, de manera de añadir esta entrada. Luego recién puede haber comunicación entre estos dos hosts.  
Caso similar se da al utilizar IPv6, donde las funcionalidades de ICMP hacen uso de NDP.

## 2)

Para este propósito, y los items de práctica siguientes se utilizó Cisco Packet Tracer.

![](imagenes/diagrama_de_red.jpg)

## 3)

Un simulador es una abstracción de un emulador. Un emulador es una abstracción de la realidad. El emulador replica lo mas fielmente posible, los aspectos de la realidad que quiere _copiar_. El simulador, por otro lado, se abstrae un poco mas de la realidad versus el emulador. En el caso del simulador, no necesariamente se tienen en cuenta _todos_ los aspectos que hacen a la realidad de la _cosa_ que se quiere copiar, sino solo los necesarios para demostrar cierto objetivo. En cuanto a hardware y software, un emulador de una _cosa_ lógicamente consume muchos mas recursos que un simulador de la _cosa_, porque este último maneja mucha menos información que un emulador.

## 6)

### c)

1. El host h1 detecta que h2 no está en su misma subred, por lo tanto envía el paquete al default gateway: el router.
2. El router recibe el paquete, observa la IP de destino y se da cuenta que está en la subred conectada a su otra NIC, sin embargo primero necesita conocer su dirección MAC, previo a re-encapsular el paquete. Puede tener la dirección MAC asociada a la IP destino o no. Este mapeo se encuentra en la tabla ARP del router. Suponiendo que no tiene este mapeo hecho, enviará un _ARP request_ a la subred destino, esto es un mensaje broadcast. El switch aquí hace de _pasamanos_. h2 recibe el _ARP request_ y _responde con su MAC_. El router ahora tiene en su tabla ARP la asociación entre IP destino y su respectiva MAC.
3. El router encapsula el paquete del host h1 dentro de una trama Ethernet (o de carácter similar (misma capa)) y la envía en dirección a h2.
4. El switch recibe este paquete, ya que se encuentra en el medio entre el router y h2. Lo que hace es simplemente reenviar el paquete al puerto de salida que tiene mapeada la dirección MAC destino.

### d)

El switch se utiliza simplemente para ampliar una red. En una hipotética red local, si está comprendida por dos computadoras, con una conexión punto a punto basta; peor se si suma una tercer computadora, y no se desean agregar mas NICs que la única que viene con cada host, entonces será necesaria la utilización de un switch. Los switches pueden anidarse para crear redes mas grandes. Un switch opera en la capa OSI 2, donde maneja la identidad de cada host miembro de la red mediante una **identificación única** concerniente a determinada NIC conocida como MAC.  
El switch no tiene asignada direcciones IP en sus interfaces porque sabe nada de ese protocolo. Ese protocolo pertenece a la capa OSI 3, gracias a esto, un switch no necesita gran capacidad computacional, sino algo reducida con respecto a las capacidades que tiene un router.

### e)

Las entradas de la tabla ARP (IP vs MAC) de h1 contiene solamente su default gateway: el router.

### f)

Las entradas de la tabla ARP de h3 son:
- default gateway: router
- h2

### g)

Al router tener 2 NICs, tiene 2 tablas ARP. Una de ellas tendrá como única entrada h1. La otra tendrá como entradas:
- h2
- h3

### h)

Las dirección de broadcast de IPv4 son XXX.XXX.XXX.255; es decir que utilizan el último valor posible del último octeto de la subred a la cual quiere enviársele un mensaje broadcast. La utilidad de un mensaje broadcast es principalmente descubrir hosts, en el caso del protocolo DHCP o ARP; aunque también puede utilizarse para otros propósitos específicos a ciertas aplicaciones. Todos los hosts de una subred recibirán un mensaje broadcast direccionado a dicha respectiva subred.

---

# Resultados

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, mauris sit amet aliquet vestibulum, enim ante consectetur enim, vel sollicitudin odio risus vel libero. Integer eget ipsum sed eros luctus laoreet vel vel leo. Fusce ut dapibus nisl. Aliquam erat volutpat. Donec in elit non justo convallis vestibulum.

---

# Discusión y conclusiones

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, mauris sit amet aliquet vestibulum, enim ante consectetur enim, vel sollicitudin odio risus vel libero. Integer eget ipsum sed eros luctus laoreet vel vel leo. Fusce ut dapibus nisl. Aliquam erat volutpat. Donec in elit non justo convallis vestibulum.

---

# Referencias

- Stallings, W. (2004). _Comunicaciones y Redes de Computadores. Séptima edición_. Pearson.
- Agilent Technologies (2006). _Network Communication Protocols_.
- Autores varios (16 de Marzo de 2025). _[Internet Control Message Protocol](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol)_. Wikipedia.
