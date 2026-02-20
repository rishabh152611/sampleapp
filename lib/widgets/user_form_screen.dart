import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/home_scren.dart';
import '../secrets.dart';

class UserFormScreen extends StatefulWidget {
  final String userId;
  const UserFormScreen({super.key, required this.userId});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  bool isSubmitting = false;

  Future<void> submitUserDetails() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => isSubmitting = true);

    try {
      final url = Uri.parse('$baseurl/user');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": widget.userId,
          "name": name,
          "email": email,
          "phone": phone,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScren()),
        );
      } else {
        throw Exception('Failed to add user');
      }
    } catch (e) {
      print('Error adding user: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save user')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Enter your name' : null,
                onSaved: (val) => name = val ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Enter your email' : null,
                onSaved: (val) => email = val ?? '',
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Enter your phone number'
                            : null,
                onSaved: (val) => phone = val ?? '',
              ),
              const SizedBox(height: 20),
              isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: submitUserDetails,
                    child: const Text('Submit'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
