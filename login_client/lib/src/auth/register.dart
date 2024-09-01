import 'package:flutter/material.dart';
import 'package:login_client/src/api/api_service.dart';
import '../pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isNotEmpty && password.isNotEmpty && password == confirmPassword) {
      try {
        final result = await _apiService.register(email, password);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
          );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid information'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                  // onPressed: () {
                  //   final email = _emailController.text;
                  //   final password = _passwordController.text;
                  //   final confirmPassword = _confirmPasswordController.text;

                  //   if (email.isNotEmpty && password.isNotEmpty && password == confirmPassword) {
                  //     Navigator.pushAndRemoveUntil(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => const HomeScreen()),
                  //       (route) => false,
                  //     );
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Please enter valid information')),
                  //     );
                  //   }
                  // },
                  // child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: SvgPicture.asset(
              'assets/pesas.svg',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}

