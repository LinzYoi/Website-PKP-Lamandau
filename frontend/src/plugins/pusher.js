import Echo from 'laravel-echo';
import Pusher from 'pusher-js';

window.Pusher = Pusher;
window.Echo = new Echo({
  broadcaster: 'pusher',
  key: 'ea8e967b611c56361419',  // Ganti dengan app key milikmu
  cluster: 'ap1',
  forceTLS: true
});