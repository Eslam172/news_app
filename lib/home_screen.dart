import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/shared/app_bloc/app_cubit/app_cubit.dart';
import 'package:news_app/shared/app_bloc/news_cubit/news_cubit.dart';
import 'package:news_app/shared/app_bloc/news_cubit/news_states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          var appCubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()
                          )
                      );
                    },
                    icon: const Icon(Icons.search)
                ),
                IconButton(
                    onPressed: (){
                      appCubit.changeAppMode();
                    },
                    icon: const Icon(Icons.brightness_2_outlined)
                ),
              ],
            ),
            body: cubit.screens[cubit.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:cubit.selectedIndex ,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.business_sharp),
                    label: 'Business'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sports_baseball),
                    label: 'Sports'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.science_rounded),
                    label: 'Science'
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
