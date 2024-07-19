import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidvibe/src/core/firebase/options/firebase_options.dart';
import 'package:vidvibe/src/repository/auth/auth_cubit/auth_cubit.dart';
import 'package:vidvibe/src/repository/auth/profile/cubit/image_cubit.dart';
import 'package:vidvibe/src/repository/auth/profile/cubit_2/tap_cubit.dart';
// import 'package:vidvibe/src/repository/auth/profile/setting/setting_profile_view.dart';
import 'package:vidvibe/src/repository/contents/cubit/add_content_cubit.dart';
import 'package:vidvibe/src/repository/home/bookmark_cubit/bookmark_cubit.dart';
import 'package:vidvibe/src/repository/home/favourite_cubit/likes_cubit.dart';
import 'package:vidvibe/src/repository/home/home_view.dart';
// import 'package:vidvibe/src/repository/home/home_view.dart';
import 'package:vidvibe/src/repository/home/load_cubit/load_cubit.dart';
// import 'package:vidvibe/src/repository/navbar/bottom_cubit/bottom_cubit.dart';
// import 'package:vidvibe/src/repository/welcome/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const VidVibe());
}

class VidVibe extends StatelessWidget {
  const VidVibe({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => TapCubit(),
        ),
        // BlocProvider(
        //   create: (context) => BottomNavCubit(),
        // ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => BookMarkCubit(),
        ),
        BlocProvider(
          create: (context) => AddContentCubit(),
        ),
        BlocProvider(
          create: (context) => LoadUpgradeCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
