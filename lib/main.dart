import  'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/data/api_config/api_client.dart';
import 'package:movies_app/data/dara_source/movie_remote_data_source.dart';
import 'package:movies_app/data/dara_source/movie_search_data_source.dart';
import 'package:movies_app/presentation/blocs/internet_cubit/internet_cubit.dart';
import 'package:movies_app/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:movies_app/presentation/blocs/navigation_cubit/navigation_cubit.dart';
import 'package:movies_app/presentation/blocs/search_movie_bloc/search_bloc.dart';
import 'package:movies_app/presentation/view/main/choose_download_screen.dart';
import 'package:movies_app/presentation/view/main/combain_screen.dart';
import 'package:movies_app/presentation/view/main/movie_info_screen.dart';
import 'package:movies_app/presentation/view/main/video_play_screen.dart';
import 'package:movies_app/presentation/view/main_screen.dart';
import 'package:movies_app/presentation/view/register/introduction_screen.dart';
import 'package:movies_app/presentation/view/register/main_page.dart';
import 'package:movies_app/presentation/view/register/sign_in_screen.dart';
import 'package:movies_app/presentation/view/register/sign_up_screen.dart';
import 'package:movies_app/presentation/widgets/item_list_widget.dart';
import 'package:movies_app/presentation/widgets/rout_error_screen.dart';
import 'package:movies_app/splash_screen.dart';
import 'data/hive_box/local_storage.dart';
import 'data/models/movie_model.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  moviesList = await Hive.openBox<MovieModel>('favour_movies');
  userData=await Hive.openBox<String>('user_data');
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyD9SOHa6p0UWbUopkkSwqGLs0Zfq3QccQE',
              appId: "1:514288857046:android:dc871a65c5331e0edffe77",
              messagingSenderId: "514288857046",
              projectId: "movies-app-1de78"))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MovieBloc(
                movieRemoteDataSourceImpl:
                    MovieRemoteDataSourceImpl(ApiClient(Dio())))
              ..add(InitialMovieEvent())),
        BlocProvider<InternetCubit>(
            create: (context) => InternetCubit()
              ..checkConnectivity()
              ..trackConnectivityChange()),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(
            create: (context) =>
                SearchBloc(MovieSearchRemote(ApiClient(Dio()))))
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  errorBuilder: (context,state)=> const RoutErrorScreen(),

 initialLocation: userData.isEmpty?'/':'/combain',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
),
        GoRoute(
          path: '/introduce',
          name: 'introduce',
          builder: (BuildContext context, GoRouterState state) {
            return const IntroductionScreen();
          },
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: '/signin',
          name: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInScreen();
          },
        ),
        GoRoute(
          path: '/main',
          name: 'main',
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          },
        ),
        GoRoute(
          path: '/combain',
          name: 'combain',
          builder: (BuildContext context, GoRouterState state) {
            return const CombainScreen();
          },
        ),
        GoRoute(
          path: '/mainpage',
          name: 'mainpage',
          builder: (BuildContext context, GoRouterState state) {
            return const MainPage();
          },
        ),
        GoRoute(
          path: '/itemListWidget/movies/:categoryName/:count',
          name: 'itemListWidget',
          builder: (BuildContext context, GoRouterState state) {
            List<MovieModel> movies = state.extra as List<MovieModel>;
            return ItemListWidget(
              movies: movies,
              categoryName: state.pathParameters['categoryName'] ?? '',
              count: state.pathParameters['count'] ?? '2',
            );
          },
        ),
        GoRoute(
          path: '/movieInfoScreen/movies',
          name: 'movieInfoScreen',
          builder: (BuildContext context, GoRouterState state) {
            MovieModel movie = state.extra as MovieModel;
            return MovieInfoScreen(
              movie: movie,
            );
          },
        ),
        GoRoute(
          path: '/videoPlayerScreen/:videoUrl',
          name: 'videoPlayerScreen',
          builder: (BuildContext context, GoRouterState state) {
            return VideoPlayScreen(
              videoUrl: state.pathParameters['videoUrl'] ?? '',
            );
          },
        ),
        GoRoute(
          path: '/chooseDownloadScreen/:videoUrl',
          name: 'chooseDownloadScreen',
          builder: (BuildContext context, GoRouterState state) {
            return ChooseDownloadScreen(
              videoUrl: state.pathParameters['videoUrl'] ?? '',
            );
          },
        ),


  ],
);
