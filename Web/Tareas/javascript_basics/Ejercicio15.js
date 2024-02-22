function ordenarDescendente(numeros) {
  
    const numerosCopia = [...numeros];
  
    
    numerosCopia.sort((a, b) => b - a);
  
    return numerosCopia;
  }
  
  const listaNumeros = [1, 5, 3, 2, 4];
  const listaOrdenadaDescendente = ordenarDescendente(listaNumeros);
  console.log(listaOrdenadaDescendente); 
  