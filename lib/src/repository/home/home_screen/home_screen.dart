// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vidvibe/src/repository/contents/model/content_model.dart';
// import 'package:vidvibe/src/repository/contents/video/video_player.dart';
// import 'package:vidvibe/src/repository/home/bookmark_cubit/bookmark_cubit.dart';
// import 'package:vidvibe/src/repository/home/favourite_cubit/likes_cubit.dart';
// import 'package:vidvibe/src/repository/home/load_cubit/load_cubit.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<LoadUpgradeCubit>().refreshContent();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;

//     return RefreshIndicator(
//       color: Colors.white,
//       backgroundColor: Colors.black,
//       onRefresh: () async {
//         context.read<LoadUpgradeCubit>().refreshContent();
//       },
//       child: BlocBuilder<LoadUpgradeCubit, List<ContentModel>>(
//         builder: (context, contentList) {
//           return contentList.isEmpty
//               ? Center(
//                   child: Container(
//                     height: h * 0.899,
//                     width: w,
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 5,
//                       vertical: 7,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(14),
//                       color: Colors.white24,
//                     ),
//                   ),
//                 )
//               : Column(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         height: h * 0.899,
//                         width: w,
//                         child: PageView.builder(
//                           itemCount: contentList.length,
//                           controller: PageController(initialPage: 0),
//                           scrollDirection: Axis.vertical,
//                           itemBuilder: (context, index) {
//                             final content = contentList[index];

//                             if (content.type == 'photo') {
//                               return Container(
//                                 height: h * 0.899,
//                                 width: w,
//                                 margin: const EdgeInsets.symmetric(
//                                   horizontal: 5,
//                                   vertical: 7,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image:
//                                         CachedNetworkImageProvider(content.url),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   borderRadius: BorderRadius.circular(14),
//                                   color: Colors.white24,
//                                 ),
//                                 child: buildContentControls(h, index),
//                               );
//                             } else if (content.type == 'video') {
//                               return VideoPlayerWidget(
//                                 url: content.url,
//                                 height: h * 0.899,
//                                 width: w,
//                               );
//                             }
//                             return Container(
//                               height: h * 0.899,
//                               width: w,
//                               margin: const EdgeInsets.symmetric(
//                                 horizontal: 5,
//                                 vertical: 7,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(14),
//                                 color: Colors.white24,
//                                 image: const DecorationImage(
//                                   image: AssetImage(
//                                     'assets/img/9276433.jpg',
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//         },
//       ),
//     );
//   }

//   Widget buildContentControls(double h, int index) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 355,
//               ),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 5,
//                   vertical: 5,
//                 ),
//                 height: h * 0.22,
//                 decoration: BoxDecoration(
//                   color: Colors.black38,
//                   border: Border.all(color: Colors.black, width: 1),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 width: h * 0.06,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     BlocBuilder<FavoriteCubit, List<bool>>(
//                       builder: (context, state) {
//                         if (index >= state.length) {
//                           return Column(
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   context
//                                       .read<FavoriteCubit>()
//                                       .toggleFavorite(index);
//                                 },
//                                 icon: Icon(
//                                   Icons.favorite_outline_outlined,
//                                   color: Colors.white,
//                                   size: h * 0.035,
//                                 ),
//                               ),
//                             ],
//                           );
//                         }

//                         return Column(
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 context
//                                     .read<FavoriteCubit>()
//                                     .toggleFavorite(index);
//                               },
//                               icon: Icon(
//                                 state[index]
//                                     ? Icons.favorite
//                                     : Icons.favorite_outline_outlined,
//                                 color: state[index] ? Colors.red : Colors.white,
//                                 size: h * 0.035,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.comment,
//                         size: h * 0.035,
//                         color: Colors.white,
//                       ),
//                     ),
//                     BlocBuilder<BookMarkCubit, List<bool>>(
//                       builder: (context, state) {
//                         if (index >= state.length) {
//                           return IconButton(
//                             onPressed: () {
//                               context
//                                   .read<BookMarkCubit>()
//                                   .toggleBookMark(index);
//                             },
//                             icon: Icon(
//                               Icons.bookmark_outline,
//                               size: h * 0.035,
//                               color: Colors.white,
//                             ),
//                           );
//                         }

//                         return IconButton(
//                           onPressed: () {
//                             context.read<BookMarkCubit>().toggleBookMark(index);
//                           },
//                           icon: Icon(
//                             state[index]
//                                 ? Icons.bookmark
//                                 : Icons.bookmark_outline,
//                             size: h * 0.035,
//                             color: state[index] ? Colors.white : Colors.white,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
