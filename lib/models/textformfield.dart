import 'dart:async';
import 'package:flutter/material.dart';

class EmailFormField extends StatefulWidget {
  EmailFormField({Key? key}) : super(key: key);

  @override
  State<EmailFormField> createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  Timer? debounce;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailValid = true;
  bool _passwordValid = true;
  bool _isPasswordVisible = false;
  String password = '';
  String email = '';

  @override
  void dispose() {
    debounce?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  hintText: 'yourEmail@example.com',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      )),
                  suffixIcon: _emailController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => _emailController.clear(),
                        ),
                  errorText: _emailValid ? null : 'Please enter a valid email',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                ),
                onFieldSubmitted: (value) => setState(() {
                  ///ketika klik done dipojok keyboard
                  this.email = value;
                }),
                onChanged: (String value) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce = Timer(Duration(milliseconds: 500), () {
                    setState(() {
                      _emailValid = validateEmail(value) == null;
                      this.email = value;
                    });
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: _isPasswordVisible,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  suffixIcon: IconButton(
                      icon: _isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () => setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          })),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      )),
                  errorText: _passwordValid
                      ? null
                      : 'Password must be at least 8 characters long',
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.red,
                      )),
                ),
                onFieldSubmitted: (value) => setState(() {
                  this.password = value;
                }),
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce = Timer(Duration(milliseconds: 500), () {
                    setState(() {
                      _passwordValid = validatePassword(value) == null;
                      this.password = value;
                    });
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () {
              setState(() {
                _emailController.clear();
                _passwordController.clear();
              });
            },
          )
        ],
      ),
    );
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
