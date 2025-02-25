const canvas = document.getElementById("canvas-bg");
const ctx = canvas.getContext("2d");

function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
}
window.addEventListener("resize", resizeCanvas);
resizeCanvas();

// sine function for multiple waves
// this function is CPU-intensive! consider optimizing it.
function sinfun(r, t) {
    return (r - 1) * Math.sin(r * 24 + t); // * Math.cos(r * 6 + t);
}

// optimized rotation function using ImageData API. It's better but also CPU-intensive
function rotation(width, height, fun, t) {
    const w2 = Math.floor(width / 2);
    const h2 = Math.floor(height / 2);

    const imageData = ctx.createImageData(width, height);
    const data = imageData.data;

    for (let x = 0; x < w2; x++) {
        let p = Math.floor(Math.sqrt(w2 * w2 - x * x));

        for (let z = -p; z < p; z++) {
            let radius = Math.sqrt(x * x + z * z) / w2;
            let q = fun(radius, t);
            let y = Math.round(z / 3 + waveOffset * h2);

            let r = Math.round(radius * 255);
            let g = Math.round((1 - radius) * 255);
            let b = 200;

            setPixel(data, w2 - x, h2 - y, width, r, g, b, 255);
            setPixel(data, w2 + x, h2 - y, width, r, g, b, 255); // mirroring 
        }
    }

    ctx.putImageData(imageData, 0, 0); // Draw everything at once
}

// function to set a pixel in ImageData
function setPixel(data, x, y, width, r, g, b, a) {
    if (x < 0 || x >= width || y < 0 || y >= data.length / (width * 4)) return;
    let index = (y * width + x) * 4;
    data[index] = r;
    data[index + 1] = g;
    data[index + 2] = b;
    data[index + 3] = a;
}

// animation loop
let t = 0;
function animate() {
    rotation(canvas.width, canvas.height, sinfun, t);
    t += 0.05;
    requestAnimationFrame(animate);
}
animate();

console.log("Background script loaded!");
