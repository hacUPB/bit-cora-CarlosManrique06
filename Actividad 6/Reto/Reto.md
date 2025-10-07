### Shapes and Shapes

El proyecto consiste en una experiencia  donde controlas un círculo  que puedes mover libremente por la pantalla. A medida que avanzas, aparecen diversas figuras geométricas enemigos generados dinámicamente que intentan colisionar contigo y causarte daño. Para sobrevivir, debes esquivarlas o aprovechar objetos especiales que, al recogerlos, te otorgan poderes temporales que modifican tu forma o habilidades. El círculo tiene tres vidas, y cada vez que recibe daño, su apariencia cambia para reflejar su estado de salud, mostrando visualmente cómo se debilita. 

### Aplicación de patrones de diseño en el arte generativo:

Patrón Observer: Se utiliza para gestionar los poderes especiales que el círculo puede obtener al recoger ciertos objetos. Cuando un poder se activa, todos los componentes relacionados (como la apariencia del círculo, la velocidad, o la interacción con enemigos) se actualizan automáticamente notificando a los observadores de ese cambio, asegurando una comunicación eficiente y desacoplada entre los elementos del juego.

Patrón Factory: Permite la creación flexible y modular de diferentes tipos de enemigos o figuras geométricas, cada una con comportamientos y apariencias distintas. Esto facilita la extensión del juego añadiendo nuevas formas sin modificar el código principal, promoviendo la escalabilidad y mantenibilidad.

Patrón State: Controla el estado actual del círculo en cuanto a sus poderes o nivel de salud. Por ejemplo, el círculo puede estar en estado normal, estado con poder activo, o estado débil después de perder vidas. Este patrón permite que el comportamiento y la apariencia del círculo cambien dinámicamente según el estado, simplificando la gestión de estados complejos y sus transiciones.