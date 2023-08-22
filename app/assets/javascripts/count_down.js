// Function to update countdown for each auction
function updateCountdown(element, deadlineTimestamp) {
    var now = new Date();
    var timeRemaining = deadlineTimestamp - now;

    if (timeRemaining > 0) {
        var days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
        var hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

        element.innerHTML =
            "Expires in: " + days + "d " + hours + "Hrs " + minutes + "Min " + seconds + "Sec";
    } else {
        element.innerHTML = "Auction has ended";
    }
}

// Loop through each countdown element
document.querySelectorAll("#auction-countdown").forEach(function (element) {
    var deadlineTimestamp = new Date(element.getAttribute("data-deadline"));
    updateCountdown(element, deadlineTimestamp);

    // Update countdown every second
    setInterval(function () {
        updateCountdown(element, deadlineTimestamp);
    }, 1000);
});