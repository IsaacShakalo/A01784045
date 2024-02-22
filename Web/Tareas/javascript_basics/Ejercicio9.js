function encontrarLongitudMinima(cadenas) {
    let longitudMinima = Infinity;
    for (const cadena of cadenas) {
      if (cadena.length < longitudMinima) {
        longitudMinima = cadena.length;
      }
    }
    return longitudMinima;
  }
  
  const frases = ["Hola", "mundo", "JavaScript", "es", "genial"];
  const longitudMinima = encontrarLongitudMinima(frases);
  console.log(`La longitud de la cadena más corta es: ${longitudMinima}`);
  