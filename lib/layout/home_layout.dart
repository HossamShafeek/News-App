import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/allnews/allnews_screen.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('News'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SearchScreen();
                    }));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: (){
                    NewsCubit.get(context).changeAppMode();
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: TabBar(
                      physics: BouncingScrollPhysics(),
                      tabs: [
                        Text('All news'),
                        Text('Business'),
                        Text('Science'),
                        Text('Sports'),
                      ]
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      AllNewsScreen(),
                      BusinessScreen(),
                      ScienceScreen(),
                      SportsScreen()
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
