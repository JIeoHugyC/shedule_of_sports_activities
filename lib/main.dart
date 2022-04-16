import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    var auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: 'Leonid999@yandex.ru', password: 'Nvnbrla2p1')
        .then((value) => print(value))
        .catchError((onError) => print (onError));


    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .add({
      'full_name': 'Tatiana', // John Doe
      'company': 'MyOrg', // Stokes and Sons
      'age': '25' // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    setState(() {
      _counter++;
    });

  }

  void auth() async{
    try {
      var user1 = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: 'Leonid999@yandex.ru', password: 'Nvnbrla2p1');
      print('logined in');
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Name, email address, and profile photo URL
        final name = user.displayName;
        final email = user.email;
        final photoUrl = user.photoURL;

        // Check if user's email is verified
        final emailVerified = user.emailVerified;

        // The user's ID, unique to the Firebase project. Do NOT use this value to
        // authenticate with your backend server, if you have one. Use
        // User.getIdToken() instead.
        final uid = user.uid;
        user.getIdToken().then((value) => print(value));
      }
    }
    catch (error) {
      print(error);
      var user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: 'Leonid999@yandex.ru', password: 'Nvnbrla2p');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


