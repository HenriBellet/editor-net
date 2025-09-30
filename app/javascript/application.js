function initHoverVideos() {
  document.querySelectorAll('video.hover-play').forEach((v) => {
    const play = () => v.play().catch(() => {});
    const stop = () => { v.pause(); v.currentTime = 0; };

    v.addEventListener('mouseenter', play);
    v.addEventListener('mouseleave', stop);
    v.addEventListener('focus', play);  // keyboard
    v.addEventListener('blur',  stop);

    // Optional: tap to toggle on touch devices
    v.addEventListener('click', () => (v.paused ? v.play() : v.pause()));
  });
}

// Work with Turbo (Rails 7) and plain DOM
document.addEventListener('turbo:load', initHoverVideos);
document.addEventListener('DOMContentLoaded', initHoverVideos);
