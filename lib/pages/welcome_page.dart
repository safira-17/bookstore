import 'package:flutter/material.dart';
import 'package:bookstore_app/pages/home_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg', 
            fit: BoxFit.cover,
          ),

          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          Center(
            child: _isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 20),
                      AnimatedOpacity(
                        opacity: _isLoading ? 1.0 : 0.0,
                        duration: Duration(seconds: 1),
                        child: Text(
                          "Loading...",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome to Bookstore App!",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Animated Fade-in Text
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(seconds: 2),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: child,
                          );
                        },
                        child: Text(
                          "Discover your favorite books here!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ),

                      SizedBox(height: 40),

                      // Custom Elevated Button
                      ElevatedButton(
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), 
    );
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    backgroundColor: Colors.deepPurple, // Warna tombol
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: Text(
    "Enter",
    style: TextStyle(fontSize: 18, color: Colors.white),
  ),
),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
