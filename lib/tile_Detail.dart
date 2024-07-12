import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:medic/PersonDetailPage.dart';

class TileDetail extends StatefulWidget {
  final String medicinename;
  final Function(bool)? onSelected;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;
  final String personName;

  TileDetail({
    Key? key,
    required this.medicinename,
    required this.onSelected,
    required this.deleteFunction,
    required this.editFunction,
    required this.personName,
  }) : super(key: key);

  @override
  State<TileDetail> createState() => _TileDetailState();
}

class _TileDetailState extends State<TileDetail> {
  bool _isSelected = false;




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        if (widget.onSelected != null) {
          widget.onSelected!(_isSelected);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 5),
        child: Slidable(
          startActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.editFunction,
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
                onPressed: widget.deleteFunction,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.red.shade300,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                if (_isSelected)
                  Checkbox(
                    value: _isSelected,
                    onChanged: (value) {
                      setState(() {
                        _isSelected = value!;
                      });
                    },
                  ),
                SizedBox(width: 16), // Spacer between checkbox and text
                Text(
                  widget.medicinename,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
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
  void addDetailTohive() async{
    var box = await Hive.openBox(widget.personName);
    box.add(widget.medicinename);
  }
}

