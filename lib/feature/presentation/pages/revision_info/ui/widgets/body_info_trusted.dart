import 'package:flutter/material.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';

class BodyInfoTrusted extends StatelessWidget {
  final List<UserEntity> trusteds;
  const BodyInfoTrusted({Key? key, required this.trusteds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(57, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: trusteds.isEmpty
          ? const Center(
              child: Text(
              'Список пользователей пуст',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 50),
              itemCount: trusteds.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      height: 100,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 27, 187, 126),
                          Color.fromARGB(255, 152, 204, 180),
                          Color.fromARGB(255, 230, 222, 112),
                        ], begin: Alignment.center, end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  trusteds[index].name.isEmpty
                                      ? 'Не указано имя'
                                      : trusteds[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  trusteds[index].email,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 19, 52, 143),
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
                    Positioned(
                      top: -30,
                      left: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0), //or 15.0
                        child: Container(
                          height: 130,
                          color: const Color(0xffFF0E58),
                          child: Image.network(
                              trusteds[index].photo.isNotEmpty
                                  ? trusteds[index].photo
                                  : 'https://i.stack.imgur.com/l60Hf.png',
                              width: 130,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}
