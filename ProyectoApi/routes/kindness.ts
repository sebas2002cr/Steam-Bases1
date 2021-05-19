import * as express from 'express';
const app = express();

const saludos = ["hola", "buen día","pura vida", "matice", "pasela ak 6+1", "buena vibra"];

app.get("/regiterUser", (req, res,next) => {
    res.json({ message: saludos[Math.trunc(Math.random()*saludos.length)]});
});

app.post("/saludarTo", (req, res,next) => {
    if(req.query.filter)
    res.json({ message: saludos[Math.trunc(Math.random()*saludos.length)]+ " "+req.body.quien});
});

export { app as kindnessrouter };