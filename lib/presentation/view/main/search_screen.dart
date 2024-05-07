import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/api_config/api_client.dart';
import 'package:movies_app/data/dara_source/movie_search_data_source.dart';
import 'package:movies_app/data/hive_box/local_storage.dart';
import 'package:movies_app/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:movies_app/presentation/widgets/circle_progress_widget.dart';
import 'package:movies_app/presentation/widgets/item_list_widget.dart';
import 'package:movies_app/presentation/widgets/my_textfield_widget.dart';
import 'package:movies_app/utilis/all_text.dart';

import '../../blocs/search_movie_bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('SearchScreen Widget${userData.get('email')} ${userData.get('password')}');
    return Column(
      children: [
        MyTextField(
            size: const Size(400, 100),textColor: Colors.white,
            controller: TextEditingController(),
            labelText: 'Search with movie name',
            index: 0),
        BlocConsumer<SearchBloc,SearchState>(

            listener: (BuildContext context, Object? state) {},
            builder: (BuildContext context, state) {
              print('State =$state');

              if(state is LoadingState){
                return const CircleProgressWidget();
              }else if(state is SearchError){
                return Center(
                  child: Text(state.error,style: customStyle,),
                );
              }else if(state is SearchLoaded){
                return Expanded(
                    child: ItemListWidget(count: '2', movies:state.searchList, categoryName: ''));
              }else if(state is SearchInitial){
                return const SizedBox.shrink();
              }
              return const SizedBox.shrink();
            },

        ),
      ],
    );
  }
}
