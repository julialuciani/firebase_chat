import 'dart:io';

import 'package:firebase_chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

import 'package:firebase_chat/screens/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignUp) {
      return _showError("Image not selected");
    }
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _formData.isSignUp
              ? UserImagePicker(onImagepick: _handleImagePick)
              : const SizedBox.shrink(),
          _formData.isSignUp
              ? TextFormField(
                  key: const ValueKey("name"),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (name) {
                    name = name ?? "";
                    if (name.trim().length < 5) {
                      return "Name has to be at least 5 characters long";
                    }
                    return null;
                  },
                )
              : const SizedBox.shrink(),
          TextFormField(
            key: const ValueKey("email"),
            initialValue: _formData.email,
            onChanged: (email) => _formData.email = email,
            decoration: const InputDecoration(
              label: Text("Email"),
            ),
            validator: (email) {
              email = email ?? "";
              if (!email.contains("@")) {
                return "Email is not valid";
              } else if (email.length < 5) {
                return "Email is not valid";
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: _formData.password,
            onChanged: (password) => _formData.password = password,
            key: const ValueKey("password"),
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
            validator: (password) {
              password = password ?? "";
              if (password.length < 8) {
                return "Your passowrd is too short";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                _formData.toggleAuthMode();
              });
            },
            child: Text(_formData.isLogin ? "Create an account" : "Login"),
          ),
          ElevatedButton(
            onPressed: () {
              _submit();
            },
            child: Text(_formData.isLogin ? "Login" : "Register"),
          ),
        ],
      ),
    );
  }
}
