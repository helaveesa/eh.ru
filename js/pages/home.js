$(document).ready(function () {
    // Start Stream Counter
    streamCounter.init('#stream-counter h2 em', 40);
    setInterval(function () { streamCounter.increment() }, streamCounter.timeStep * 1000);
});

var streamCounter = {
    streamsPerSecond: 440,
    timeStep: 1,
    streams: 0,
    element: undefined,
    init: function (el, time) {
        this.timeStep = time / 1000;
        this.element = el;
        this.streams = this.streamsPerSecond * ((new Date() - new Date(2012, 0, 1)) / 1000);
        this.output();
    },
    increment: function () {
        this.streams += this.streamsPerSecond * this.timeStep;
        this.output();
    },
    output: function () {
        $(this.element).text(Math.floor(this.streams).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }
}
