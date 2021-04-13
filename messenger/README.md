# messenger

Implement a messenger API in your project

## Getting Started

1. import the messenger dependecie in the **pubspec.yaml** file

```dart
tools:
    git:
      url: https://github.com/DorvanFavre/packages.git
      path: messenger
```

2. also import the Firestore dependecie

```dart
cloud_firestore: ^last version
```

3. import the Firebase SDKs and initialize firebase in the **index.html** file

```dart
  <script src="https://www.gstatic.com/firebasejs/8.3.2/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-firestore.js"></script>
  
  <script>
    // Your web app's Firebase configuration
    var firebaseConfig = {
      apiKey: XXX,
      authDomain: XXX,
      projectId: XXX,
      storageBucket:XXX,
      messagingSenderId: XXX,
      appId: XXX
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  </script>
  
```

4. Create a Firebase project, add a web app and get the **FirebaseConfiguration** needed above

5. In the firebase console**activate Firestore**
7. In the root project run 

 ```dart
 firebase init
 ```

## Exemple code

comming soon
