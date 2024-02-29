import 'package:flutter/material.dart';
import '../pages/search_screen.dart';

class SearchAndFilterWidget extends StatefulWidget {
  const SearchAndFilterWidget({Key? key}) : super(key: key);

  @override
  State<SearchAndFilterWidget> createState() => _SearchAndFilterWidgetState();
}

class _SearchAndFilterWidgetState extends State<SearchAndFilterWidget> {
  String selected = 'Posts';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(element: selected),
                  ));
                },
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.mic, color: Colors.grey),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return FilterWidget(
                      onTap: (e) {
                        setState(() {
                          selected = e!;
                        });
                        // Navigator.of(context).pop();
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => SearchScreen(element: selected),
                        //   ),
                        // );
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.filter_alt),
            );
          }),
        ],
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  final void Function(String? selected)? onTap;

  FilterWidget({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter'),
      content: SingleChildScrollView(
        child: Column(
          children: filterOptions
              .map((e) => ListTile(
                    title: Text(
                      e,
                      style: const TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      onTap!(e);
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(element: e),
                      ));
                    },
                  ))
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  List<String> filterOptions = [
    'Posts',
    'Articles',
    'Spaces',
    'Blogs',
    'People',
  ];
}
