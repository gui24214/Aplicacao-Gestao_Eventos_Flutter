import 'package:flutter/material.dart';
import 'controllers/login.dart';

void main() {
  runApp(UniconnectApp());
}

class UniconnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexScreen(),
    );
  }
}

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF4E4A1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              Text(
                'Uniconnect',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'LOADING',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
