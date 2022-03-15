import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/trusted_add/cubit/trusted_add_cubit.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:store_revision/feature/presentation/widgets/plug_screen.dart';

class TrustedAddPage extends StatelessWidget {
  const TrustedAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TrustedAddCubit>().getUsers();
    return Container(
      // decoration: const BoxDecoration(
      //   gradient: SweepGradient(
      //     center: Alignment.bottomCenter,
      //     colors: [
      //       Color.fromARGB(255, 42, 168, 241),
      //       Color.fromARGB(255, 106, 19, 206),
      //       Color.fromARGB(255, 167, 18, 55),
      //       Color.fromARGB(255, 209, 167, 30),
      //     ],
      //     endAngle: math.pi * 2,
      //     startAngle: math.pi,
      //   ),
      // ),

      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<TrustedAddCubit>().getUsers();
        },
        child: BlocBuilder<TrustedAddCubit, TrustedAddState>(
            builder: (BuildContext context, TrustedAddState state) {
          if (state.status == Status.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == Status.success && state.users.isEmpty) {
            return const Center(child: Text('Список пользователей пуст'));
          }

          if (state.status == Status.success && state.users.isNotEmpty) {
            final users = state.users;

            return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: index + 1 == users.length
                        ? const EdgeInsets.only(bottom: 60)
                        : EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: 80,
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 43, 144, 148),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      spreadRadius: 0,
                                      blurRadius: 8,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white24,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(20.0), //or 15.0
                                      child: Container(
                                        width: 50,
                                        color: const Color(0xffFF0E58),
                                        child: const Icon(
                                            Icons.perm_identity_rounded),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(users[index].name),
                                        const SizedBox(height: 5),
                                        Text(users[index].email),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 179, 27, 27),
                                  // color:
                                  //     const Color.fromARGB(255, 40, 157, 161),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      spreadRadius: 0,
                                      blurRadius: 8,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white24,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                height: 80,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const PlugScreen();
        }),
      ),
    );
  }
}
