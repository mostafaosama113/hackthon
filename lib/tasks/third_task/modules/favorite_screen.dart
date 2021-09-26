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
        return ListView.builder(
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
