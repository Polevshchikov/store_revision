import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_revision/feature/presentation/pages/revisions_active/cubit/change_body_cubit.dart';
import 'package:store_revision/feature/presentation/pages/trusted_revision/cubit/trusted_change_cubit.dart';
import 'package:store_revision/feature/presentation/pages/trusted_revision/ui/widgets/button_screen.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:store_revision/feature/presentation/widgets/plug_screen.dart';

class TrustedDeletePage extends StatefulWidget {
  const TrustedDeletePage({Key? key}) : super(key: key);

  @override
  State<TrustedDeletePage> createState() => _TrustedDeletePageState();
}

class _TrustedDeletePageState extends State<TrustedDeletePage> {
  final listUserId = <String>[];
  late ChangeBodyCubit _changeBodyCubit;
  late TrustedChangeCubit _trustedAddCubit;
  late String revisionId;
  @override
  void initState() {
    _changeBodyCubit = BlocProvider.of<ChangeBodyCubit>(context);
    _trustedAddCubit = BlocProvider.of<TrustedChangeCubit>(context);
    revisionId = _changeBodyCubit.state.revisionId;
    _trustedAddCubit.deleteTrusted(trustedsId: [], revisionId: revisionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await _trustedAddCubit
                  .deleteTrusted(trustedsId: [], revisionId: revisionId);
            },
            child: BlocBuilder<TrustedChangeCubit, TrustedChangeState>(
                builder: (BuildContext context, TrustedChangeState state) {
              if (state.status == Status.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.status == Status.success && state.users.isEmpty) {
                return const Center(
                    child: Text(
                  'Список пользователей пуст',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ));
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
                          onTap: () {
                            if (listUserId.contains(users[index].uid)) {
                              setState(() {
                                listUserId.removeWhere(
                                    (element) => element == users[index].uid);
                              });
                            } else {
                              setState(() {
                                listUserId.add(users[index].uid);
                              });
                            }
                          },
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
                                    height: 100,
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 43, 144, 148),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              15.0), //or 15.0
                                          child: Container(
                                            color: const Color(0xffFF0E58),
                                            child: Image.network(
                                                users[index].photo.isNotEmpty
                                                    ? users[index].photo
                                                    : 'https://i.stack.imgur.com/l60Hf.png',
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                users[index].name.isEmpty
                                                    ? 'Не указано имя'
                                                    : users[index].name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                users[index].email,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 19, 52, 143),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 40, 157, 161),
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                    height: 100,
                                    child: listUserId.contains(users[index].uid)
                                        ? Container(
                                            margin: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  207, 187, 33, 33),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  spreadRadius: 2,
                                                  blurRadius: 8,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.white24,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: const Icon(Icons.remove),
                                          )
                                        : const SizedBox.shrink(),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonScreen(
              typeButton: TypeButton.delete,
              onTapButtonClose: () {
                _changeBodyCubit.changeToActiveRevision();
              },
              onTapButtonCreate: () {
                _trustedAddCubit.deleteTrusted(
                    trustedsId: listUserId, revisionId: revisionId);
              },
            ),
          )
        ],
      ),
    );
  }
}
