import 'package:flutter/material.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

class RevisionInfoScreen extends StatelessWidget {
  final RevisionEntity revision;
  const RevisionInfoScreen({Key? key, required this.revision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.green),
    );
  }
}
