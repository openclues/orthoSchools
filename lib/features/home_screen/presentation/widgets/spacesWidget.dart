import 'dart:math';

import 'package:azsoon/features/home_screen/presentation/widgets/spaceCardComponents.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesData.dart';
import 'package:flutter/material.dart';

class SpacesList extends StatefulWidget {
  const SpacesList({Key? key}) : super(key: key);

  @override
  State<SpacesList> createState() => _SpacesListState();
}

class _SpacesListState extends State<SpacesList> {
  List<SpaceData> spaces = [
    SpaceData(
      name: 'Space 1',
      description:
          'The future of cryptoArt markets a network governed by artists, collectors and curators.',
      bgImage: "assets/images/postImage.png",
    ),
    SpaceData(
      name: 'Space 2',
      description: 'Description 2',
      bgImage: "assets/images/postImage.png",
    ),
    SpaceData(
      name: 'Space 3',
      description: 'Description 3',
      bgImage: "assets/images/postImage.png",
    ),
    SpaceData(
      name: 'Space 4',
      description: 'Description 4',
      bgImage: "assets/images/postImage.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: spaces.length,
        itemBuilder: (BuildContext context, int index) {
          // here i am building the cards
          return Container(
            width: 330,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(spaces[index].bgImage!),
                fit: BoxFit.cover,
              ),
              // color: spaces[index].color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  top: 30,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    // color: Colors.white,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15), // Adjust the top-left radius
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 50, 7, 0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 10),
                        title: Text(
                          spaces[index].name!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          spaces[index].description!,
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(Icons.lock),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.grey,
                            ),
                            Text('299.5K')
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          CategoryComponent(
                            name: 'Crypto',
                            id: 0,
                            icon: Icons.money,
                            IconColor: Colors.green,
                          ),
                          CategoryComponent(
                            name: 'Art',
                            id: 0,
                            icon: Icons.photo_album,
                            IconColor: Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
