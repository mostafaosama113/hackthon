import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_fatura/tasks/third_task/cubit/states.dart';
import 'package:hackathon_fatura/tasks/third_task/models/movie_model.dart';
import 'package:hackathon_fatura/tasks/third_task/modules/favorite_screen.dart';
import 'package:hackathon_fatura/tasks/third_task/modules/popular_screen.dart';
import 'package:hackathon_fatura/tasks/third_task/modules/recent_screen.dart';
import 'package:hackathon_fatura/tasks/third_task/shared/remote/dio_helper.dart';
import 'package:hackathon_fatura/tasks/third_task/shared/remote/sqflite.dart';
import 'package:hackathon_fatura/tasks/third_task/third_task_constants.dart';

class CinemaCubit extends Cubit<CinemaState> {
  CinemaCubit() : super(InitState()) {
    SqlfLite.getFav().then((value) {
      value.forEach((element) {
        inFav[element['id']] = true;
        favModel.add(ResultModel.fromJson(element as Map<String, dynamic>));
      });
    }).then((value) {
      getPopularMovie();
      getRecentMovie();
    });
  }
  static CinemaCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    PopularScreen(),
    RecentScreen(),
    FavoriteScreen(),
  ];
  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }

  MovieModel? popularMovieModel;

  Map inFav = {};

  void getPopularMovie() {
    DioHelper.getData(
      path: ThirdTaskConstants.MovieEndpoint,
      query: {
        'api_key': ThirdTaskConstants.TheMovieDBAPIKey,
        'page': 1,
        'sort_by': 'popularity.desc',
      },
    ).then((value) {
      popularMovieModel = MovieModel.fromJson(value.data);
      emit(GetDataSuccessState());
    });
  }

  MovieModel? recentMovieModel;

  void getRecentMovie() {
    DioHelper.getData(
      path: ThirdTaskConstants.MovieEndpoint,
      query: {
        'api_key': ThirdTaskConstants.TheMovieDBAPIKey,
        'page': 1,
        'sort_by': 'release_date.desc',
      },
    ).then((value) {
      recentMovieModel = MovieModel.fromJson(value.data);
      emit(GetDataSuccessState());
    });
  }

  List<ResultModel> favModel = [];

  void editFav(ResultModel model) {
    if (inFav[model.id] != null) {
      SqlfLite.delete(model.id!);
      inFav.remove(model.id);
      for (int i = 0; i < favModel.length; i++) {
        if (favModel[i].id == model.id) {
          favModel.removeAt(i);
          break;
        }
      }
    } else {
      SqlfLite.insert(model);
      favModel.add(model);
      inFav[model.id] = true;
    }
    print(inFav);
    emit(EditFavSuccessState());
  }
}
