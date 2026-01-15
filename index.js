// ============== Chargement de dotenv dans le fichier principal ============== //
import dotenv from 'dotenv';
dotenv.config();

console.log(process.env.OPENAI_API_KEY ? "CLÉ OK" : "CLÉ MANQUANTE");
