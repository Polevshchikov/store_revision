import 'package:flutter/material.dart';
import 'package:store_revision/feature/presentation/pages/login/ui/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: LoginForm(),
      ),
    );
  }
}
