
## Arte (Cielo Vivo)

La idea de mi obra es una simulación generativa de un cielo en movimiento, con nubes y humo gestionados por estructuras de datos como listas enlazadas y colas, que responde a la interacción del usuario con mouse y teclado, que al llegar al limite de la pantalla, se borran dinamicamente las nubes o al oprimir una tecla, otra idea que tengo para interacción con usuario es que haya un viento que mueva las nubes de dirección.


Las nubes se gestionan mediante una lista enlazada, donde cada nodo representa una nube con sus propias propiedades como color, posición y una pequeña estructura de  cola de humo asociada para que acompañe a las nubes. Esta estructura permite recorrer dinámicamente las nubes para actualizarlas, dibujarlas y, en caso de que abandonen el área visible de la pantalla, eliminarlas eficientemente para liberar memoria.

