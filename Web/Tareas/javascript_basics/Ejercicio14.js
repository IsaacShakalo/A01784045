function esPotenciaDeDos(numero) {
    
    if (numero < 1) {
      return false;
    }

    while (numero % 2 === 0) {
      numero /= 2;
    }

    return numero === 1;
  }

  console.log(esPotenciaDeDos(8)); 
  console.log(esPotenciaDeDos(15)); 
  