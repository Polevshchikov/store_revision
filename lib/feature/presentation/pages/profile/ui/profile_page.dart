import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';
import 'package:store_revision/feature/presentation/pages/profile/ui/widgets/profile_button_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.teal,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: const Color.fromARGB(0, 66, 66, 66),
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF009688),
                    Color.fromARGB(255, 245, 255, 255)
                  ],
                  begin: FractionalOffset(1.0, 1.0),
                  end: FractionalOffset(0.0, 0.0),
                  stops: [0.0, 0.7],
                  tileMode: TileMode.clamp),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 40,
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          width: widthScreen * 0.6,
                          color: const Color(0xffFF0E58),
                          child: Image.network(
                              state.user.photo.isNotEmpty
                                  ? state.user.photo
                                  : 'https://i.stack.imgur.com/l60Hf.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _user.email,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 192, 0, 0),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '_user.name',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 98, 179),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Проведено ревизий: ${_user.revisions.length}',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileButtonWidget(
                          widget: const SizedBox(
                            height: 20,
                            child: Text('Сменить email'),
                          ),
                          onTap: () {
                            print('Сменить email');
                          }),
                      const SizedBox(width: 10),
                      ProfileButtonWidget(
                          widget: const SizedBox(
                            height: 20,
                            child: Text('Сменить пароль'),
                          ),
                          onTap: () {
                            print('Сменить пароль');
                          }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileButtonWidget(
                      widget: Row(
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
                      onTap: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLoggedOut());
                      }),
                  const Spacer(),
                  ProfileButtonWidget(
                      widget: const Text('Восстановить пароль'),
                      onTap: () {
                        print('Забыл пароль');
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
