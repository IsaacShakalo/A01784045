function encontrarCadenaMasFrecuente(cadenas) {

    const frecuencia = new Map();
    let cadenaMasFrecuente = null;
    let maxFrecuencia = 0;
    for (const cadena of cadenas) {
      const frecuenciaActual = frecuencia.get(cadena) || 0;
      frecuencia.set(cadena, frecuenciaActual + 1);
      if (frecuenciaActual + 1 > maxFrecuencia) {
        maxFrecuencia = frecuenciaActual + 1;
        cadenaMasFrecuente = cadena;
      }
    }
  
    return cadenaMasFrecuente;
  }
  
  const listaCadenas = ["Hola", "Mundo", "Hola", "JavaScript", "Hola"];
  const cadenaMasFrecuente = encontrarCadenaMasFrecuente(listaCadenas);
  console.log(`Cadena más frecuente: ${cadenaMasFrecuente}`); 
  