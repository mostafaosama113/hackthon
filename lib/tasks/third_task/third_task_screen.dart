import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_fatura/tasks/third_task/cubit/states.dart';

import 'cubit/cubit.dart';

/* Create a movie mobile application that get popular And recent movies
with an ability to add movie to Favourite list that will be offline
storage on device (use any way you want) that will be displayed
in favorite tabs

- design of this app is attached in project folder
- Adding a progress indicator when information is loading
- Deal with errors coming from the backend (because eventually it will happen!)
- Create model objects for the API data retrieved to avoid working with dynamic (serialisation/deserialisation?)
- Add some sort of state management to show how that is done (InheritedWidget, Provider, GetIt, Mobx and so on)
- add pagination mechanism
 */
class ThirdTaskScreen extends StatefulWidget {
  @override
  _ThirdTaskScreenState createState() => _ThirdTaskScreenState();
}

class _ThirdTaskScreenState extends State<ThirdTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CinemaCubit(),
      child: BlocConsumer<CinemaCubit, CinemaState>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = CinemaCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Cinema App'),
              titleSpacing: -10,
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: bloc.currentIndex,
              onTap: (index) {
                bloc.changeCurrentIndex(index);
              },
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up),
                  label: 'popular',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.autorenew),
                  label: 'recent',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
              ],
            ),
            body: bloc.screens[bloc.currentIndex],
          );
        },
      ),
    );
  }
}
