import 'package:flutter/material.dart';

class CategoryComponent extends StatelessWidget {
  // const CategoryComponent({super.key});
  final String? name;
  final int? id;
  // final String? image;
  final IconData icon;
  final Color? IconColor;

  const CategoryComponent(
      {super.key, required this.name,
      required this.id,
      required this.icon,
      required this.IconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
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
          const SizedBox(
            width: 5,
          ),
          Text(
            name!,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
