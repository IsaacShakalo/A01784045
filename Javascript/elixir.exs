defmodule Tfile do
  # Definimos algunas expresiones regulares para identificar diferentes tipos de tokens
  @string_regex ~r/[""''+={}*)();><:,\[\]]/
  @comment_regex ~r/\/\/.*/
  @reserved_words ~w(var let const function return if else for while switch case break continue default true false null undefined console)
  @variable_regex ~r/\b(?!<span\b|<\/span>)[A-Za-z_][A-Za-z0-9_]*\b/
  @number_regex ~r/\b\d+(\.\d+)?\b/
  @whitespace_regex ~r/[log .]/

  def get_reserved_words(in_filename, out_filename) do
    # Abrimos el archivo de salida para escribir los resultados
    {:ok, out} = File.open(out_filename, [:write])

    # Escribimos el inicio del archivo HTML
    IO.write(out, """
    <!DOCTYPE html>
    <html>
    <head>
    <title>Tokens</title>
    <link rel="stylesheet" href="/styles.css">
    </head>
    <body>
    <pre>
    """)

    # Leemos el archivo de entrada línea por línea y lo procesamos
    in_filename
    |> File.stream!()
    |> Enum.each(&process_line(&1, out))

    # Escribimos el fin del archivo HTML
    IO.write(out, "</pre>\n</body>\n</html>")

    File.close(out)
  end

  # Función auxiliar para procesar cada línea del archivo de entrada
  defp process_line(line, out) do
    # Verificamos si la línea contiene un comentario
    if Regex.match?(@comment_regex, line) do
      # Reemplazamos todo el comentario con el span del comentario
      line = Regex.replace(@comment_regex, line, fn match -> "<span class=\"comment\">#{match}</span>" end)
      IO.write(out, "#{line}\n")
    else
      # Procesamos la línea en busca de palabras reservadas, variables, cadenas, números y espacios en blanco
      words = String.split(line, ~r/(\W+)/, include_captures: true)

      formatted_line = Enum.map(words, fn word ->
        cond do
          word in @reserved_words ->
            "<span class=\"reserved\">#{word}</span>"
          Regex.match?(@string_regex, word) ->
            "<span class=\"string\">#{word}</span>"
          Regex.match?(@variable_regex, word) ->
            "<span class=\"variable\">#{word}</span>"
          Regex.match?(@number_regex, word) ->
            "<span class=\"number\">#{word}</span>"
          Regex.match?(@whitespace_regex, word) ->
            "<span class=\"whitespace\">#{word}</span>"
          true ->
            word
        end
      end) |> Enum.join("")

      IO.write(out, "#{formatted_line}\n")
    end
  end
end

# Código para leer un solo argumento de línea de comandos
[in_filename] = System.argv()
# Creamos el nombre del archivo de salida
# Agregamos la cadena "-tokens" antes de la extensión del archivo
out_filename = String.replace(in_filename, ~r/(\.\w+$)/, "-tokens.html")
# Llamamos a la función para encontrar palabras reservadas y variables
Tfile.get_reserved_words(in_filename, out_filename)
