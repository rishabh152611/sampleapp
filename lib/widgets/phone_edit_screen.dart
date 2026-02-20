import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/providers/user_provider.dart';

class PhoneEditScreen extends StatefulWidget {
  const PhoneEditScreen({super.key});

  @override
  State<PhoneEditScreen> createState() => _PhoneEditScreenState();
}

class _PhoneEditScreenState extends State<PhoneEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false; // ✅ local loading state

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.userDetails != null) {
      _phoneController.text = userProvider.userDetails!.phone ?? "";
    }
  }

  Future<void> _savePhone() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final success = await userProvider.updatePhone(_phoneController.text);

    setState(() => _isLoading = false);

    if (success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone updated ✅")),
      );
      Navigator.pop(context);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update phone ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Phone Number")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                enabled: !_isLoading, // disable while saving
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number cannot be empty";
                  }
                  if (value.length < 10) {
                    return "Enter a valid phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _savePhone,
                      child: const Text("Save Changes"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
