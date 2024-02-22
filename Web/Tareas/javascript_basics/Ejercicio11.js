function ordenarAlfabeticamente(cadenas) {
    return cadenas.sort((a, b) => a.localeCompare(b));
  }
  
  const nombres = ["Ana", "Pedro", "María", "Juan", "Camila"];
  const nombresOrdenados = ordenarAlfabeticamente(nombres);
  console.log(nombresOrdenados); 
