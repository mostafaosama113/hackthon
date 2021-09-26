import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_fatura/tasks/third_task/cubit/cubit.dart';
import 'package:hackathon_fatura/tasks/third_task/cubit/states.dart';
import 'package:hackathon_fatura/tasks/third_task/shared/components/movie_builder.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CinemaCubit, CinemaState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = CinemaCubit.get(context);
        return bloc.favModel.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity),
                  Image.asset(
                    'images/3298067.jpg',
                    height: MediaQuery.of(context).size.height * .5,
                  ),
                  Text(
                    'No Favorites Yet!',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )
                ],
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => movieBuilder(
                  bloc.favModel[index],
                  true,
                  () {
                    bloc.editFav(bloc.favModel[index]);
                  },
                ),
                itemCount: bloc.favModel.length,
              );
      },
    );
  }
}
