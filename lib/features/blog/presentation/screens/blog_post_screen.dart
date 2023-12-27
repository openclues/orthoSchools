import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../space/bloc/add_post_bloc.dart';
import '../../../space/bloc/my_spaces_bloc.dart';
import '../../../space/presentation/add_post.dart';

class BlogPostScreen extends StatelessWidget {
  static const String routeName = '/blogPost';
  final PostModel? blogPostModel;
  BlogPostScreen({super.key, this.blogPostModel});
  final QuillController _controller = QuillController.basic();
  //get data from delta

  @override
  Widget build(BuildContext context) {
    _controller.document = Document.fromDelta(blogPostModel!.content);
    return Scaffold(
      bottomNavigationBar: Container(
        // height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: primaryColor, offset: Offset(0, 2), blurRadius: 5)
          ],
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0, 2),
                        blurRadius: 5)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "40",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        IconlyLight.heart,
                        color: primaryColor,
                      ),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0, 2),
                        blurRadius: 5)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "40",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        IconlyLight.chat,
                        color: primaryColor,
                      ),
                    ],
                  ),
                )),
            const Spacer(),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(0, 2),
                      blurRadius: 5)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Save",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Icon(
                      IconlyLight.bookmark,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(width: 20),

            Builder(builder: (context) {
              return GestureDetector(
                onTap: () {
                  //show bottom sheet for user to choose betwween sharing the blog in a space post or to other applications

                  showModalBottomSheet(
                      context: context,
                      builder: ((_) {
                        return Container(
                            // height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(0, 2),
                                    blurRadius: 5)
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                        PageAnimationTransition(
                                            pageAnimationType:
                                                BottomToTopTransition(),
                                            page: MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      MySpacesBloc(),
                                                ),
                                                BlocProvider(
                                                  create: (context) =>
                                                      AddPostBloc(),
                                                ),
                                              ],
                                              child: AddPostScreen(
                                                  blogPost: blogPostModel),
                                            )));
                                  },
                                  leading: const Icon(
                                    FontAwesomeIcons.spaceShuttle,
                                    color: primaryColor,
                                  ),
                                  title: const Text("Share to Space"),
                                ),
                                const ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.facebook,
                                    color: primaryColor,
                                  ),
                                  title: Text("Share to Facebook"),
                                ),
                                const ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.twitter,
                                    color: primaryColor,
                                  ),
                                  title: Text("Share to Twitter"),
                                ),
                                const ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: primaryColor,
                                  ),
                                  title: Text("Share to Whatsapp"),
                                ),
                                const ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.telegram,
                                    color: primaryColor,
                                  ),
                                  title: Text("Share to Telegram"),
                                ),
                                ListTile(
                                  onTap: () {
                                    //convert post delta to plain text
                                    // COPY
                                    Clipboard.setData(ClipboardData(
                                        text: _controller.document
                                            .toPlainText()));
                                  },
                                  leading: const Icon(
                                    FontAwesomeIcons.copy,
                                    color: primaryColor,
                                  ),
                                  title: const Text("Copy post text"),
                                ),
                              ],
                            ));
                      }));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 2),
                            blurRadius: 5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Share",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const Icon(
                            IconlyLight.send,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    )),
              );
            }),
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              ApiEndpoints.baseUrl +
                  blogPostModel!.cover!.replaceFirst('/', ""),
              fit: BoxFit.fitWidth,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(0, 2),
                      blurRadius: 5)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: QuillToolbar.simple(
                    configurations: QuillSimpleToolbarConfigurations(
                        showHeaderStyle: true,
                        multiRowsDisplay: false,
                        color: Colors.white,
                        showBackgroundColorButton: true,
                        showCodeBlock: false,
                        axis: Axis.horizontal,
                        controller: _controller,
                        embedButtons: FlutterQuillEmbeds.toolbarButtons())),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                blogPostModel!.title!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            // SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: QuillEditor(
                  scrollController: ScrollController(),
                  configurations: QuillEditorConfigurations(
                    readOnly: true,
                    enableSelectionToolbar: true,
                    embedBuilders: FlutterQuillEmbeds.editorBuilders(
                        imageEmbedConfigurations:
                            const QuillEditorImageEmbedConfigurations(),
                        videoEmbedConfigurations:
                            const QuillEditorVideoEmbedConfigurations()
                        // video: _videoBuilder,
                        // image: _imageBuilder,
                        // horizontalRule: _hrBuilder,
                        // markdown: _mdBuilder,

                        ),
                    controller: _controller,
                    showCursor: false,
                    autoFocus: true,
                  ),
                  focusNode: FocusNode(),
                )),
          ],
        ),
      ),
    );
  }
}
