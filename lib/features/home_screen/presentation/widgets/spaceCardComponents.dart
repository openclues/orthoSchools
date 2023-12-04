import 'package:flutter/material.dart';

class CategoryComponent extends StatelessWidget {
  // const CategoryComponent({super.key});
  final String? name;
  final int? id;
  // final String? image;
  final IconData icon;
  final Color? IconColor;

  CategoryComponent(
      {required this.name,
      required this.id,
      required this.icon,
      required this.IconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
      padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 48, 48, 48), width: 0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: IconColor,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            name!,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
