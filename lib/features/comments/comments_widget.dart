import 'package:azsoon/Core/colors.dart';
import 'package:flutter/material.dart';

class Comments_Widget extends StatelessWidget {
  final String? commentText;
  final bool? like;
  final bool? disLike;
  final int? likesCounter;
  final int? disLikesCounter;
  final VoidCallback? onLikePressed;
  final VoidCallback? onDislikePressed;

  Comments_Widget({
    Key? key,
    this.commentText,
    this.like,
    this.disLike,
    this.likesCounter,
    this.disLikesCounter,
    this.onLikePressed,
    this.onDislikePressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Color.fromARGB(255, 248, 246, 246),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Row(
              children: [
                Text('Person name'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '3 days ago',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            subtitle: Text(
              commentText!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ),
          Row(
            children: [
              TextButton.icon(
                  onPressed: () {
                    //open a textfiled in the same comment container and type then
                  },
                  icon: Icon(Icons.reply),
                  label: Text('Reply')),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.thumb_up_alt_outlined,
                  ),
                  label: Text(likesCounter.toString())),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.thumb_down_alt_outlined,
                  ),
                  label: Text(disLikesCounter.toString())),
            ],
          ),
        ],
      ),
    );
  }
}




// import 'package:azsoon/Core/colors.dart';
// import 'package:flutter/material.dart';

// class Comments_Widget extends StatelessWidget {
//   final String? commentText;
//   final bool? like;
//   final bool? disLike;
//   final int? likesCounter;
//   final int? disLikesCounter;
//   final VoidCallback? onLikePressed;
//   final VoidCallback? onDislikePressed;

//   Comments_Widget({
//     Key? key,
//     this.commentText,
//     this.like,
//     this.disLike,
//     this.likesCounter,
//     this.disLikesCounter,
//     this.onLikePressed,
//     this.onDislikePressed,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//       margin: EdgeInsets.symmetric(vertical: 10),
//       color: Color.fromARGB(255, 248, 246, 246),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             leading: CircleAvatar(),
//             title: Row(
//               children: [
//                 Text('Person name'),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   '3 days ago',
//                   style: TextStyle(color: Colors.grey, fontSize: 15),
//                 ),
//               ],
//             ),
//             subtitle: Text(
//               commentText!,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 16),
//             ),
//           ),
//           Row(
//             children: [
//               TextButton.icon(
//                   onPressed: () {
//                     //open a textfiled in the same comment container and type then
//                   },
//                   icon: Icon(Icons.reply),
//                   label: Text('Reply')),
//               TextButton.icon(
//                   onPressed: () {
//                     // setState(() {
//                     //   like = !like;
//                     //   if (like == false) {
//                     //     likesCounter = likesCounter + 1;
//                     //   } else if (like == true) {
//                     //     likesCounter = likesCounter - 1;
//                     //   }
//                     // });
//                   },
//                   icon: like
//                       ? Icon(
//                           Icons.thumb_up_alt_outlined,
//                         )
//                       : Icon(
//                           Icons.thumb_up_alt,
//                         ),
//                   label: Text(likesCounter.toString())),
//               TextButton.icon(
//                   onPressed: () {
//                     // setState(() {
//                     //   disLike = !disLike;
//                     //   if (disLike == false) {
//                     //     disLikesCounter = disLikesCounter + 1;
//                     //   } else if (disLike == true) {
//                     //     disLikesCounter = disLikesCounter - 1;
//                     //   }
//                     // });
//                   },
//                   icon: disLike
//                       ? Icon(
//                           Icons.thumb_down_alt_outlined,
//                         )
//                       : Icon(
//                           Icons.thumb_down_alt,
//                         ),
//                   label: Text(disLikesCounter.toString())),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
