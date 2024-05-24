// Define variables and constants
let x = 5;
const PI = 3.14;

// Arithmetic operations
let y = x + 3;
let z = x * y;

// String manipulation
let message = "Hello, ";
let name = "John";
let greeting = message + name;

// Conditional statements
if (x > 0) {
    console.log("x is positive");
} else if (x === 0) {
    console.log("x is zero");
} else {
    console.log("x is negative");
}

// Loops
for (let i = 0; i < 5; i++) {
    console.log("Iteration", i);
}

// Arrays
let numbers = [1, 2, 3, 4, 5];
console.log("Third element of the array:", numbers[2]);

// Functions
function add(a, b) {
    return a + b;
}

let sum = add(2, 3);
console.log("Sum:", sum);

// Objects
let person = {
    name: "Alice",
    age: 30,
    isStudent: true
};

console.log("Name:", person.name);
console.log("Age:", person.age);
console.log("Is student?", person.isStudent);
