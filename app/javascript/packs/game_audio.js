
const audio = document.getElementById("audio_src");
window.addEventListener('DOMContentLoaded', (event) => {
  audio.play()
});

const newGameBtn = document.getElementById('game_btn');
newGameBtn.addEventListener('click', function (event) {
  let sonic_sound = document.getElementById("bubble_sound");
  sonic_sound.play()
});

const userForm = document.getElementById('user-form');
userForm.addEventListener('submit', function (event) {
  let sonic_sound = document.getElementById("bubble_sound");
  sonic_sound.play()
});
