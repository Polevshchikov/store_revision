import 'package:flutter/material.dart';
import 'package:store_revision/feature/presentation/pages/revision/ui/widgets/button_add_revision.dart';

class RevisionScreen extends StatelessWidget {
  const RevisionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.purple[200]!, Colors.amber],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          GridPaper(
            interval: 180,
            divisions: 4,
            subdivisions: 5,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[500]!,
                          offset: const Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('title'),
                        SizedBox(height: 5),
                        Text('date'),
                        SizedBox(height: 5),
                        Text('Count product'),
                        SizedBox(height: 5),
                        Text('Sum'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ButtonAddRevision(),
            ),
          ),
        ],
      ),
    );
  }
}
