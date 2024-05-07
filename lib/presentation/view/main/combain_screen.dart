import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/presentation/blocs/carousel_cubit/carousel_cubit.dart';
import 'package:movies_app/presentation/blocs/internet_cubit/internet_cubit.dart';
import 'package:movies_app/presentation/blocs/navigation_cubit/navigation_cubit.dart';
import 'package:movies_app/presentation/view/main/downloaded_screen.dart';
import 'package:movies_app/presentation/view/main/home_screen.dart';
import 'package:movies_app/presentation/view/main/profile_screen.dart';
import 'package:movies_app/presentation/view/main/save_screen.dart';
import 'package:movies_app/presentation/view/main/search_screen.dart';
import 'package:movies_app/utilis/all_colors.dart';

class CombainScreen extends StatelessWidget {
  const CombainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = [
      const HomeScreen(),
      const SearchScreen(),
      const DownloadedScreen(),
      const SaveScreen(),
      const ProfileScreen()
    ];
    return PopScope(
      canPop: true,
     onPopInvoked: (isTrue){
       if(isTrue){
         context.pop();
       }
     },
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<InternetCubit>()
              ..checkConnectivity()
              ..trackConnectivityChange();

            // BlocConsumer<InternetCubit, InternetStatus>(
            //   builder: (BuildContext context, InternetStatus state) {
            //     print(' builder ishlavotti');
            //
            //     if (state.status != ConnectivityStatus.connected) {
            //       print(true);
            //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //         content: Text('Network Error'),
            //         duration: Duration(seconds: 2),
            //       ));
            //     }
            //     return SizedBox.shrink();
            //   },
            //   listener: (BuildContext context, InternetStatus state) {
            //     print('ishlavotti');
            //
            //     if (state.status != ConnectivityStatus.connected) {
            //       print(true);
            //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //         content: Text('Network Error'),
            //         duration: Duration(seconds: 2),
            //       ));
            //     }
            //   },
            // );
          },
          child: BlocListener<InternetCubit, InternetStatus>(
            listener: (context, state) {
              if (state.status != ConnectivityStatus.connected) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('You are Offline'),
                  duration: Duration(seconds: 2),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('You are Online'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Scaffold(
              backgroundColor: AllColors.primaryBackColor,
              extendBody: true,
              body: list[state.index],
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19)),
                child: BottomNavigationBar(
                  showSelectedLabels: true,
                  backgroundColor: Colors.black.withOpacity(0.8),
                  unselectedItemColor: Colors.white60,
                  selectedItemColor: Colors.white,
                  currentIndex: state.index,
                  showUnselectedLabels: true,
                  onTap: (index) {
                    context.read<NavigationCubit>().changeIndex(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        color:
                            state.index == 0 ? Colors.white : Colors.white60,
                        width: 27,
                        height: 27,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/search.svg',
                          color:
                          state.index == 1 ? Colors.white : Colors.white60,
                          width: 24,
                          height: 24,
                        ),
                        label: 'Search'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/download.svg',
                          color:
                          state.index == 2 ? Colors.white : Colors.white60,
                          width: 24,
                          height: 24,
                        ),
                        label: 'Downloaded'),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/save.svg',
                        color:
                        state.index == 3 ? Colors.white : Colors.white60,
                        width: 24,
                        height: 24,
                      ),
                      label: 'Save',
                    ),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/account.svg',
                          color:
                          state.index == 4 ? Colors.white : Colors.white60,
                          width: 24,
                          height: 24,
                        ),
                        label: 'Profile'),
                  ],
                ),
              ),
            );
        },
      ),
          ),
        ),
      ),
    );
  }
}

// toastMessage() {
//   BlocListener<InternetCubit, InternetStatus>(
//     listener: (context, state) {
//       print('toast ishlavotti');
//       if(state.status==ConnectivityStatus.disconnected){
//         print(true);
//         Fluttertoast.showToast(
//             msg: "This is Center Short Toast",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//       }
//     },
//   );
// }
