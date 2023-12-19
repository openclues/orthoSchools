import 'dart:io';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';

import '../../home_screen/data/models/recommended_spaces_model.dart';
import '../bloc/add_post_bloc.dart';
import '../bloc/my_spaces_bloc.dart';
import '../data/space_model.dart';

class AddPostScreen extends StatefulWidget {
  final RecommendedSpace? space;
  const AddPostScreen({super.key, this.space});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  RecommendedSpace? selectedSpace;
  List<XFile> images = [];
  String? content;

  @override
  Widget build(BuildContext context) {
    widget.space != null ? selectedSpace = widget.space : null;
    return BlocListener<AddPostBloc, AddPostState>(
      listener: (context, state) {
        if (state is AddPostLoaded) {
          
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        floatingActionButton: Container(
          // padding: EdgeInsets.zero,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              //list of images
              Container(
                // height: 100,
                width: MediaQuery.of(context).size.width / 1.1,
                // height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocListener<MySpacesBloc, MySpacesState>(
                    listener: (context, state) {
                      if (widget.space != null) {
                        setState(() {
                          selectedSpace = widget.space;
                        });
                        return;
                      }
                      if (state is MySpacesLoaded) {
                        showQudsPopupMenu(
                            context: context,
                            items: state.spaces
                                .map((e) => QudsPopupMenuItem(
                                    title: Text(
                                      e.name!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selectedSpace = e;
                                      });
                                    }))
                                .toList());
                      }
                    },
                    child: BlocBuilder<MySpacesBloc, MySpacesState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (state is! MySpacesLoaded) {
                                  context
                                      .read<MySpacesBloc>()
                                      .add(const LoadMySpaces());
                                }
                                if (state is MySpacesLoaded) {
                                  showQudsPopupMenu(
                                      context: context,
                                      items: state.spaces
                                          .map((e) => QudsPopupMenuItem(
                                              title: Text(
                                                e.name!,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  selectedSpace = e;
                                                });
                                              }))
                                          .toList());
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: primaryColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        state is! MySpacesLoading
                                            ? selectedSpace == null
                                                ? const Icon(IconlyBold.plus,
                                                    color: primaryColor)
                                                : const Icon(
                                                    Icons.check_circle_outline,
                                                  )
                                            : const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryColor,
                                                ),
                                              ),
                                        const SizedBox(width: 5),
                                        Text(selectedSpace == null
                                            ? "Post in which space"
                                            : selectedSpace!.name!)
                                      ],
                                    ),
                                  )),
                            ),
                            //upload image
                            IconButton(
                              onPressed: () {
                                //select multiple images
                                ImagePicker().pickMultiImage().then((value) {
                                  setState(() {
                                    images = value!;
                                  });
                                });
                              },
                              icon: const Icon(
                                IconlyBold.image_2,
                                color: primaryColor,
                                size: 30,
                              ),
                            ),
                            //upload video
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                IconlyBold.video,
                                color: primaryColor,
                                size: 30,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      context.read<AddPostBloc>().add(AddPostToSpace(
                          spaceId: selectedSpace!.id.toString(),
                          content: content!,
                          images: images));
                    },
                    child: const Text('Post')),
              )
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
          title: const Text('Add Post', style: TextStyle(color: Colors.black)),
        ),
        body: ListView(
          children: [
            images.isEmpty
                ? const SizedBox()
                : Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                File(images[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextFormField(
                onChanged: (v) {
                  setState(() {
                    content = v;
                  });
                },
                // scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
