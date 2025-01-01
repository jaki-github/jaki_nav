window.addEventListener('message', function(event) {
    const data = event.data;
    const hud = document.getElementById('hud');
    if (data.show !== undefined) {
        hud.style.display = data.show ? 'flex' : 'none';
    }
    const street = data.street && data.street !== 'Unknown' ? data.street : 'Okänd plats';
    const crossing = data.crossing && data.crossing !== 'Unknown' ? ` x ${data.crossing}` : '';
    updateTextWithFade('street', street + crossing);

    // Hantera zone och direction med övergång
    updateTextWithFade('zone', data.zone || 'Okänt område');
    updateTextWithFade('direction', data.direction || 'N/A');

    if (data.position) {
        moveHUD(data.position.top, data.position.left);
    }
});
function updateTextWithFade(elementId, newText) {
    const element = document.getElementById(elementId);
    if (element.textContent === newText) return;
    element.classList.add('fade-out');
    setTimeout(() => {
        element.textContent = newText;
        element.classList.remove('fade-out');
    }, 300);
}
function moveHUD(newTop, newLeft) {
    const hud = document.getElementById('hud');
    hud.style.transform = `translate(${newLeft}px, ${newTop}px)`;
}
