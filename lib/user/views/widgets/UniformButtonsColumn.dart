import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

class UniformButtonsColumn extends StatelessWidget {
  final void Function(BuildContext context) onGooglePressed;
  final void Function(BuildContext context) onPhoneEmailPressed;
  final void Function(BuildContext context) onRegisterPressed;
  const UniformButtonsColumn({
    super.key,
    required this.onGooglePressed,
    required this.onPhoneEmailPressed,
    required this.onRegisterPressed,
  });

  // Reusable uniform button widget
  Widget _buildUniformButton({
    required String text,
    required void Function() onPressed,
    IconData? icon,
    double iconSize = 25,
    double textSize = 13,
    Color textColor = Colors.white,
    Color backgroundColor = const Color.fromARGB(215, 0, 0, 0),
    double width = 250,
    double height = 50,
    double borderRadius = 10,
    double? iconSpacing,
  }) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: textColor,
                size: iconSize,
              ),
            if (icon != null) SizedBox(width: iconSpacing ?? 10),
            Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Google login button
          _buildUniformButton(
            text: 'Login with Google',
            icon: BootstrapIcons.google,
            onPressed: () => onGooglePressed(context),
          ),

          const SizedBox(height: 20),

          // Phone/Email login button
          _buildUniformButton(
            text: 'Login with phone or email',
            onPressed: () => onPhoneEmailPressed(context),
          ),

          const SizedBox(height: 20),

          // Register button
          _buildUniformButton(
            text: 'Register',
            onPressed: () => onRegisterPressed(context),
          ),
        ],
      ),
    );
  }
}
