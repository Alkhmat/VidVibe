// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vidvibe/src/core/enum/bottom_nav_bar.dart';
// import 'package:vidvibe/src/repository/home/home_view.dart';
// import 'package:vidvibe/src/repository/navbar/bottom_cubit/bottom_cubit.dart';

// class HomeBottom extends StatelessWidget {
//   const HomeBottom({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => BottomNavCubit(),
//       child: BlocBuilder<BottomNavCubit, BottomNavItem>(
//         builder: (context, currentItem) {
//           return Scaffold(
//             backgroundColor: Colors.black,
//             body: IndexedStack(
//               index: currentItem.index,
//               children: const [
//                 HomeView(),
//               ],
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               backgroundColor: Colors.black,
//               selectedItemColor: Colors.white,
//               unselectedItemColor: Colors.grey,
//               currentIndex: currentItem.index,
//               onTap: (index) {
//                 context
//                     .read<BottomNavCubit>()
//                     .updateNavItem(BottomNavItem.values[index]);
//               },
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home, size: 24.0),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.search, size: 24.0),
//                   label: 'Search',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.notifications, size: 24.0),
//                   label: 'Notifications',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person, size: 24.0),
//                   label: 'Profile',
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
