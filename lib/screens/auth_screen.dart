import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  void _submit() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_isLogin) {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } else {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 12),
            ElevatedButton(onPressed: _submit, child: Text(_isLogin ? 'Login' : 'Signup')),
            TextButton(onPressed: () { setState(() { _isLogin = !_isLogin; }); }, child: Text(_isLogin ? 'Create new account' : 'I already have an account'))
          ],
        ),
      ),
    );
  }
}
