function factorizar(numero) {
    const factores = [];
    for (let i = 1; i <= Math.sqrt(numero); i++) {
      if (numero % i === 0) {
        factores.push(i);
        if (i !== numero / i) {
          factores.push(numero / i);
        }
      }
    }
    return factores.sort((a, b) => a - b);
  }

  const num = 12;
  const factoresEncontrados = factorizar(num);
  console.log(`Los factores de ${num} son: ${factoresEncontrados}`); 
  