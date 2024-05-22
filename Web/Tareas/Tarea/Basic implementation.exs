# Isaac Shakalo
# 12/04/24
# Basic implementation Finite Automatons

# The automata argument is expressed:{delta, accept, q0}


# Función principal para el análisis léxico de expresiones aritméticas
defmodule DFA do
def arithmetic_lexer(input_string) do
  automata = {&TokenList.delta_arithmetic/2, [:int, :float, :var, :exp, :int_space, :float_space, :par_close, :varspace, :par_close_space], :start}
  input_string
  |> tokenize_string()
end

def eval_dfa([], {_delta, accept, state}, tokens, info) do
  cond do
    Enum.member?(accept, state) == true ->cond do
      state == :varspace -> [{:var, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
      state == :int_space -> [{:int, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
      state == :par_close_space -> [{:par_close, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
      state == :float_space -> [{:float, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
      true -> [{state, Enum.reverse(info) |> Enum.join("")} | tokens] |> Enum.reverse()
    end
    true -> false
    end
end


# Función para evaluar el autómata finito y generar tokens
defp tokenize_string(string) do
  string
  |> String.graphemes()
  |> eval_dfa(automata, [], [])
end

# Función de transición para el autómata finito
def delta_arithmetic(current_state, current_char) do
  case current_state do
    :start ->
       cond do
        current_char == " " -> [:start, false]
        is_sign(current_char) -> [:sign, false]
        is_digit(current_char) -> [:int, false]
        is_alpha(current_char) -> [:var, false]
        current_char == "(" -> [:par_open, false]
        true -> [:fail, false]
      end
  end
end


# Función para evaluar el autómata finito y generar tokens
def eval_dfa([char | tail], {delta, accept, state}, tokens, info) do
[new_state, found] = delta.(state, char) 

update_info = if char != " " do
  [char | info]
else
  info
end

def eval_dfa([current_char | remaining_chars], {delta, accept, current_state}, tokens, info) do
      # Call the delta function with the current state and character
      [new_state, found] = delta.(current_state, current_char)

      updated_info =
        if current_char != " " do
          [current_char | info]
        else
          info
        end

  cond do
    found == false ->
      eval_dfa(remaining_chars, {delta, accept, new_state}, tokens, update_info)
    true ->
      updated_tokens = [{found, Enum.reverse(tl(updated_info)) |> Enum.join("")} | tokens]
      eval_dfa(remaining_chars, {delta, accept, new_state}, updated_tokens, [hd(updated_info)])
  end

# Maneja la formación de números enteros y sus transiciones.
:int ->
cond do
  is_digit(char) -> [:int, false]
  char == " " -> [:int_space, false]
  char in ["e", "E"] -> [:e, false]
  is_operator(char) -> [:oper, :int]
  char == "." -> [:dot, false]
  char == ")" -> [:par_close, :int]
  true -> [:fail, false]
end

# Maneja el exponente en notación científica y sus transiciones.
:e ->
    case {is_sign(char), is_digit(char)} do
    {true, _} -> [:sign_exp, false]
    {_, true} -> [:exp, false]
    _-> [:fail, false]
end

# Maneja el signo del exponente en notación científica.

:sign_exp -> 
if is_digit(char) do
  [:exp, false]
else
  [:fail, false]
end

# Maneja el exponente y sus transiciones.
:exp -> 
cond do
  is_digit(char) -> [:exp, false]
  is_operator(char) -> [:oper, :exp]
  true -> [:fail, false]
end

# Maneja el punto decimal y sus transiciones.
:dot -> 
cond do
  is_digit(char) -> [:float, false]
  true -> [:fail, false]
end

# Maneja la formación de números decimales y sus transiciones.
:float -> 
cond do
  is_digit(char) -> [:float, false]
  char == " " -> [:float_space, false]
  is_operator(char) -> [:oper, :float]
  char == ")" -> [:par_close, :float]
  true -> [:fail, false]
end

# Maneja la formación de variables y sus transiciones.
:var -> 
cond do
 is_alpha(char) -> [:var, false]
 char == " " -> [:varspace, false]
 is_operator(char) -> [:oper, :var]
 is_digit(char) -> [:var, false]
 is_sign(char) -> [:sign, :var]
 char == ")" -> [:par_close, :var]
 true -> [:fail, false]
end

# Maneja operadores y sus transiciones.
:oper -> cond do
  is_sign(char) -> [:sign, :oper]
  is_alpha(char) -> [:var, :oper]
  char == " " -> [:operatorspace, false]
  char == "(" -> [:par_open, :oper]
  is_digit(char) -> [:int, :oper]
  true -> [:fail, false]
end

# Maneja la apertura de paréntesis y sus transiciones.
:paropen -> 
cond do
  char == "(" -> [:paropen, :par_open]
  char == " " -> [:paropen_space, false]
  is_alpha(char) -> [:var, :par_open]
  is_digit(char) -> [:int, :par_open]
  is_sign(char) -> [:sign, :par_open]
  true -> [:fail, false]
end

# Maneja el cierre de paréntesis y sus transiciones.
:par_close -> 
cond do
  char == ")" -> [:par_close, :par_close]
  char == " " -> [:par_close_space, false]
  is_operator(char) -> [:oper, :par_close]
  is_sign(char) -> [:sign, :par_close]
  true -> [:fail, false]
end

# Maneja espacios en números enteros y sus transiciones.
:int_space -> 
cond do
  char == " " -> [:int_space, false]
  is_operator(char) -> [:oper, :int]
  is_sign(char) -> [:sign, :int]
  true -> [:fail, false]
end

# Maneja espacios en signos y sus transiciones.
:sign_space -> 
cond do
  char == " " -> [:sign_space, false]
  is_digit(char) -> [:int, false]
  true -> [:fail, false]
end

# Maneja espacios en operadores y sus transiciones.
:operatorspace -> 
cond do
  char == " " -> [:operatorspace, false]
  is_sign(char) -> [:sign, :oper]
  is_digit(char) -> [:int, :oper]
  is_alpha(char) -> [:var, :oper]
  char == "(" -> [:par_open, :oper]
  true -> [:fail, false]
end

# Maneja espacios en el cierre de paréntesis y sus transiciones.
:parclose_space -> 
cond do
  char == " " -> [:parclose_space, false]
  is_operator(char) -> [:oper, :par_close]
  is_sign(char) -> [:sign, :par_close]

  true -> [:fail, false]
end

# Maneja espacios en la apertura de paréntesis y sus transiciones.
:paropen_space -> 
cond do
  char == " " -> [:paropen_space, false]
  is_sign(char) -> [:sign, :par_open]
  is_digit(char) -> [:int, :par_open]
  is_alpha(char) -> [:var, :par_open]
  true -> [:fail, false]
end

# Maneja espacios en variables y sus transiciones.
:varspace -> 
cond do
  char == " " -> [:varspace, false]
  is_operator(char) -> [:oper, :var]
  is_sign(char) -> [:sign, :var]
  char == ")" -> [:par_close, :var]
  true -> [:fail, false]
end

# Maneja espacios en números decimales y sus transiciones.
:float_space -> 
cond do
  char == " " -> [:float_space, false]
  is_operator(char) -> [:oper, :float]
  is_sign(char) -> [:sign, :float]
  true -> [:fail, false]
end

# Maneja signos y sus transiciones.
:sign -> cond do
  is_digit(char) -> [:int, false]
  char == " " -> [:sign_space, false]
  true -> [:fail, false]
end

      :fail -> [:fail, false]
    end
  end

#condiciones de transición de estado del autómata
  def is_sign(char) do
    Enum.member?(["+", "-"], char)
  end

  def is_digit(char) do
    "0123456789"
    |> String.graphemes()
    |> Enum.member?(char)
  end

  def is_operator(char) do
    Enum.member?(["+", "-", "*", "/", "%", "=", "^"], char)
  end

  def is_alpha(char) do
  uppercase = ?A..?Z |> Enum.map(&<<&1::utf8>>)
    lowercase = ?a..?z |> Enum.map(&<<&1::utf8>>)
    Enum.member?(lowercase ++ uppercase ++ ["_"], char)
  end
end