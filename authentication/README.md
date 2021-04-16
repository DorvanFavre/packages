# Authentication

Implement a authentication API in your project

## Getting Started

1. import the authentication dependecie in the **pubspec.yaml** file

```dart
tools:
    git:
      url: https://github.com/DorvanFavre/packages.git
      path: authentication
```

2. also import the Firbase Auth dependecie

```dart
firebase_auth: ^last version
```

3. import the Firebase SDKs and initialize firebase in the **index.html** file

```dart
  <script src="https://www.gstatic.com/firebasejs/8.3.2/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/8.3.2/firebase-auth.js"></script>
  
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

5. In the firebase console**activate Authentication** and enable **Email and password login**
7. In the root project run 

 ```dart
 firebase init
 ```

## Exemple code

comming soon
