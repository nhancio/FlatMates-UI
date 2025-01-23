// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyB9HiuiUTT1-nNF8xJOTeMLCiGy7tfRwsQ",
  authDomain: "homemates-app.firebaseapp.com",
  projectId: "homemates-app",
  storageBucket: "homemates-app.firebasestorage.app",
  messagingSenderId: "399242916006",
  appId: "1:399242916006:web:c4e39c656426fd970c8467",
  measurementId: "G-B9091B95VE"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);