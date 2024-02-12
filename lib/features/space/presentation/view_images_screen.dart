import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:flutter/material.dart';

class ViewImagesScreen extends StatelessWidget {
  final List<PostImage> postImages;
  const ViewImagesScreen({super.key, required this.postImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Images'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Image(
          image: NetworkImage(postImages[index].image!),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: postImages.length,
      ),
    );
  }
}
