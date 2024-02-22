function capitalizarPrimerasLetras(string) {

    var palabras = string.split(' ');
    var resultado = palabras.map(function (palabra) {
        return palabra.charAt(0).toUpperCase() + palabra.slice(1);
    });

    return resultado.join(' ');
}
var textoOriginal = "hola soy isaac";
var textoCapitalizado = capitalizarPrimerasLetras(textoOriginal);
console.log(textoCapitalizado);
