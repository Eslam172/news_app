import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/shared/app_bloc/app_cubit/app_cubit.dart';
import 'package:news_app/shared/app_bloc/app_cubit/app_states.dart';
import 'package:news_app/shared/app_bloc/my_bloc_observer.dart';
import 'package:news_app/shared/app_bloc/news_cubit/news_cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  BlocOverrides.runZoned(
        () {
      // Use cubits...
          runApp( MyApp(isDark));

        },
    blocObserver: MyBlocObserver(),

  );

}


class MyApp extends StatelessWidget {
   bool? isDark;

   MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
            fromShared: isDark
        ),),
        BlocProvider(create: (BuildContext context) => NewsCubit())
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){},
        builder: (context , state){

          var cubit = AppCubit.get(context);
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                    color: Colors.white,
                    elevation: 0,
                    actionsIconTheme: IconThemeData(
                        color: Colors.black
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    titleSpacing: 20,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    )
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    elevation: 20,
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.redAccent
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )
                )

            ),
            darkTheme:ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                    color: Color(0xff0D0D32),
                    elevation: 0,
                    actionsIconTheme: IconThemeData(
                        color: Colors.white
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    titleSpacing: 20,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xff0D0D32),
                        statusBarIconBrightness: Brightness.light
                    )
                ),
                scaffoldBackgroundColor: const Color(0xff0D0D32),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    elevation: 20,
                    backgroundColor: Color(0xff0D0D32),
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.redAccent,
                    unselectedItemColor: Colors.grey
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                )
            ) ,
            themeMode:cubit.isDark? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:HomeScreen() ,
          );
      },
      ),
    );
  }
}


