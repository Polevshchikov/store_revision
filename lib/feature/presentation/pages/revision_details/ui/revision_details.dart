import 'package:flutter/material.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

class RevisionDetailsPage extends StatelessWidget {
  final RevisionEntity revision;
  const RevisionDetailsPage({Key? key, required this.revision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
    ));
  }
}
