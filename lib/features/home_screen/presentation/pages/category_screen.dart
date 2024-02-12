import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/home_screen/data/models/recommended_spaces_model.dart';
import 'package:azsoon/features/home_screen/presentation/pages/reading_zone.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel category;
  List<BlogModel>? blogs = [];
  List<RecommendedSpace>? spaces = [];
  CategoryScreen({super.key, required this.category, this.blogs, this.spaces});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var selectedtab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      IconlyBroken.arrow_left_circle,
                      size: 30,
                      color: primaryColor,
                    )),
                const SizedBox(
                  width: 10,
                ),
                // Hero(
                //     tag: widget.category.image!,
                //     child: Container(
                //         height: 50,
                //         width: 50,
                //         child: Image.network(widget.category.image!))),
                Hero(
                    tag: widget.category.name!,
                    child: Text(widget.category.name!)),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconlyBroken.search,
                      size: 30,
                      color: primaryColor,
                    )),

                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReadingZone(
                                categoryId: widget.category.id,
                              )));
                    },
                    icon: const Icon(
                      FontAwesomeIcons.readme,
                      size: 30,
                      color: primaryColor,
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedtab = 0;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Spaces (${widget.spaces!.length})",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: selectedtab == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color:
                              selectedtab == 0 ? primaryColor : Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: selectedtab == 0 ? true : false,
                      child: Container(
                        height: 1,
                        width: 50,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedtab = 1;
                  });
                },
                child: Column(
                  children: [
                    Text("Blogs (${widget.blogs!.length})",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: selectedtab == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: selectedtab == 1
                                ? primaryColor
                                : Colors.black)),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: selectedtab == 1 ? true : false,
                      child: Container(
                        height: 1,
                        width: 50,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          if (selectedtab == 0)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.spaces!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SpaceScreen.routeName,
                        arguments: widget.spaces![index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      SpaceScreen.routeName,
                                      arguments: SimpleSpace(
                                        updatedAt: "",
                                        createdAt: "",
                                        id: widget.spaces![index].id!,
                                        name: widget.spaces![index].name!,
                                        description:
                                            widget.spaces![index].description!,
                                        cover: widget.spaces![index].cover!,
                                        isAllowedToJoin: widget
                                            .spaces![index].isAllowedToJoin!,
                                        isJoined:
                                            widget.spaces![index].isJoined!,
                                        membersCount:
                                            widget.spaces![index].membersCount!,
                                      ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   height: 50,
                                    //   width: 50,
                                    //   child:
                                    //       Image.network(widget.spaces![index].cover!),
                                    // ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.spaces![index].name!,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.spaces![index].description!,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // JoinButton(
                                        //     isAllowedToJoin: widget
                                        //         .spaces![index]!.isAllowedToJoin!,
                                        //     spaceId: widget.spaces![index]!.id!,
                                        //     isJoined:
                                        //         widget.spaces![index]!.isJoined!),
                                        Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.userGroup,
                                              size: 15,
                                              color: primaryColor,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.spaces![index].membersCount
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Container(
                              //   height: 1,
                              //   width: MediaQuery.of(context).size.width,
                              //   color: Colors.grey,
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),

          if (selectedtab == 1)
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.blogs!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(SpaceScreen.routeName,
                        //     arguments: SimpleSpace(
                        //       updatedAt: "",
                        //       createdAt: "",
                        //       id: widget.spaces![index].id!,
                        //       name: widget.spaces![index].name!,
                        //       description: widget.spaces![index].description!,
                        //       cover: widget.spaces![index].cover!,
                        //       isAllowedToJoin:
                        //           widget.spaces![index].isAllowedToJoin!,
                        //       isJoined: widget.spaces![index].isJoined!,
                        //       membersCount: widget.spaces![index].membersCount!,
                        //     ));
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(children: [
                            GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(
                                  //     SpaceScreen.routeName,
                                  //     arguments: SimpleSpace(
                                  //       updatedAt: "",
                                  //       createdAt: "",
                                  //       id: widget.spaces![index].id!,
                                  //       name: widget.spaces![index].name!,
                                  //       description:
                                  //           widget.spaces![index].description!,
                                  //       cover: widget.spaces![index].cover!,
                                  //       isAllowedToJoin:
                                  //           widget.spaces![index].isAllowedToJoin!,
                                  //       isJoined: widget.spaces![index].isJoined!,
                                  //       membersCount:
                                  //           widget.spaces![index].membersCount!,
                                  //     ));
                                },
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   height: 50,
                                      //   width: 50,
                                      //   child:
                                      //       Image.network(widget.spaces![index].cover!),
                                      // ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(
                                              widget.blogs![index].title!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              widget.blogs![index].description!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ]))
                                    ]))
                          ])));
                }),
          // two taps
        ],
      ),
    );
  }
}
