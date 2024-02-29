import 'dart:convert';
import 'dart:io';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/presentation/space_screen.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../Core/network/request_helper.dart';
import '../../home_screen/data/models/recommended_spaces_model.dart';
import '../bloc/add_post_bloc.dart';
import '../bloc/my_spaces_bloc.dart';
import 'post_screen.dart';

class AddPostScreen extends StatefulWidget {
  final RecommendedSpace? space;
  final ArticlesModel? article;

  const AddPostScreen({super.key, this.space, this.article});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? selectedSpace;
  int? selectedSpaceId;
  SimpleSpace? space;
  List<XFile> images = [];
  XFile? video;
  String? content;
  _getUpdatedPost(int? postId) async {
    var response = await RequestHelper.get('post/${postId!}');
    if (response.statusCode == 200) {
      return LatestUpdatedPost.fromJson(jsonDecode(response.body));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<MySpacesBloc>().add(const LoadMySpaces());
  }

  @override
  Widget build(BuildContext context) {
    widget.space != null ? selectedSpace = widget.space!.name : null;
    widget.space != null ? selectedSpaceId = widget.space!.id : null;
    return BlocListener<AddPostBloc, AddPostState>(
      listener: (context, state) async {
        if (state is AddPostLoaded) {
          _getUpdatedPost(state.post).then(
            (value) {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed(PostScreen.routeName, arguments: value);
            },
          );
          // try {
          // } catch (e) {
          //   Navigator.of(context).pop();
          // }
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
              if (widget.article == null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocListener<MySpacesBloc, MySpacesState>(
                    listener: (context, state) {
                      if (widget.space != null) {
                        setState(() {
                          selectedSpace = widget.space!.name!;
                          selectedSpaceId = widget.space!.id!;
                        });
                        return;
                      }
                      if (state is MySpacesLoaded) {
                        if (state.spaces.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                  title: Text('No spaces found'),
                                  content: Text(
                                      'You need to join a space to post in it')));
                          return;
                        }
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
                                        selectedSpace = e.name;
                                        selectedSpaceId = e.id;
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
                            //upload image
                            IconButton(
                              onPressed: () {
                                //select multiple images
                                ImagePicker().pickMultiImage().then((value) {
                                  setState(() {
                                    images = value;
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
                            if (widget.article == null)
                              IconButton(
                                onPressed: () {
                                  //select multiple images
                                  ImagePicker()
                                      .pickVideo(source: ImageSource.gallery)
                                      .then((value) {
                                    setState(() {
                                      video = value;
                                    });
                                  });
                                },
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

              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: BlocBuilder<AddPostBloc, AddPostState>(
                  builder: (context, state) {
                    if (state is AddPostLoading) {
                      return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ],
                      );
                    }

                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (selectedSpace == null) {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                    title: Text('No space selected'),
                                    content: Text(
                                        'You need to select a space to post in it')));
                            return;
                          }
                          context.read<AddPostBloc>().add(AddPostToSpace(
                              spaceId: selectedSpaceId.toString(),
                              video: video,
                              content: content!,
                              images: images,
                              blogpost: widget.article?.id));
                        },
                        child: const Text('Post',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)));
                  },
                ),
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
                : SizedBox(
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
            BlocBuilder<MySpacesBloc, MySpacesState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    if (state is! MySpacesLoaded) {
                      context.read<MySpacesBloc>().add(const LoadMySpaces());
                    }
                    if (state is MySpacesLoaded) {
                      showQudsPopupMenu(
                          context: context,
                          items: state.spaces
                              .map((e) => QudsPopupMenuItem(
                                  title: Text(
                                    e.name!,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedSpace = e.name;
                                      selectedSpaceId = e.id;
                                    });
                                  }))
                              .toList());
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: primaryColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  ),
                            const SizedBox(width: 5),
                            Text(selectedSpace == null
                                ? "Choose a space"
                                : selectedSpace!)
                          ],
                        ),
                      )),
                );
              },
            ),
            Container(
              height: widget.article == null && video == null
                  ? MediaQuery.of(context).size.height / 2
                  : 100,
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
            //if blog post is not null preview it
            if (widget.article != null)
              BlogPostPreview(blogPost: widget.article),
            if (video != null)
              SizedBox(
                height: 200,
                child: YourVideoPlayerWidget(
                  videoUrl: video!.path,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class BlogPostPreview extends StatefulWidget {
  final ArticlesModel? blogPost;
  const BlogPostPreview({super.key, required this.blogPost});

  @override
  State<BlogPostPreview> createState() => _BlogPostPreviewState();
}

class _BlogPostPreviewState extends State<BlogPostPreview> {
  // final QuillController _controller = QuillController.basic();
  //get plan text from delta
  @override
  Widget build(BuildContext context) {
    //remove images from delta
    print(widget.blogPost!.title);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: 200,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     image: DecorationImage(
          //       image: NetworkImage(widget.blogPost!.cover!),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.blogPost!.title ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.blogPost!.plainText ?? ''),
          ),
        ],
      ),
    );
  }
}

class YourVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const YourVideoPlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _YourVideoPlayerWidgetState createState() => _YourVideoPlayerWidgetState();
}

class _YourVideoPlayerWidgetState extends State<YourVideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    try {
      _videoPlayerController.dispose();
    } catch (e) {
      print(e);
    }
    try {
      _chewieController.dispose();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await _videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoInitialize: true,
          looping: true,
          autoPlay: false);
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Chewie(
      controller: _chewieController,
    );
  }
}
