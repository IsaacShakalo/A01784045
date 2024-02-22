function calcularMedianaYModa(lista) {

    lista.sort(function(a, b) {
        return a - b;
    });

    var mediana;
    var longitud = lista.length;

    if (longitud % 2 === 0) {
        
        mediana = (lista[longitud / 2 - 1] + lista[longitud / 2]) / 2;
    } else {
       
        mediana = lista[Math.floor(longitud / 2)];
    }


    var frecuencia = {};
    var moda = [];
    var maxFrecuencia = 0;

    for (var i = 0; i < longitud; i++) {
        var numero = lista[i];
        frecuencia[numero] = (frecuencia[numero] || 0) + 1;

        if (frecuencia[numero] > maxFrecuencia) {
            maxFrecuencia = frecuencia[numero];
            moda = [numero];
        } else if (frecuencia[numero] === maxFrecuencia && moda.indexOf(numero) === -1) {
            moda.push(numero);
        }
    }

    return { mediana: mediana, moda: moda };
}

var listaNumeros = [3, 1, 4, 1, 5, 9, 2];
var resultado = calcularMedianaYModa(listaNumeros);
console.log("Mediana:", resultado.mediana);
console.log("Moda:", resultado.moda);
