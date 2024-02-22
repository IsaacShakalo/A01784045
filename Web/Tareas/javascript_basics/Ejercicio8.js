function quitarDuplicados(arreglo) {
    const elementosUnicos = new Set(arreglo);
    return Array.from(elementosUnicos);
  }
  const numeros = [1, 0, 1, 1, 0, 0];
  const numerosSinDuplicados = quitarDuplicados(numeros);
  console.log(numerosSinDuplicados);
  