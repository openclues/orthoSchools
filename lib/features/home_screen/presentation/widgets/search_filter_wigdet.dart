import 'package:flutter/material.dart';

class SearchAndFilterWidget extends StatelessWidget {
  const SearchAndFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            // color: Color(0xffF5F5F5),

            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF5F5F5),
                contentPadding: const EdgeInsets.all(8),
                hintText: 'Search',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic, color: Colors.grey),
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_alt),
        ),
      ],
    );
  }
}
