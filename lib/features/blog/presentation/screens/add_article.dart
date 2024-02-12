import 'dart:io';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/categories/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill/quill_delta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';


class AddArticleScreen extends StatefulWidget {
  final int? blogId;
  const AddArticleScreen({Key? key, required this.blogId}) : super(key: key);

  @override
  _AddArticleScreenState createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController coverController = TextEditingController();
  XFile? coverFile;
  bool isFeatured = false;
  String? title;
  // Delta content = Delta();
  // final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  bool? isLoading = false;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  XFile? cover;
  void _onFocusChange() {
    debugPrint("Focus: ${_focusNode.hasFocus.toString()}");
    setState(() {});
  }

  List<int> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButton: _focusNode.hasFocus == true
      //     ? QuillToolbar.simple(
      //         configurations: QuillSimpleToolbarConfigurations(
      //           multiRowsDisplay: false,
      //           controller: _controller,
      //           axis: Axis.horizontal,
      //         ),
      //       )
      //     : null,
      appBar: AppBar(
        title: const Text('Add Article'),
        actions: [
          //save
          IconButton(
            onPressed: () async {
              print(categories);
              showDialog(
                  context: context,
                  builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  barrierDismissible: false);
              // var response = await RequestHelper.post(
              //     'create/article',
              //     {
              //       "blog_id": widget.blogId,
              //       'title': titleController.text,
              //       'content': jsonEncode({
              //         "delta": jsonEncode({
              //           "ops": _controller.document.toDelta().toJson(),
              //         }),
              //         "html": '<p>hello</p>'
              //       }),
              //       'is_featured': isFeatured,
              //       'categories': jsonEncode(categories),
              //     },
              //     files: [cover!],
              //     filesKey: 'cover');
              setState(() {
                isLoading = false;
              });
              // if (response.statusCode == 201) {
              //   Navigator.pop(context);
              //   Navigator.pop(context);
              // } else {}
            },
            icon: const Icon(FontAwesomeIcons.save),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            //cover
            //title
            //
            SizedBox(
              height: 65,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount:
                    (context.read<CategoriesBloc>().state as CategoriesLoaded)
                        .categories!
                        .length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (categories.contains((context
                              .read<CategoriesBloc>()
                              .state as CategoriesLoaded)
                          .categories!
                          .elementAt(index)
                          .id)) {
                        categories.remove((context.read<CategoriesBloc>().state
                                as CategoriesLoaded)
                            .categories!
                            .elementAt(index)
                            .id);
                      } else {
                        categories.add((context.read<CategoriesBloc>().state
                                as CategoriesLoaded)
                            .categories!
                            .elementAt(index)
                            .id!);
                      }
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categories.contains((context
                                      .read<CategoriesBloc>()
                                      .state as CategoriesLoaded)
                                  .categories!
                                  .elementAt(index)
                                  .id)
                              ? primaryColor
                              : Colors.white,
                          border: Border.all(color: primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              (context.read<CategoriesBloc>().state
                                      as CategoriesLoaded)
                                  .categories![index]
                                  .name!,
                              style: TextStyle(
                                color: categories.contains((context
                                            .read<CategoriesBloc>()
                                            .state as CategoriesLoaded)
                                        .categories!
                                        .elementAt(index)
                                        .id)
                                    ? Colors.white
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //Switcher to show if the article is featured or not
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Featured",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      )),
                  Switch(
                    value: isFeatured,
                    onChanged: (value) {
                      setState(() {
                        isFeatured = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: cover == null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery)
                                .then((value) {
                              setState(() {
                                cover = value;
                              });
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Column(
                              children: [
                                const Icon(
                                  Icons.image,
                                  color: primaryColor,
                                  size: 30.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Article Cover",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                      )
                    : Image.file(File(cover!.path),
                        fit: BoxFit.cover, height: 100),
              ),
            ),

            RawKeyboardListener(
              focusNode: _focusNode,
              onKey: (RawKeyEvent event) {
                if (event.runtimeType == RawKeyUpEvent &&
                    event.logicalKey == LogicalKeyboardKey.enter) {
                  // Scroll logic here
                  Scrollable.ensureVisible(
                    _focusNode.context!,
                    duration: const Duration(milliseconds: 300),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  controller: titleController,
                  style: MaterialStateTextStyle.resolveWith((states) {
                    return const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    );
                  }),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Article Title',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10.0),
            const Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: QuillEditor.basic(
            //     focusNode: _focusNode,
            //     configurations: QuillEditorConfigurations(
            //       placeholder: 'Add Article Content',
            //       scrollable: false,
            //       padding: EdgeInsets.zero,
            //       showCursor: true,
            //       // scrollable: true,
            //       controller: _controller,
            //     ),
            //   ),
            // ),

            const SizedBox(height: 50.0),
            // ElevatedButton(
            //     onPressed: () async {
            //       print(_controller.document.toDelta().toJson());
            //       print(titleController.text);
            //       print(coverFile!.path);
            //       var response = await RequestHelper.post(
            //           'create/article',
            //           {
            //             "blog_id": 14,
            //             'title': titleController.text,
            //             'content':
            //                 jsonEncode(_controller.document.toDelta().toJson()),
            //             'cover': coverFile!.path,
            //             'is_featured': isFeatured,
            //           },
            //           files: [coverFile!],
            //           filesKey: 'cover');
            //       print(response.body);
            //     },
            //     child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}

                  // createArticle();

