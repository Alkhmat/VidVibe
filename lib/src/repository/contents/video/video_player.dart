import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:vidvibe/src/repository/contents/video/cubit/video_cubit.dart';
import 'package:vidvibe/src/repository/contents/video/cubit/video_state.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  const VideoPlayerWidget({
    super.key,
    required this.url,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => VideoCubit(url)..initialize(),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => context.read<VideoCubit>().togglePlayPause(),
            child: Container(
              height: height,
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.black45,
              ),
              child: state.controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: state.controller.value.aspectRatio,
                      child: VideoPlayer(state.controller),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: w * 0.01,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
