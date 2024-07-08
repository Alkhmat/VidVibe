import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vidvibe/src/core/firebase/firebase_collections/firebase_collections.dart';
import 'package:vidvibe/src/repository/auth/register_view.dart';
import 'package:vidvibe/src/repository/classes/repository_text.dart';
import 'package:vidvibe/src/repository/contents/cubit/add_content_cubit.dart';
import 'package:vidvibe/src/repository/contents/model/content_model.dart';
import 'package:vidvibe/src/repository/contents/video/video_player.dart';
import 'package:vidvibe/src/repository/home/bookmark_cubit/bookmark_cubit.dart';
import 'package:vidvibe/src/repository/home/favourite_cubit/likes_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: h * 0.07,
        leadingWidth: w,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            RepositoryText.hometext,
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: h * 0.033,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton<int>(
              color: Colors.black,
              onSelected: (value) {
                // Действия при выборе пункта меню
                if (value == 1) {
                  context.read<AddContentCubit>().addPhoto();
                } else if (value == 2) {
                  context.read<AddContentCubit>().addVideo();
                }
              },
              icon: Icon(
                Icons.add,
                size: h * 0.043,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add photo",
                        style: TextStyle(color: Colors.white),
                      ),
                      Image.asset(
                        'assets/icons/photo.png',
                        color: Colors.white,
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add media",
                        style: TextStyle(color: Colors.white),
                      ),
                      Image.asset(
                        'assets/icons/video.png',
                        color: Colors.white,
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterView(),
                  ),
                );
              },
              icon: Icon(
                Icons.person_outline,
                size: h * 0.043,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseCollections.content)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: h * 0.899,
                width: w,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white24,
                ),
              ),
            );
          }

          final contentDocs = snapshot.data?.docs ?? [];
          final contentList = contentDocs
              .map((doc) => ContentModel.fromFirestore(doc))
              .toList();

          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: h * 0.899,
                  width: w,
                  child: PageView.builder(
                    itemCount: contentList.length,
                    controller: PageController(initialPage: 0),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final content = contentList[index];

                      if (content.type == 'photo') {
                        return Container(
                          height: h * 0.899,
                          width: w,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(content.url),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white24,
                          ),
                          child: buildContentControls(h, index),
                        );
                      } else if (content.type == 'video') {
                        return VideoPlayerWidget(
                          url: content.url,
                          height: h * 0.899,
                          width: w,
                        );
                      }
                      return Container(
                        height: h * 0.899,
                        width: w,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white24,
                          image: const DecorationImage(
                              image: AssetImage(
                                'assets/img/9276433.png',
                              ),
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildContentControls(double h, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                height: h * 0.22,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: h * 0.08,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<FavoriteCubit, List<bool>>(
                      builder: (context, state) {
                        if (index >= state.length) {
                          return Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<FavoriteCubit>()
                                      .toggleFavorite(index);
                                },
                                icon: Icon(
                                  Icons.favorite_outline_outlined,
                                  color: Colors.white,
                                  size: h * 0.035,
                                ),
                              ),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<FavoriteCubit>()
                                    .toggleFavorite(index);
                              },
                              icon: Icon(
                                state[index]
                                    ? Icons.favorite
                                    : Icons.favorite_outline_outlined,
                                color: state[index] ? Colors.red : Colors.white,
                                size: h * 0.035,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.comment,
                        size: h * 0.035,
                        color: Colors.white,
                      ),
                    ),
                    BlocBuilder<BookMarkCubit, List<bool>>(
                      builder: (context, state) {
                        if (index >= state.length) {
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<BookMarkCubit>()
                                  .toggleBookMark(index);
                            },
                            icon: Icon(
                              Icons.bookmark_outline,
                              size: h * 0.035,
                              color: Colors.white,
                            ),
                          );
                        }

                        return IconButton(
                          onPressed: () {
                            context.read<BookMarkCubit>().toggleBookMark(index);
                          },
                          icon: Icon(
                            state[index]
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            size: h * 0.035,
                            color: state[index] ? Colors.white : Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
