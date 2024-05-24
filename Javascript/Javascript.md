# Isaac Shakalo A01784045

# Análisis de Archivos de Código Fuente

# Reflexión sobre la Solución

El objetivo era crear un programa que pueda leer un archivo de código y destacar diferentes partes importantes, como palabras clave, variables, números, comentarios y espacios en blanco. Para lograr esto, creamos un módulo en Elixir que lee el archivo línea por línea y crea un nuevo archivo HTML con los elementos resaltados.

# Como Funciona

get_reserved_words(in_filename, out_filename): Esta función lee el archivo de código y llama a otra función para procesar cada línea.

process_line(line, out_fd): Esta función analiza cada línea del archivo para encontrar palabras clave, variables, números, etc. Luego, resalta estos elementos en el archivo HTML resultante.

# Complejidad del Algoritmo

La complejidad del algoritmo es simple. Toma más tiempo si el archivo de código es muy largo, pero el tiempo de ejecución es razonable.

# Conclusiones

Nuestra solución funciona bien para analizar archivos de código.
Aunque puede tardar más con archivos muy grandes, en general, es rápido y efectivo.
Es importante probarlo con diferentes archivos para ver cómo funciona en distintas situaciones.

# Reflexión Ética

Crear tecnologías como esta puede ayudar a los programadores a trabajar más rápido, pero también plantea preguntas sobre la privacidad y seguridad de la información. Es importante pensar en estas cuestiones y usar la tecnología de manera responsable.
