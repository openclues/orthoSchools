import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/features/home_screen/data/models/recommended_spaces_model.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../space/presentation/space_screen.dart';
import '../../bloc/home_screen_bloc.dart';

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
        if (state is HomeScreenLoaded && state.recommendedSpaces.isNotEmpty) {
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
                    fontSize: 17,
                    color: Color(0xff5B5C9D),
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: LocalStorage.getcreenSize(context).height * 0.25,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width:
                              LocalStorage.getcreenSize(context).width * 0.01,
                        ),
                        for (int i = 0; i < state.recommendedSpaces.length; i++)
                          RecommendedSpaceCard(
                            recommendedSpace: state.recommendedSpaces[i],
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
      margin: const EdgeInsets.only(left: 8),
      width: MediaQuery.of(context).size.width * 0.9,
      // height: MediaQuery.of(context).size.height * 0.1,
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
            Container(
              color: primaryColor,
              child: Image.network(
                recommendedSpace.cover ?? "",
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                // height: double.infinity,
                colorBlendMode: BlendMode.multiply,
                color: primaryColor.withOpacity(1),
                fit: BoxFit.cover,
              ),
            ),
            // Container(
            //   color:
            //       Colors.white.withOpacity(0.5), // Adjust the opacity as needed
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(
            //         sigmaX: 0.1,
            //         sigmaY: 0.1), // Adjust the sigma values as needed
            //     child: Container(
            //       color: primaryColor.withOpacity(0.9),
            //     ),
            //   ),
            // ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Spacer(),
                    Text(
                      recommendedSpace.name ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      recommendedSpace.description ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     // const Spacer(),
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    //         child: Text(
                    //           recommendedSpace.description!,
                    //           maxLines: 2,
                    //           overflow: TextOverflow.ellipsis,
                    //           // textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.grey[300],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const Spacer(),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                          
                              backgroundColor: Colors.white,
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            onPressed: () async {
                              await Navigator.pushNamed(
                                  context, SpaceScreen.routeName,
                                  arguments: recommendedSpace);
                              // setState(() {});

                              // context.read<HomeScreenBloc>().add(
                              //     HomeScreenJoinSpaceEvent(
                              //         recommendedSpace.id!));
                            },
                            child: const Text('Join Now')),
                        const Spacer(),
                        Text(
                          '${recommendedSpace.membersCount}  Participants',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            recommendedSpace.type == "premium"
                ? Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/premium.png',
                      width: 50,
                      height: 50,
                    ),
                  )
                : const SizedBox()
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
