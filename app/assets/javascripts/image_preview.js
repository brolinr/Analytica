document.addEventListener('DOMContentLoaded', function() {
    const imageInput = document.querySelector('#image-input');
    const imagePreview = document.querySelector('.image-preview');

    imageInput.addEventListener('change', function() {
        const selectedFile = imageInput.files[0];
        if (selectedFile) {
            const imageUrl = URL.createObjectURL(selectedFile);
            imagePreview.innerHTML = `<img src="${imageUrl}" class="bd-placeholder-img rounded-top img-fluid" width="100%">`;
        } else {
            imagePreview.innerHTML = ''; // Clear preview if no file selected
        }
    });
});