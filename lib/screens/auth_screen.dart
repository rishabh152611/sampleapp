import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clerk_auth/clerk_auth.dart' as clerk;
import 'package:clerk_flutter/clerk_flutter.dart';

import '../main.dart';
import '../services/auth_service.dart';


class CustomAuthScreen extends StatefulWidget {
  /// Static method to dispose the ClerkAuth listener externally (e.g., on logout)
  static void disposeClerkListener() {
    _CustomAuthScreenState._currentInstance?._disposeClerkListenerInternal();
  }
  const CustomAuthScreen({super.key});

  @override
  State<CustomAuthScreen> createState() => _CustomAuthScreenState();
}

class _CustomAuthScreenState extends State<CustomAuthScreen> {
  // Static reference to the current state for external cleanup
  static _CustomAuthScreenState? _currentInstance;
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  late final ClerkAuthState _auth;
  clerk.User? _user;
  bool _loading = false;
  bool _isOtpStep = false;
  bool _isLogin = true;
  late final StreamSubscription _errorSub;

  final _authService = AuthService();

  @override
  void initState() {
  _currentInstance = this;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _auth = ClerkAuth.of(context);
      _user = _auth.user;
      _auth.addListener(_updateUser);

      _errorSub = _auth.errorStream.listen((err) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.message)),
          );
        }
      });
    });
  }

  void _updateUser() async {
    if (!mounted) return;
    setState(() => _user = _auth.user);

    // Only navigate if user is authenticated and OTP step is complete
    if (_user != null && _isOtpStep) {
      await _authService.saveUserId(_user!.id);

      // Print userId to debug console
      debugPrint('Authenticated userId: \'${_user!.id}\'');
      // Navigate to splash  screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SplashOrHome()),
        );
      }
    }
  }

  Future<void> _sendEmailOtp() async {
    setState(() => _loading = true);
    try {
      if (_isLogin) {
        await _auth.attemptSignIn(
          strategy: clerk.Strategy.emailCode,
          identifier: _emailController.text,
        );
      } else {
        await _auth.attemptSignUp(
          strategy: clerk.Strategy.emailCode,
          emailAddress: _emailController.text,
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP sent to your email.")),
      );
      setState(() => _isOtpStep = true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _verifyEmailOtp() async {
    setState(() => _loading = true);
    try {
      if (_isLogin) {
        await _auth.attemptSignIn(
          strategy: clerk.Strategy.emailCode,
          code: _otpController.text,
        );
      } else {
        await _auth.attemptSignUp(
          strategy: clerk.Strategy.emailCode,
          code: _otpController.text,
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
/// Google Sign-In (no redirectUrl)
Future<void> _signInWithGoogle() async {
  setState(() => _loading = true);
  try {
    await _auth.ssoSignIn(
      context,
      clerk.Strategy.oauthGoogle,
    );
    // Save userId to preferences if sign-in was successful
    if (_auth.user != null) {
      await _authService.saveUserId(_auth.user!.id);
      debugPrint('Google sign-in userId: \'${_auth.user!.id}\'');
      // Navigate to HomeScren
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SplashOrHome()),
        );
      }
    }
  } finally {
    if (mounted) setState(() => _loading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    
    // Check if userId exists and reset state if so
    return FutureBuilder<String?>(
      future: _authService.getUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final userId = snapshot.data;

        if (userId != null && userId.isNotEmpty) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SplashOrHome()),
    );
  });
  return const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}

        // if (userId != null && userId.isNotEmpty) {
        //   // User is already logged in, clear and reset
        //   WidgetsBinding.instance.addPostFrameCallback((_) async {
            
        //     setState(() {
        //       _isOtpStep = false;
        //       _isLogin = true;
        //       _user = null;
        //       _emailController.clear();
        //       _otpController.clear();
        //     });
        //   });
        //   return const Scaffold(body: Center(child: Text('Resetting login...')));
        // }
        // ...existing code...
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _isLogin ? "Sign In with Email OTP" : "Register with Email OTP",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  enabled: !_isOtpStep,
                ),
                if (_isOtpStep)
                  TextField(
                    controller: _otpController,
                    decoration: const InputDecoration(labelText: "Enter OTP"),
                    keyboardType: TextInputType.number,
                  ),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          if (!_isOtpStep)
                            ElevatedButton(
                              onPressed: _sendEmailOtp,
                              child: Text(
                                  _isLogin ? "Send OTP to Sign In" : "Send OTP to Register"),
                            ),
                          if (_isOtpStep)
                            ElevatedButton(
                              onPressed: _verifyEmailOtp,
                              child: Text(
                                  _isLogin ? "Verify & Sign In" : "Verify & Register"),
                            ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: _signInWithGoogle,
                            icon: const Icon(Icons.login),
                            label: const Text("Sign in with Google"),
                          ),
                        ],
                      ),
                if (_isOtpStep)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isOtpStep = false;
                        _otpController.clear();
                      });
                    },
                    child: const Text("Back to Email"),
                  ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      _isOtpStep = false;
                      _otpController.clear();
                    });
                  },
                  child: Text(
                    _isLogin ? "Don’t have an account? Register" : "Already have an account? Sign In",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _currentInstance = null;
    _emailController.dispose();
    _otpController.dispose();
    try {
      _auth.removeListener(_updateUser);
    } catch (_) {}
    _errorSub.cancel();
    super.dispose();
  }

  /// Static method to dispose the ClerkAuth listener externally (e.g., on logout)
  static void disposeClerkListener() {
    _currentInstance?._disposeClerkListenerInternal();
  }

  void _disposeClerkListenerInternal() {
    try {
      _auth.removeListener(_updateUser);
    } catch (_) {}
    try {
      _errorSub.cancel();
    } catch (_) {}
  }

}
