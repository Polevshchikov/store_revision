import 'package:flutter/material.dart';
import 'package:store_revision/core/navigation/arguments/revision_details_arguments.dart';
import 'package:store_revision/core/navigation/main_navigation.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

PreferredSizeWidget revisionAppbar({
  required BuildContext context,
  required RevisionEntity revision,
  required List<ProductEntity> products,
}) {
  return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(200, 78, 15, 4),
            Color.fromARGB(200, 117, 34, 96),
            Color.fromARGB(200, 34, 95, 119),
          ], begin: Alignment.centerLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      elevation: 10,
      title: Text(
        revision.name,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10, top: 12),
          child: GestureDetector(
            child: Container(
              width: 55,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 11, 56, 73),
                  Color.fromARGB(255, 174, 222, 241),
                  Color.fromARGB(255, 151, 14, 14),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  ),
                ],
                border: Border.all(
                  width: 2,
                  color: Colors.white24,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Center(
                  child: Icon(
                Icons.info_outlined,
                color: Color.fromARGB(255, 54, 53, 53),
              )),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                MainNavigationRouteNames.revisionDetails,
                arguments: RevisionDetailsArguments(
                    revision: revision, products: products),
              );
            },
          ),
        ),
      ]);
}
