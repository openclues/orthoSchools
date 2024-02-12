import 'dart:convert';
import 'dart:io';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/blog/bloc/cubit/blog_cupit_cubit.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/categories/bloc/categories_bloc.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blog/data/models/articles_model.dart';

class Blog {
  String title;
  String description;
  String cover;
  DateTime createdAt;
  String color;
  DateTime updatedAt;
  bool isPublished;
  String slug;
  List<String> category;
  // List<String> followers;

  Blog({
    required this.title,
    required this.description,
    required this.cover,
    required this.createdAt,
    required this.color,
    required this.updatedAt,
    required this.isPublished,
    required this.slug,
    required this.category,
    // required this.followers,
  });

  Blog copyWith({
    String? title,
    String? description,
    String? cover,
    DateTime? createdAt,
    String? color,
    DateTime? updatedAt,
    bool? isPublished,
    String? slug,
    List<String>? category,
    List<String>? followers,
  }) {
    return Blog(
      title: title ?? this.title,
      description: description ?? this.description,
      cover: cover ?? this.cover,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublished: isPublished ?? this.isPublished,
      slug: slug ?? this.slug,
      category: category ?? this.category,
      // followers: followers ?? this.followers,
    );
  }

  //to json
  Map<String, dynamic> get to => {
        'title': title,
        // 'updatedAt': updatedAt,
        // 'followers': followers,
      };
}

class BlogCreationScreen extends StatefulWidget {
  const BlogCreationScreen({super.key});

  @override
  _BlogCreationScreenState createState() => _BlogCreationScreenState();
}

class _BlogCreationScreenState extends State<BlogCreationScreen> {
  int _currentStep = 0;
  late Blog _blogData;

  @override
  void initState() {
    super.initState();
    _blogData = Blog(
      title: '',
      description: '',
      cover: '',
      createdAt: DateTime.now(),
      color: '#000000',
      updatedAt: DateTime.now(),
      isPublished: false,
      slug: '',
      category: [],
      // followers: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Your Blog',
            style: TextStyle(color: primaryColor),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      // hintText: 'Title',
                      // label: Text('Blog Title', textAlign: TextAlign.center),
                      border: InputBorder.none,
                      alignLabelWithHint: false

                      //border radius 10
                      ),
                  onChanged: (value) {
                    setState(() {
                      _blogData = _blogData.copyWith(title: value);
                    });
                  },
                ),
              ),
            ),
            //description text area
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        var categoreState =
                            context.read<CategoriesBloc>().state;
                        if (categoreState is CategoriesLoaded) {
                          return ListView.builder(
                            itemCount: categoreState.categories!.length,
                            itemBuilder: (context, index) {
                              var value = _blogData.category.contains(
                                  categoreState.categories![index].name!);
                              return ListTile(
                                onTap: () {
                                  if (_blogData.category.contains(
                                      categoreState.categories![index].name!)) {
                                    setState(() {
                                      _blogData.category.remove(categoreState
                                          .categories![index].name!);
                                    });
                                  } else {
                                    setState(() {
                                      var categoies = _blogData.category;
                                      categoies.add(categoreState
                                          .categories![index].name!);
                                      _blogData.copyWith(category: categoies);
                                    });
                                  }
                                },
                                subtitle: Text(_blogData.category.contains(
                                        categoreState.categories![index].name!)
                                    ? 'Selected'
                                    : 'Not Selected'),
                                leading: Checkbox(
                                  value: value,
                                  onChanged: (value) {
                                    print(value);
                                    if (_blogData.category.contains(
                                        categoreState
                                            .categories![index].name!)) {
                                      setState(() {
                                        _blogData.category.remove(categoreState
                                            .categories![index].name!);
                                      });
                                      setState(() {});
                                    } else {
                                      setState(() {
                                        _blogData.category.add(categoreState
                                            .categories![index].name!);
                                      });
                                      setState(() {});
                                    }
                                  },
                                ),
                                title: Text(
                                    categoreState.categories![index].name!),
                                // onTap: () {
                                //   if (_blogData.category.contains(
                                //       categoreState.categories![index].name!)) {
                                //     setState(() {
                                //       _blogData.category.remove(categoreState
                                //           .categories![index].name!);
                                //     });
                                //   } else {
                                //     setState(() {
                                //       _blogData.category.add(categoreState
                                //           .categories![index].name!);
                                //     });
                                //   }

                                //   // Navigator.pop(context);
                                // },
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(_blogData.category.isEmpty
                              ? 'Select Main Categories'
                              : _blogData.category.toList().toString()),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: "Description",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      // hintText: 'Title',
                      // label: Text('Blog Title', textAlign: TextAlign.center),
                      border: InputBorder.none,
                      alignLabelWithHint: false

                      //border radius 10
                      ),
                  onChanged: (value) {
                    setState(() {
                      _blogData = _blogData.copyWith(description: value);
                    });
                  },
                ),
              ),
            ),
            //cover image
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: BlogCoverImageForm(
                    blogData: _blogData, onChanged: _updateBlogData),
              ),
            ),
            //publish
            Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_blogData.title.isEmpty ||
                            _blogData.description.isEmpty ||
                            _blogData.cover.isEmpty ||
                            _blogData.category.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all the fields'),
                            ),
                          );
                          return;
                        }
                        List<int> categories = [];
                        for (var item in _blogData.category) {
                          categories.add((context.read<CategoriesBloc>().state
                                  as CategoriesLoaded)
                              .categories!
                              .firstWhere((element) => element.name == item)
                              .id!);
                        }
                        var response = await RequestHelper.post(
                            'blog/create',
                            {
                              'title': _blogData.title,
                              'description': _blogData.description,
                              'cover': _blogData.cover,
                              'color': _blogData.color,
                              'isPublished': _blogData.isPublished,
                              'slug': _blogData.slug,
                              'category': jsonEncode(categories),
                            },
                            files: [XFile(_blogData.cover)],
                            filesKey: 'cover');

                        if (response.statusCode == 201) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Blog created successfully'),
                              ),
                            );
                            context.read<ProfileBloc>().add(
                                UpdateProfileLocally(
                                    profileLoaded: (context
                                        .read<ProfileBloc>()
                                        .state as ProfileLoaded),
                                    newProfile: (context
                                            .read<ProfileBloc>()
                                            .state as ProfileLoaded)
                                        .profileModel
                                        .copyWith(
                                          blog: BlogsModel.fromJson(jsonDecode(
                                              utf8.decode(response.bodyBytes))),
                                        )));
                          }

                          print(response.body);
                          BlogsModel blog = BlogsModel.fromJson(
                              jsonDecode(utf8.decode(response.bodyBytes)));
                          if (mounted) {
                            // context.read<ProfileBloc>().add(const LoadMyProfile());

                            Navigator.of(context).pushNamed(
                                BlogScreen.routeName,
                                arguments: blog);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => BlocProvider(
                            //       create: (context) => BlogCupitCubit(),
                            //       child: BlogScreen(blog: blog),
                            //     ),
                            //   ),
                            // );
                          }

                          // Navigator.of(context).pushNamed(BlogScreen.routeName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Something went wrong'),
                            ),
                          );
                        }
                        // _handleStepContinue(context);
                      },
                      child: const Text('Publish'),
                    ))),
          ],
        ));
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text('Basic Information'),
        content:
            BlogBasicInfoForm(blogData: _blogData, onChanged: _updateBlogData),
      ),
      Step(
        title: const Text('Cover Image'),
        content:
            BlogCoverImageForm(blogData: _blogData, onChanged: _updateBlogData),
      ),
      Step(
        title: const Text('Publish'),
        content:
            BlogPublishForm(blogData: _blogData, onChanged: _updateBlogData),
      ),
    ];
  }

  void _updateBlogData(Blog updatedData) {
    setState(() {
      _blogData = updatedData;
    });
  }

  void _handleStepContinue(BuildContext context) async {
    if (_currentStep < _buildSteps().length - 1) {
      if (_currentStep == 0 &&
          (_blogData.title.isEmpty || _blogData.description.isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a title'),
          ),
        );
        return;
      }
      setState(() {
        _currentStep += 1;
      });
    } else {
      var response = await RequestHelper.post(
          'blog/create',
          {
            'title': _blogData.title,
            'description': _blogData.description,
            'cover': _blogData.cover,
            'color': _blogData.color,
            'isPublished': _blogData.isPublished,
            'slug': _blogData.slug,
            'category': 1,
          },
          files: [XFile(_blogData.cover)],
          filesKey: 'cover');

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Blog created successfully'),
          ),
        );
        print(response.body);
        BlogsModel blog =
            BlogsModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        if (mounted) {
          // context.read<ProfileBloc>().add(const LoadMyProfile());

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlogCupitCubit(),
                child: BlogScreen(blog: blog),
              ),
            ),
          );
        }

        // Navigator.of(context).pushNamed(BlogScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
    }
  }

  void _handleStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }
}

class BlogBasicInfoForm extends StatelessWidget {
  final Blog blogData;
  final ValueChanged<Blog> onChanged;

  BlogBasicInfoForm(
      {super.key, required this.blogData, required this.onChanged});

  final List<String> availableColors = [
    '#FF5733',
    '#3498DB',
    '#27AE60',
    '#F39C12',
    '#9B59B6'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Title',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the title of your blog',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                onChanged(blogData.copyWith(title: value));
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter a brief description of your blog',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                onChanged(blogData.copyWith(description: value));
              },
            ),
          ),
          // const SizedBox(height: 16),
          const SizedBox(height: 8),
          // Container(
          //   height: 50,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: availableColors.length,
          //     itemBuilder: (context, index) {
          //       final color = availableColors[index];
          //       final isSelected = blogData.color == color;

          //       return GestureDetector(
          //         onTap: () {
          //           onChanged(blogData.copyWith(color: color));
          //         },
          //         child: Container(
          //           margin: const EdgeInsets.symmetric(horizontal: 8),
          //           width: 50,
          //           height: 50,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Color(int.parse(color.substring(1, 7), radix: 16) +
          //                 0xFF000000),
          //             border: Border.all(
          //               color:
          //                   isSelected ? Colors.blueAccent : Colors.transparent,
          //               width: 2,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class BlogCoverImageForm extends StatefulWidget {
  final Blog blogData;
  final ValueChanged<Blog> onChanged;

  const BlogCoverImageForm(
      {super.key, required this.blogData, required this.onChanged});

  @override
  _BlogCoverImageFormState createState() => _BlogCoverImageFormState();
}

class _BlogCoverImageFormState extends State<BlogCoverImageForm> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        widget.onChanged(widget.blogData.copyWith(cover: pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   'Cover Image',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      Icons.add_photo_alternate,
                      size: 40,
                      color: Colors.grey,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlogCategoriesForm extends StatelessWidget {
  final Blog blogData;
  final ValueChanged<Blog> onChanged;

  const BlogCategoriesForm(
      {super.key, required this.blogData, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // Implement the form fields for categories
    return Container(
        // Your form fields go here
        );
  }
}

class BlogPublishForm extends StatelessWidget {
  final Blog blogData;
  final ValueChanged<Blog> onChanged;

  const BlogPublishForm(
      {super.key, required this.blogData, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // Implement the form fields for publish
    return Container(
        // Your form fields go here
        );
  }
}
