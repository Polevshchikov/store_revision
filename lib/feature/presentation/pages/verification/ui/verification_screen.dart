import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late UserEntity _user;
  late Timer _timer;
  int _count = 60;
  bool isStartTiner = false;

  @override
  void initState() {
    _user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    super.initState();
  }

  void _startTimer() {
    setState(() {
      isStartTiner = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _count--;
      });
      if (_count % 5 == 0) {
        context.read<AuthenticationBloc>().add(AuthenticationLoggedIn(_user));
      }
      if (_count == 0) {
        _timer.cancel();
        setState(() {
          isStartTiner = false;
          _count = 60;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 202, 91, 0),
                    Color.fromARGB(255, 132, 180, 202)
                  ],
                  begin: FractionalOffset(1.0, 1.0),
                  end: FractionalOffset(0.0, 0.0),
                  stops: [0.0, 0.7],
                  tileMode: TileMode.clamp),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            _user.photo.isEmpty
                                ? 'https://i.stack.imgur.com/l60Hf.png'
                                : _user.photo,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                        backgroundColor: const Color.fromARGB(158, 54, 46, 46),
                        radius: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Добро пожаловать',
                    style: TextStyle(
                      color: Color.fromARGB(255, 8, 66, 114),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    _user.name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 8, 66, 114),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ваш Email:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _user.email,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 8, 66, 114),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'К сожалению, Ваш аккаунт не подтвержден!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 209, 1, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 280,
                    child: Column(
                      children: [
                        const Text(
                          'Нажмите на кнопку ниже для подтверждения аккаунта через email.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 14, 13, 13),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'На вашу почту ${_user.email} \nотправлено электронное письмо. Перейдите по этой ссылке в письме, чтобы подтвердить свой адрес электронной почты.',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 99, 2, 145),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.mark_email_read_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text('Подтвердить почту')
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      if (!isStartTiner) {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationVerifivation(_user));
                        _startTimer();
                      }
                    },
                  ),
                  isStartTiner
                      ? Container(
                          width: 60,
                          height: 30,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(148, 18, 111, 218),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 255, 255),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _count.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 1, 7, 58),
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.exit_to_app_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text('Выйти')
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLoggedOut());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
