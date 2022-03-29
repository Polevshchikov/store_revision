import 'package:flutter/material.dart';
import 'package:store_revision/feature/presentation/pages/sign_up/ui/widgets/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Регистрация')),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SignUpForm(),
      ),
    );
  }
}
