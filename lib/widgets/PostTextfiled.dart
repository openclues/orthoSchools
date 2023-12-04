import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/Button.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MoreInfoUserProvider moreInfoUserProvider =
        Provider.of<MoreInfoUserProvider>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        // boxShadow: ,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(5),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage: moreInfoUserProvider.user.profileImage != null
                  ? NetworkImage(moreInfoUserProvider.user.profileImage)
                  : null,
              child: moreInfoUserProvider.user.profileImage == null
                  ? Center(
                      child: Image.asset('assets/images/drimage.png'),
                    )
                  : null, // Remove Center widget if profileImage is not null
            ),
            title: TextField(
              decoration: InputDecoration(
                suffixIcon: MaterialButton(
                  // height: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: const Text('SHARE'),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                hintText: 'say Something',
                filled: true,
                fillColor: const Color.fromARGB(255, 222, 222, 222),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Color(0XFFF5F6F8),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
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
