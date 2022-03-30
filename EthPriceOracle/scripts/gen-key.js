import { CryptoUtils } from 'loom-js';
import { writeFileSync } from 'fs';

if (process.argv.length <= 2) {
    console.log("Usage: " + __filename + " <filename>.")
    process.exit(1);
}

const privateKey = CryptoUtils.generatePrivateKey()
const privateKeyString = CryptoUtils.Uint8ArrayToB64(privateKey)

let path = process.argv[2]
writeFileSync(path, privateKeyString)