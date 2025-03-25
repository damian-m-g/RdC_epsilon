
# Trabajo Práctico N° 1

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

Un párrafo, sin sangría. Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto Escribe aquí tu texto.

**Palabras clave**: _escribe, aquí, tu texto._

---

# Introducción

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, mauris sit amet aliquet vestibulum, enim ante consectetur enim, vel sollicitudin odio risus vel libero. Integer eget ipsum sed eros luctus laoreet vel vel leo. Fusce ut dapibus nisl. Aliquam erat volutpat. Donec in elit non justo convallis vestibulum. Fusce malesuada, sapien nec consequat dignissim, lorem eros suscipit nulla, non gravida magna libero id turpis. Suspendisse potenti. Maecenas quis mauris dui. Nunc accumsan, lorem vitae posuere fringilla, lacus mauris convallis magna, nec interdum nunc tortor vel sem. Integer sit amet sollicitudin ipsum. In hac habitasse platea dictumst. Sed vitae est id dui fringilla mollis. Vivamus varius vestibulum consequat. Sed posuere consequat dolor, sit amet suscipit lorem cursus id.

---

# Marco teórico / Modelo / Metodología

## Título

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, mauris sit amet aliquet vestibulum, enim ante consectetur enim, vel sollicitudin odio risus vel libero. Integer eget ipsum sed eros luctus laoreet vel vel leo. Fusce ut dapibus nisl. Aliquam erat volutpat. Donec in elit non justo convallis vestibulum.  

`codigo`

### Nivel de título menor

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, mauris sit amet aliquet vestibulum, enim ante consectetur enim, vel sollicitudin odio risus vel libero. Integer eget ipsum sed eros luctus laoreet vel vel leo. Fusce ut dapibus nisl. Aliquam erat volutpat. Donec in elit non justo convallis vestibulum.

| Ejemplo | Tabla |
|-----------|-------|
| Header | Title |
| Paragraph | Text |

```
// Más código
{
"firstName": "John",
"lastName": "Smith",
"age": 25
}
```

---

# Desarrollo

## 4)  

Se adjuntan imágenes de las pruebas de conectividad exitosos:

h1 → h2

![](imagenes/Ping_h1_h2.png)

h1 → h3

![](imagenes/Ping_h1_h3.png)

## 5)

Se adjuntan imágenes de las pruebas de conectividad exitosos:

h1 → h2
  
![](imagenes/Ping_h1_h2_ipv6.png)

h1 → h3

![](imagenes/Ping_h1_h3_ipv6.png)

## 6)

### a.

#### Análisis de Comunicaciones ARP

Cuando h1 (192.168.1.10) intenta comunicarse con h2 (192.168.2.10), se producen las siguientes comunicaciones ARP:

#### Primer intercambio ARP: h1 → Router 1

#### ARP Request desde h1:

- h1 necesita enviar datos a 192.168.2.10 (h2)
- h1 determina que h2 está en otra red (192.168.2.0/24)
- h1 debe enviar el paquete a su gateway (192.168.1.11)
- h1 emite un broadcast ARP (FF:FF:FF:FF:FF:FF): "¿Quién tiene la IP 192.168.1.11?"

#### Contenido del paquete:

- MAC origen: [MAC de h1]
- MAC destino: FF:FF:FF:FF:FF:FF (broadcast)
- Tipo: ARP Request (1)
- IP solicitada: 192.168.1.11

#### ARP Reply desde Router 1:

- Router 1 recibe el broadcast
- Router 1 responde directamente a h1: "Yo tengo 192.168.1.11 y mi MAC es [MAC del Router]"

#### Contenido del paquete:

- MAC origen: [MAC de Router-eth0]
- MAC destino: [MAC de h1]
- Tipo: ARP Reply (2)
- IP: 192.168.1.11
- MAC respondida: [MAC de Router-eth0]

#### Segundo intercambio ARP: Router 1 → h2

#### ARP Request desde Router 1:

- Router 1 necesita enviar el paquete a h2 (192.168.2.10)
- Router 1 emite un broadcast ARP en la red 192.168.2.0/24: "¿Quién tiene la IP 192.168.2.10?"

#### Contenido del paquete:

- MAC origen: [MAC de Router-eth1]
- MAC destino: FF:FF:FF:FF:FF:FF (broadcast)
- Tipo: ARP Request (1)
- IP solicitada: 192.168.2.10

#### ARP Reply desde h2:

- h2 recibe el broadcast
- h2 responde directamente al Router 1: "Yo tengo 192.168.2.10 y mi MAC es [MAC de h2]"

#### Contenido del paquete:

- MAC origen: [MAC de h2]
- MAC destino: [MAC de Router-eth1]
- Tipo: ARP Reply (2)
- IP: 192.168.2.10
- MAC respondida: [MAC de h2]

#### Proceso de traducción de direcciones

El protocolo ARP permite traducir direcciones IP (lógicas, capa 3) a direcciones MAC (físicas, capa 2) siguiendo estos pasos:
1. El dispositivo emisor consulta su tabla ARP local.
2. Si no tiene la entrada correspondiente, emite un ARP Request (broadcast).
3. El dispositivo con la IP solicitada responde con un ARP Reply.
4. El emisor actualiza su tabla ARP con la información recibida.
5. Esta información se almacena en memoria para futuras comunicaciones.

Esta traducción es necesaria porque las tramas Ethernet (capa 2) requieren direcciones MAC, mientras que las aplicaciones trabajan con direcciones IP (capa 3).

#### Ejemplo gráfico del proceso ARP

![](imagenes/ARP.gif)

### b.

#### Direcciones IP en los data-gramas durante la comunicación entre h1 y h2

En la topología de red mostrada previamente, cuando se realiza un ping desde h1 hacia h2, el encabezado IP del PDU (Protocol Data Unit) enviado contiene la siguiente información:
-  **Dirección IP de origen**: 192.168.1.10 (perteneciente a h1)
-  **Dirección IP de destino**: 192.168.2.10 (perteneciente a h2)

Ejemplo gráfico de lo mencionado anteriormente:

![](imagenes/Encabezado_h1_h2.png)

Lo mismo ocurre cuando se realizar un ping desde h1 hacia h3, lo que cambia es la dirección de destino que será la de h3.

## 7)  

### a.

#### Análisis de comunicaciones NDP en tráfico ICMPv6 entre h1 y h3

Al iniciar tráfico ICMPv6 entre h1 (2001:aaaa:bbbb:1::10/64) y h3 (2001:aaaa:cccc:1::11/64), se producen varias comunicaciones NDP (Neighbor Discovery Protocol). Estos mensajes sustituyen la funcionalidad de ARP en IPv4.

#### Tipos de mensajes NDP observados

#### 1. Neighbor Solicitation (NS) de h1 al Router 1

-  **Dirección IPv6 origen**: 2001:aaaa:bbbb:1::10 (h1)
-  **Dirección IPv6 destino**: ff02::1:ff00:11 (dirección multicast solicited-node para 2001:aaaa:bbbb:1::11)
-  **Propósito**: h1 necesita resolver la dirección MAC del Router 1 (su gateway) antes de enviar el paquete

#### 2. Neighbor Advertisement (NA) del Router 1 a h1

-  **Dirección IPv6 origen**: 2001:aaaa:bbbb:1::11 (Router 1 - interfaz eth0)
-  **Dirección IPv6 destino**: 2001:aaaa:bbbb:1::10 (h1)
-  **Propósito**: El Router 1 responde con su dirección MAC  

#### 3. Neighbor Solicitation (NS) del Router 1 a h3

-  **Dirección IPv6 origen**: 2001:aaaa:cccc:1::12 (Router 1 - interfaz eth1)
-  **Dirección IPv6 destino**: ff02::1:ff00:11 (dirección multicast solicited-node para 2001:aaaa:cccc:1::11)
-  **Propósito**: El Router 1 necesita resolver la dirección MAC de h3

#### 4. Neighbor Advertisement (NA) de h3 al Router 1

-  **Dirección IPv6 origen**: 2001:aaaa:cccc:1::11 (h3)
-  **Dirección IPv6 destino**: 2001:aaaa:cccc:1::12 (Router 1 - interfaz eth1)
-  **Propósito**: h3 responde con su dirección MAC

#### Ejemplo gráfico del proceso NDP

![](imagenes/NDP.gif)

---

## 6)

### a)  

Antes de iniciar el intercambio de paquetes ICMP, la tabla ARP se encontraba vacía, sin ninguna asociación entre direcciones IP y direcciones MAC. Esta ausencia de entradas en la tabla refleja que aún no se había establecido comunicación entre los dispositivos de la red, como se evidencia en la siguiente captura:

![](imagenes/Tabla_ARP_0.png)

Luego de la ejecución de los comandos ping, la tabla ARP se actualizó automáticamente, registrando las direcciones MAC de origen correspondientes a cada uno de los hosts que enviaron solicitudes ICMP. Este proceso de resolución de direcciones permitió completar la tabla con la información necesaria para establecer la comunicación a nivel de enlace de datos entre los dispositivos de la red.

![](imagenes/Tabla_ARP_1.png)
  
### b) 

En los datagramas IP, las direcciones IP se encuentran en la cabecera IPv4 del paquete, específicamente en los campos de dirección IP de origen y dirección IP de destino.

Por ejemplo, en un datagrama IP capturado durante la comunicación entre dos hosts, podemos observar:

![](imagenes/Frame_ICMP_0.png)

- **Dirección IP de origen:** 192.168.0.20 → Esta es la dirección del dispositivo que envía el datagrama
- **Dirección IP de destino:** 192.168.0.30 → Esta es la dirección del dispositivo al que va dirigido el datagrama

# Conclusiones

Este trabajo nos permitió implementar y analizar una red dual-stack IPv4/IPv6 utilizando herramientas de simulación de redes. Los resultados obtenidos demuestran claramente las diferencias entre los mecanismos de comunicación de ambos protocolos.

Se observó que mientras IPv4 utiliza ARP con mensajes broadcast para resolver direcciones físicas, IPv6 implementa NDP con direcciones multicast solicited-node, resultando en una comunicación más eficiente. Las pruebas de conectividad mediante ICMP permitieron verificar el correcto funcionamiento del enrutamiento entre las distintas redes (192.168.1.0/24 y 192.168.2.0/24).

El análisis del tráfico reveló cómo el router determina las rutas apropiadas basándose en sus tablas de enrutamiento, mientras que el switch opera exclusivamente en capa 2 sin necesidad de direccionamiento IP.

Este laboratorio proporcionó una experiencia práctica fundamental para comprender los protocolos de comunicación modernos y las ventajas que IPv6 ofrece frente a las limitaciones de IPv4.

---

# Referencias

[1] Consultar [Normas APA](https://normas-apa.org/referencias/)
[2] ...
[3] ...
