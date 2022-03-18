import 'package:flutter/material.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/presentation/pages/revision_info/ui/widgets/body_info_trusted.dart';

class InfoTrustedWidget extends StatefulWidget {
  final List<UserEntity> users;
  const InfoTrustedWidget({Key? key, required this.users}) : super(key: key);

  @override
  State<InfoTrustedWidget> createState() => _InfoTrustedWidgetState();
}

class _InfoTrustedWidgetState extends State<InfoTrustedWidget> {
  bool showTrustedsBody = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(190, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(155, 0, 0, 0),
                    offset: Offset(0, 0),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Количество сотрудников: ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.users.length.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 54, 126),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() => showTrustedsBody = !showTrustedsBody);
              },
              child: Icon(
                showTrustedsBody
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
          ],
        ),
        showTrustedsBody
            ? BodyInfoTrusted(trusteds: widget.users)
            : const SizedBox.shrink(),
      ],
    );
  }
}
