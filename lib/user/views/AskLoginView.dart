import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/user/blocs/user_bloc.dart';
import 'package:myapp/user/blocs/user_state.dart';
import 'package:myapp/user/data/user_repo.dart';
import 'package:myapp/user/views/RegisterPage.dart';
import 'package:myapp/user/views/widgets/UniformButtonsColumn.dart';

class AskLoginView extends StatefulWidget {
  const AskLoginView({super.key});

  @override
  State<AskLoginView> createState() => _AskLoginViewState();
}

class _AskLoginViewState extends State<AskLoginView> {
  String? _mode; // Can be 'google', 'login', 'register', or null

  void _handleGoogleLogin(BuildContext context) {
    print('Google login pressed');
    Navigator.of(context).pop(); // Close dialog
    setState(() => _mode = 'google');
    // Add Google login logic
  }

  void _handlePhoneEmailLogin(BuildContext context) {
    print('Phone/Email login pressed');

    Navigator.of(context).pop();

    setState(() => _mode = 'login');
    // Add phone/email logic
  }

  void _handleRegister(BuildContext context) {
    print('Register pressed');
    setState(() => _mode = 'register');
    // Add registration logic
  }

  void _showSamplePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: UniformButtonsColumn(
            onGooglePressed: (ctx) => _handleGoogleLogin(ctx),
            onPhoneEmailPressed: (ctx) => _handlePhoneEmailLogin(ctx),
            onRegisterPressed: (ctx) => _handleRegister(ctx),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _mode == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '${_mode}to manage your ads and post new ones.',
                    ),
                  ),
                  // First Row - Image
                  Image.asset(
                    'assets/login_image_1.png', // Replace with your image URL
                    scale: 5,
                  ),

                  // Second Row - Text
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Log in or register to manage your ads and post new ones.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Third Row - Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      onPressed: () => _showSamplePopup(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(68, 51, 255, 1),
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: const Text(
                          'Log in or register',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 66, 255, 19)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : UserRegisterPage());
  }
}
