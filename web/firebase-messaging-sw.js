importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js");

// Your web app's Firebase configuration
var firebaseConfig = {
  apiKey: "AIzaSyAAN82DwdO5v3x7TBgemToctFTd_s13Irc",
  authDomain: "bierverkostung-a585f.firebaseapp.com",
  projectId: "bierverkostung-a585f",
  storageBucket: "bierverkostung-a585f.appspot.com",
  messagingSenderId: "66227538668",
  appId: "1:66227538668:web:e00b056f002db5c33c73c9"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});