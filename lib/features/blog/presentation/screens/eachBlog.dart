import 'package:azsoon/Core/colors.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String? image;
  final String? authorImage;
  final String? authorName;
  final String? topicTitle;
  final String? topicText;
  final String? publishTime;

  const DetailPage(
      {super.key,
      this.image,
      this.authorImage,
      this.authorName,
      this.topicTitle,
      this.topicText,
      this.publishTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 10, right: 15, left: 15),
        child: ListView(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
            ), //should be network
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset(
                  authorImage!,
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 8),
                Text(
                  authorName!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    topicTitle!,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse_rounded,
                        size: 15,
                        color: primaryColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '12 hours ago',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    topicText!,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
