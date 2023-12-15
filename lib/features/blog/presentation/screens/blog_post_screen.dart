import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              ApiEndpoints.baseUrl + blogPostModel!.cover!,
              fit: BoxFit.fitHeight,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 2),
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
