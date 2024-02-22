function hackerSpeak(cadena) {
    const letrasHacker = {
      a: "4",
      e: "3",
      i: "1",
      o: "0",
      s: "5",
    };
  
    let cadenaHacker = "";
    for (let i = 0; i < cadena.length; i++) {
      const letra = cadena[i].toLowerCase();
      if (letrasHacker.hasOwnProperty(letra)) {
        cadenaHacker += letrasHacker[letra];
      } else {
        cadenaHacker += letra;
      }
    }

    return cadenaHacker;
  }
  const fraseOriginal = "Javascript es divertido";
  const fraseHacker = hackerSpeak(fraseOriginal);
  console.log(fraseHacker); 
  