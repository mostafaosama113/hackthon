import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_fatura/tasks/third_task/cubit/cubit.dart';
import 'package:hackathon_fatura/tasks/third_task/cubit/states.dart';
import 'package:hackathon_fatura/tasks/third_task/shared/components/movie_builder.dart';

class RecentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CinemaCubit, CinemaState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = CinemaCubit.get(context);
        return bloc.recentMovieModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => movieBuilder(
                  bloc.recentMovieModel!.results[index],
                  bloc.inFav[bloc.recentMovieModel!.results[index].id] == null
                      ? false
                      : true,
                  () {
                    bloc.editFav(bloc.recentMovieModel!.results[index]);
                  },
                ),
                itemCount: bloc.recentMovieModel!.results.length,
              );
      },
    );
  }
}
