import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/user/blocs/user_bloc.dart';
import 'package:myapp/user/blocs/user_state.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isCodeSent = false;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    if (!_isCodeSent) {
      BlocProvider.of<UserBLoc>(context)
          .SendCodeRegisterUser(UserTrigerState(phone: _phoneController.text));
      // Simulate API call to send code
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isCodeSent = true;
        _isLoading = false;
      });
    } else {
      print("else----------------");
      BlocProvider.of<UserBLoc>(context).VerifyCodeRegisterUser(
          UserCodeTrigerState(
              phone: _phoneController.text, code: _codeController.text));
      // Simulate code verification
      /*    await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context); // Close after successful verification*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isCodeSent ? 'Enter Verification Code' : ' Enter Phone Login',
                style: Theme.of(context).primaryTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _isCodeSent ? _buildCodeField() : _buildPhoneNumberField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        _isCodeSent ? 'Verify Code' : 'Send Code',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.white), // Input text color
      cursorColor: Colors.white, // Cursor color
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
        _RussianPhoneFormatter(),
      ],
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: const TextStyle(color: Colors.white), // Label color
        hintText: '7XXXXXXXXXX',
        hintStyle: const TextStyle(color: Colors.white54), // Hint color
        prefix: const Text(
          '+',
          style: TextStyle(color: Colors.white), // Prefix color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: const TextStyle(color: Colors.white), // Error text color
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter phone number';
        if (value.length != 11) return 'Invalid Russian phone number';
        if (!value.startsWith('7')) return 'Should start with 7';
        return null;
      },
    );
  }

  Widget _buildCodeField() {
    return TextFormField(
      controller: _codeController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: InputDecoration(
        labelText: 'Verification Code',
        labelStyle: const TextStyle(color: Colors.white),
        hintText: 'Enter 5-digit code',
        hintStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: const TextStyle(color: Colors.white),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter code';
        if (value.length != 6) return 'Code must be 5 digits';
        return null;
      },
    );
  }
}

class _RussianPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.startsWith('7')) {
      text = text.substring(1);
      text = '7$text';
    } else if (text.isNotEmpty && !text.startsWith('7')) {
      text = '7$text';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
