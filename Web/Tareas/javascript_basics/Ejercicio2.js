function bubbleSort(arr) {
    var n = arr.length;
  
    for (var i = 0; i < n - 1; i++) {
        for (var j = 0; j < n - i - 1; j++) { 
            if (arr[j] > arr[j + 1]) {
                [arr[j], arr[j + 1]] = [arr[j + 1], arr[j]];
            }
        }
    }
}

// Ejemplo de uso
var miArray = [64, 34, 25, 12, 22, 11, 90];
bubbleSort(miArray);

console.log("Array ordenado:");
console.log(miArray);
