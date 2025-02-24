const canvas = document.getElementById("canvas-bg");
const ctx = canvas.getContext("2d");

function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
}
window.addEventListener("resize", resizeCanvas);
resizeCanvas();

// funktion to set RGB colors
function rgb(r, g, b) {
    return `rgb(${Math.round(r)}, ${Math.round(g)}, ${Math.round(b)})`;
}

// sine function for multiple waves
// this function is CPU-intensive! consider optimizing it.
function sinfun(r, t) {
    return (r - 1) * Math.sin(r * 24 + t); // * Math.cos(r * 6 + t);
}

// rotation function to plot the animation in color.
function rotation(width, height, fun) {
    const w2 = Math.floor(width / 2);
    const h2 = Math.floor(height / 2);
    let m, n;

    ctx.clearRect(0, 0, width, height); // clears the canvas for each frame update, but may impact performance.
    
    for (let x = 0; x < w2; x++) {
        let p = Math.floor(Math.sqrt(w2 * w2 - x * x));
        
        for (let v = 0; v < 2 * p; v++) {
            let z = v - p;
            let r = Math.sqrt(x * x + z * z) / w2;
            let q = fun(r, t);
            let y = Math.round(z / 3 + q * h2);
            let color = rgb(r * 255, (1 - r) * 255, 200);

            ctx.fillStyle = color;
            ctx.fillRect(w2 - x, h2 - y, 2, 2);
            ctx.fillRect(w2 + x, h2 - y, 2, 2); // mirroring
        }
    }
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
