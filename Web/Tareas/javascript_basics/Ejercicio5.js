function mcd(a, b) {
    // Si b es 0, el MCD es a
    if (b === 0) {
      return a;
    }
  
    while (b !== 0) {
      const resto = a % b;
      a = b;
      b = resto;
    }
    return a;
  }
  
  const num1 = 12;
  const num2 = 13;
  const mcdResultado = mcd(num1, num2);
  console.log(`El MCD de ${num1} y ${num2} es: ${mcdResultado}`); 

  