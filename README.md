# Proyecto de Simulación y Programación Declarativa

> Nadia González Fernández C412

## Principales Ideas seguidas para la solución del problema
Para dar solución al problema se utilizan dos tipos de elementos: los agentes y los elemntos del ambiente.
Los robots son considerados agentes y el resto de los elementos del ambiente.

Las acciones se realizan por turnos. Se mueven todos los agentes durante 5 turnos consecutivos y al sexto turno
se mueven los niños del ambiente. 

La dirección en se se mueve cada elemento se realiza de forma aleatoria y según la nueva posición que ocupa realiza acciones.

Los niños generan suciedad de forma aleatoria cuando se mueven de posición si no están siendo cargados

## Modelos de Agentes considerados (por cada agente se deben presentar dos modelos diferentes)

El agente utilizado es reactivo, el cual ejecuta acciones en dependencia de las condiciones 
del ambiente en ese momento.

Para la realización de un agente pro-activo se podría implementar BFS y hacer una busqueda 
más inteligente de caminos y realizar movimientos con un objetivo. De esta forma se analizan 
las condiciones del ambiente antes de realizar el movimento y se pueden obtener mejores resultado

Sin embargo el ambiente que presenta este problema, a pesar de ser dinámico, no está en constante 
movimiento, por lo tanto el agente reactivo da solución al problema y es más eficiente ya que 
realiza menos operaciones.

## Ideas seguidas para la implementación

La solución simula el tablero en un data `Board`, que tiene las dimensiones del mismo y 
tiene una lista con todos los objetos presentes en el tablero. Todos los objetos son representados
de la forma `(Int, Int, String, Bool)`, el cual representa las coordenadas de la posición actual del 
objeto, el tipo de objeto y si este es un niño o un robot si se encuentra cargado o está cargando respectivamente.
Para mayor facilidad en la en `Objects.hs` se simula un enum para nombrar los objetos.


En el `main.hs` se crea un `Board` y en `Lib.hs` se realiza la ejecución de un 
ciclo que es el encargado de organizar los turnos de los agentes y esperar 2 segundos 
entre cada turno.

En `AgentMoves` se realizan los movimientos de los robots y en `KidMoves` los de los niños y 
los obstaculos que son desplazados por estos.

## Consideraciones obtenidas a partir de la ejecución de las simulaciones del problema (determinar a partir de la experimentación cuáles fueron los modelos de agentes que mejor funcionaron)

La respuesta dada al problemacon los agentes reactivos cumple los objetivos de solución de forma eficiente.