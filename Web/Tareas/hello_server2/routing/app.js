"use strict";

import express from "express";

const app = express();

const port = 5000;

app.use(express.json());

let cartas = [ 
    { "id": 1, "nombre": "Espada", "tipo": "Arma", "ataque": 20 },
    { "id": 2, "nombre": "Curación", "tipo": "Consumible", "cura": 30 },
    { "id": 3, "nombre": "Dragón", "tipo": "Criatura", "ataque": 50, "defensa": 30 }
];

app.get("/api/cartas", (req, resp) => {
    if (cartas.length === 0) {
        resp.status(404).json({ mensaje: "No hay cartas almacenadas." });
    } else {
        resp.status(200).json(cartas);
    }
});

app.get("/api/cartas/:id", (req, resp) => {
    const cartaId = parseInt(req.params.id);

    const carta = cartas.find((c) => c.id === cartaId);

    if (carta) {
        resp.status(200).json(carta);
    } else {
        resp.status(404).json({ mensaje: "La carta no existe." });
    }
});

app.post("/api/cartas", (req, resp) => {
    const nuevaCarta = req.body;

    if (!nuevaCarta.id || !nuevaCarta.nombre || !nuevaCarta.tipo) {
        resp.status(400).json({ mensaje: "Faltan atributos en la carta." });
        return;
    }

    if (cartas.some((c) => c.id === nuevaCarta.id)) {
        resp.status(400).json({ mensaje: "La carta ya existe en la lista." });
        return;
    }

    cartas.push(nuevaCarta);
    resp.status(201).json({ mensaje: "Carta agregada correctamente." });
});


app.delete("/api/cartas/:id", (req, resp) => {
    const cartaId = parseInt(req.params.id);

    const cartaIndex = cartas.findIndex((c) => c.id === cartaId);

    if (cartaIndex !== -1) {
        cartas.splice(cartaIndex, 1);
        resp.status(200).json({ mensaje: "Carta eliminada correctamente." });
    } else {
        resp.status(404).json({ mensaje: "La carta no existe." });
    }
});

app.put("/api/cartas/:id", (req, resp) => {
    const cartaId = parseInt(req.params.id);
    const camposActualizar = req.body;

    const carta = cartas.find((c) => c.id === cartaId);

    if (carta) {
        Object.assign(carta, camposActualizar);
        resp.status(200).json({ mensaje: "Carta actualizada correctamente." });
    } else {
        resp.status(404).json({ mensaje: "La carta no existe." });
    }
});

app.listen(port, () => {
    console.log(`Escuchando en el puerto ${port}`);
});
