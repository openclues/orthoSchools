import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

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
          child: Row(children: [
            // const Spacer(),
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
            const SizedBox(width: 20),
            Container(
              child: Row(
                children: [
                  const Icon(
                    IconlyLight.heart,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "20",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(width: 20),
                  const Icon(
                    FontAwesomeIcons.comment,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "5",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    IconlyLight.send,
                  ),
                ],
              ),
            ),
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
                        buttonOptions: const QuillToolbarButtonOptions(
                          backgroundColor: QuillToolbarColorButtonOptions(
                              iconTheme: QuillIconTheme(
                                  iconSelectedColor: primaryColor)),
                        ),
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
