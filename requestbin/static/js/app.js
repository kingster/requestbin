function toggleHovercard(id) {
    event.preventDefault();
    var hovercard = document.getElementById('hovercard-' + id);
    hovercard.style.display = ( hovercard.style.display === 'none' || hovercard.style.display == '' ) ? 'block' : 'none';
}

function copyToClipboard(id) {
    var hovercard = document.getElementById('hovercard-' + id);
    var text = hovercard.querySelector('.code-preview').innerText;
    navigator.clipboard.writeText(text);
}
