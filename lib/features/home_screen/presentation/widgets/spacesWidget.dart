import 'dart:math';
import 'dart:ui';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/features/home_screen/data/models/recommended_spaces_model.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spaceCardComponents.dart';
import 'package:azsoon/features/home_screen/presentation/widgets/spacesData.dart';
import 'package:azsoon/features/join_space/bloc/join_space_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../widgets/Post.dart';
import '../bloc/home_screen_bloc.dart';

class SpacesList extends StatefulWidget {
  const SpacesList({Key? key}) : super(key: key);

  @override
  State<SpacesList> createState() => _SpacesListState();
}

class _SpacesListState extends State<SpacesList> {
  // Example data for the list of spaces

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is HomeScreenLoaded &&
            state.homeScreenModel.recommendedSpaces!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: LocalStorage.getcreenSize(context).height * 0.01,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Text(
                  'Recommended Spaces',
                  style: TextStyle(
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: LocalStorage.getcreenSize(context).height * 0.18,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width:
                              LocalStorage.getcreenSize(context).width * 0.01,
                        ),
                        for (int i = 0;
                            i < state.homeScreenModel.recommendedSpaces!.length;
                            i++)
                          RecommendedSpaceCard(
                            recommendedSpace:
                                state.homeScreenModel.recommendedSpaces![i],
                          ),
                        SizedBox(
                          width:
                              LocalStorage.getcreenSize(context).width * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class RecommendedSpaceCard extends StatelessWidget {
  final RecommendedSpace recommendedSpace;

  const RecommendedSpaceCard({Key? key, required this.recommendedSpace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.height * 0.02,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.height * 0.02,
        ),
        child: Stack(
          children: [
            Image.network(
              recommendedSpace.cover ?? "",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              color:
                  Colors.white.withOpacity(0.5), // Adjust the opacity as needed
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 0.3,
                    sigmaY: 0.3), // Adjust the sigma values as needed
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            recommendedSpace.name ?? "",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // const Spacer(),
                      Container(
                        // margin: const EdgeInsets.all(8),
                        // padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            recommendedSpace.type == "premium"
                                ? Image.asset(
                                    'assets/images/premium.png',
                                    width: 30,
                                    height: 30,
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const Spacer(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            recommendedSpace.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // const Spacer(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.people_rounded,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${recommendedSpace.membersCount} members',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              JoinButton(
                                isJoined: recommendedSpace.isJoined ?? false,
                                spaceId: recommendedSpace.id ?? 0,
                                isAllowedToJoin:
                                    recommendedSpace.isAllowedToJoin ?? false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RecommdedSpaceCard extends StatelessWidget {
//   final RecommendedSpace recommendedSpace;
//   const RecommdedSpaceCard({
//     required this.recommendedSpace,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 330,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage(recommendedSpace.cover!),
//           fit: BoxFit.cover,
//         ),
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Stack(
//         children: [
//           Positioned.fill(
//             top: 30,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               height: 75,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(15), // Adjust the top-left radius
//                 ),
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               ListTile(
//                 contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
//                 title: Text(
//                   recommendedSpace.name!,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   recommendedSpace.description!,
//                   style: const TextStyle(fontSize: 14),
//                 ),
//                 trailing: Icon(recommendedSpace.isAllowedToJoin == true
//                     ? Icons.face_unlock_rounded
//                     : Icons.lock),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.people,
//                       color: Colors.grey,
//                     ),
//                     Text('${recommendedSpace.membersCount} members')
//                   ],
//                 ),
//               ),
//               // categories
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: recommendedSpace.category!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//                     child: Row(
//                       children: [
//                         if (recommendedSpace.category![index].image != null)
//                           Image.network(
//                             recommendedSpace.category![index].image!,
//                             width: 20,
//                             height: 20,
//                           ),
//                         Text('${recommendedSpace.category![index].name}')
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
