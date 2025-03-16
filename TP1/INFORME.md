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
