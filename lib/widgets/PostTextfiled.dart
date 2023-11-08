import 'package:flutter/material.dart';
import '../widgets/Button.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        // boxShadow: ,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(5),
            leading: Image.asset('assets/images/profilePhoto.png'),
            title: TextField(
              decoration: InputDecoration(
                suffixIcon: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text('SHARE'),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                hintText: 'say Something',
                filled: true,
                fillColor: Color.fromARGB(255, 222, 222, 222),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0XFFF5F6F8),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0XFFF5F6F8),
                  ), // Change color here
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
