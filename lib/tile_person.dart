import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medic/PersonDetailPage.dart';

class TilePerson extends StatelessWidget {
  final String personname;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;

  TilePerson({
    Key? key,
    required this.personname,
    required this.deleteFunction,
    required this.editFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailsPage(personName: personname),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 5),
        child: Slidable(
          startActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: editFunction,
                icon: Icons.edit,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.yellow.shade300,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.red.shade300,
              ),
            ],
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Text(
                    personname,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff43B3AE),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
