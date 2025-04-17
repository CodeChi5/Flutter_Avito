import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/user/blocs/ask_login_bloc.dart';
import 'package:myapp/user/blocs/ask_login_event.dart';
import 'package:myapp/user/blocs/ask_login_state.dart';
import 'package:myapp/user/views/RegisterPage.dart';
import 'package:myapp/user/views/widgets/UniformButtonsColumn.dart';

class AskLoginView extends StatelessWidget {
  const AskLoginView({super.key});

  void _showSamplePopup(BuildContext context, AskLoginBloc bloc) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: UniformButtonsColumn(
            onGooglePressed: (ctx) {
              Navigator.of(dialogContext).pop();
              bloc.add(AskLoginGooglePressed());
            },
            onPhoneEmailPressed: (ctx) {
              Navigator.of(dialogContext).pop();
              bloc.add(AskLoginPhoneEmailPressed());
            },
            onRegisterPressed: (ctx) {
              bloc.add(AskLoginRegisterPressed());
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AskLoginBloc(),
      child: BlocConsumer<AskLoginBloc, AskLoginState>(
        listener: (context, state) {
          if (state is AskLoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<AskLoginBloc>();

          if (state is AskLoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AskLoginSuccess) {
            if (state.isGoogleLogin || state.isRegister) {
              return WillPopScope(
                onWillPop: () async {
                  bloc.resetState();
                  return true;
                },
                child: const UserRegisterPage(),
              );
            } else if (state.isPhoneEmailLogin) {
              return const Center(child: Text('Phone/Email Login Mode'));
            }
          }

          // Initial state
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Row - Image
                Image.asset(
                  'assets/login_image_1.png',
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
                    onPressed: () => _showSamplePopup(context, bloc),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(68, 51, 255, 1),
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Log in or register',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 66, 255, 19),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
