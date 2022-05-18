import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/app_bloc/news_cubit/news_cubit.dart';
import 'package:news_app/shared/app_bloc/news_cubit/news_states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){

        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Search'),
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.grey,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (String? value){
                    if (value!.isEmpty){
                      return 'search must not be empty';
                    }
                  },
                ),
              ),

              Expanded(
                  child: articleBuilder(list, context, isSearch: true)
              ),
            ],
          ),
        );
      },
    );
  }
}
