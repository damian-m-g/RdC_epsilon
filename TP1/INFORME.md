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

# Desarrollo

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

## 7)

### b) 

Sí, lo reemplaza en IPv6. Intenta ser mas _lite_, y provee capacidades extras.

### c)

Las funciones o funcionalidades principales son:
- Reemplazando a ARP, sigue siendo necesario un mapeo de IP vs MAC. Esto se sigue haciendo, mediante nuevas metodologías conocidas como Neighbor Solicitation (NS) y Neighbor Advertisement (NA).
- La autoconfiguración de direcciones IP. Mientras que en IPv4 era menester el uso de DHCP para la obtención dinámica de direcciones ip, NDP no necesita de ello, mediante el sistema SLAAC puede autoasignarse una dirección IP, principalmente basada en su propia dirección MAC.
- Otras funcionalidades _secundarias_ como la _detección de duplicación de direcciones ip_, _router solicitation_; en routers: _router advertisement_, y _redirection_, que permite a los routers redirigir el tráfica hacia una aparente mejor ruta.

### d)

En IPv6 hay una flexibilidad mayor para hacer broadcast; es posible hacer un broadcast a todos los hosts no-routers de la red local mediante `ff02::1`, o hacer uno a todos los routers _al alcance_ con `ff02::2`. Para esto último, los routers deben tener habilitada la funcionalidad.

### e)

En IPv6, las direcciones **link-local** (LLA) son válidas solo dentro de la misma red local. Las **unique-local** (ULA) son válidas dentro de una red privada, tampoco tiene validez en internet al igual que las LLA. Vale aclarar que la diferencia entre LLA y ULA radica en que una ULA puede aplicar a una WAN que no necesariamente es parte de internet. Por último las direcciones **global** (GUA) son públicas a todo el internet.

---

# Parte 2

## 1)

El Cisco Catalyst 2950 es una serie de switches de configuración fija y administrados con capacidad de 10/100 Mbps, diseñado para pequeñas y medianas redes. Estos switches incluyen el software Standard Image (SI), que proporciona funcionalidades básicas para datos, voz y video.

### Características de Hardware

#### Puertos y Conectividad
  - Disponible en configuraciones de 12, 24 o 48 puertos 10/100 Mbps según el modelo
  - Puertos de enlace ascendente Gigabit Ethernet (modelos 2950SX con 2 puertos 1000BASE-SX fijos)
  - Soporte para modos de comunicación Half-Duplex y Dúplex completo

#### Memoria y Rendimiento
  - 16 MB de DRAM para procesamiento
  - 8 MB de memoria Flash para almacenamiento del sistema operativo
  - 8 MB de buffer de paquetes compartido por todos los puertos
  - Capacidad para configurar hasta 8,000 direcciones MAC
  - Rendimiento de conmutación de 13.6 Gbps (en modelos superiores)
  - Tasas de reenvío de entre 1.8 Mpps (modelo 2950-12) hasta 10.1 Mpps (modelos 2950T-48 y 2950SX-48)

#### Diseño Físico
  - Factor de forma: 1U para montaje en rack
  - Dimensiones: 17.5 x 9.5 x 1.7 pulgadas (ancho x profundidad x altura)
  - Formato apilable y adecuado para instalación en armarios de telecomunicaciones

#### Funcionalidades Avanzadas

Una de las características más importantes del Catalyst 2950 es la capacidad para implementar VLANs, permitiendo segmentar una red física en múltiples redes virtuales. Esto proporciona:
  - Mayor seguridad al aislar grupos de trabajo
  - Mejor rendimiento al reducir dominios de colisión y broadcast
  - Facilidad de administración al agrupar usuarios lógicamente independientemente de su ubicación física

#### Seguridad de Red
  - Secure Shell version 2 (SSHv2) para encriptar información administrativa
  - Private VLAN Edge para aislar puertos en un switch
  - Seguridad basada en usuarios o direcciones MAC
  - Control de acceso mediante autenticación IEEE 802.1x

#### Rendimiento y Disponibilidad
  - Fast EtherChannel para proporcionar alto rendimiento en enlaces entre switches, routers y servidores
  - Múltiples enlaces ascendentes Gigabit para aumentar el ancho de banda hacia el núcleo de la red

## 2)

## 3)

### a)

### b)

### c)

El enrutador determina la comunicación entre un host y otro siguiendo estos pasos:

1. **Verificación de la dirección IP de destino**
  - Cuando Cliente 1 envía un paquete ICMP a Cliente 2, primero verifica si la IP de destino está en la misma subred.
  - Si están en redes diferentes, Cliente 1 envía el paquete al gateway predeterminado (el router).

2. **Tabla de enrutamiento**
  - El router revisa su tabla de enrutamiento para determinar la mejor ruta hacia la red de Cliente 2.
  - Si tiene una entrada para la red de destino, reenvía el paquete por la interfaz adecuada.
  - Si no tiene una ruta, puede usar una ruta por defecto o descartar el paquete.

3. **Encapsulación de la trama**
  - El router cambia la dirección MAC de origen y destino en la trama Ethernet y la envía al switch para que llegue a Cliente 2.

4. **Respuesta del Cliente 2**
  - Cliente 2 responde con un paquete ICMP siguiendo el mismo proceso, pero en dirección inversa.

### d)

El switch se usa para interconectar dispositivos dentro de la misma red (LAN) y mejorar la eficiencia en la transmisión de datos. Sus funciónes principales son aprender direcciones MAC y reenviar trafico solo a los puertos correctos, reducir las colusiones en la red y usar la conmutacion por hardware, y optimizar el rendimiento mediante full-duplex.

Los switches de capa 2, como el Cisco Catalyst 2950, no necesitan direcciones IP en sus interfaces porque trabajan con direcciones MAC y no con direcciones IP para reenviar tráfico. Aun que un siwtch puede tener una direcciones IP, esta solo se usa para administracion remota y no para el trafico de datos.

---

# Discusión y conclusiones

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, mauris sit amet aliquet vestibulum, enim ante consectetur enim, vel sollicitudin odio risus vel libero. Integer eget ipsum sed eros luctus laoreet vel vel leo. Fusce ut dapibus nisl. Aliquam erat volutpat. Donec in elit non justo convallis vestibulum.

---

# Referencias

- Stallings, W. (2004). _Comunicaciones y Redes de Computadores. Séptima edición_. Pearson.
- Agilent Technologies (2006). _Network Communication Protocols_.
- Autores varios (16 de Marzo de 2025). _[Internet Control Message Protocol](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol)_. Wikipedia.
