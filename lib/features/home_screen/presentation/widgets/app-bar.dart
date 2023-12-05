import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    iconTheme: IconThemeData(color: const Color.fromARGB(255, 47, 47, 47)),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: TextField(
      // controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search),
        hintText: 'Search...',
        hintStyle: TextStyle(color: Color(0XFF939199)),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: const Color(0XFFEEF3F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Color(0XFFEEF3F7),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0XFFEEF3F7),
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    ),
    bottom: TabBar(labelColor: Colors.grey, tabs: [
      Tab(
        text: 'space1',
      ),
      Tab(
        text: 'space2',
      ),
      Tab(
        text: 'space3',
      ),
    ]),
  );
}
