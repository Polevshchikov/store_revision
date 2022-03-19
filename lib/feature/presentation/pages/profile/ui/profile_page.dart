import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/authentication/bloc/authentication_bloc.dart';

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
        backgroundColor: const Color.fromARGB(83, 66, 66, 66),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), //or 15.0
                      child: Container(
                        width: widthScreen * 0.6,
                        color: const Color(0xffFF0E58),
                        child: Image.network('https://picsum.photos/200',
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(_user.email),
                Text(_user.name),
                Text('Проведено ревизий: ${_user.revisions.length}'),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          );
        },
      ),
    );
  }
}
