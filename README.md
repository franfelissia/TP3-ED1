# TP3-ED1
Este proyecto contiene el código del trabajo práctico número 3 de Electrónica Digital 1 de la Facultad de Ciencias Exactas, Físicas y Naturales de la Univercidad Nacional de Córdoba por el grupo 15.

## Consigna
Diseñar, implementar y simular el funcionamiento de una ALU con operandos A y B de 4 bits, y salida R de 4 bits. El diagrama a implementar y el diagrama de pines de la placa a utilizar (Basys3) se pueden observar en el archivo “DiseñoALU.pdf”.   

En dicho documento se muestra la función a realizar por la ALU, la cual se define con 4 bits individuales de control C (C1, C2, C3, C4), permitiendo las siguientes funciones:
- Suma o Resta.
- Saturación o No saturación.
- Selección AND bit a bit u OR bit a bit (con un MUX).
- Selección salida parte Aritmética o parte Lógica (con un MUX).

Además del resultado en 4 bits, la ALU debe tener un bit de salida que indique cuando hubo carry de salida, y otro bit de salida que indique cuando hubo overflow.

Se debe implementar el trabajo en lenguaje VHDL utilizando el programa Vivado de Xilinx.

Utilizar los leds de la placa L0 a L3 para mostrar los resultados.

Utilizar el led L14 para mostrar si existe Carry y el led L15 para mostrar si existe Overflow.

Recordar que deben asignar los pines para manejar los operandos A y B con los interruptores, los bits de control con los pulsadores (botones), y los bits de salida con LEDs.

Para realizar el trabajo es imprescindible observar los documentos que se adjuntan, donde se encuentra una explicación conceptual básica al respecto del trabajo, tips a tener en cuenta para el informe, links importantes para el TP3, diagrama a implementar y diagrama de pines de la placa.

_Opcional: se puede utilizar el display 7 segmentos que contiene la placa para mostrar los resultados._

## Agregados
- Dado que la consigna no especifica, decidimos tratar a A y a B como si estuvieran codificadas en complemento a 2 para las operaciones de suma y resta.
- Ya que nosotros decidimos usar el display, se nos ocurrió implementarlo de modo tal que los datos se muestran sólo cuando está en modo aritmético y tambien agregar un quinto bit de control que permite cambiar el dato mostrado en el display entre el resultado, A y B.