import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_fatura/tasks/third_task/models/movie_model.dart';
import 'package:hackathon_fatura/tasks/third_task/third_task_constants.dart';

Widget movieBuilder(ResultModel model, bool inFav, Function onClick) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    height: 289,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            model.posterPath != null
                ? Material(
                    borderRadius: BorderRadius.circular(5),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    child: Image(
                      height: 280,
                      width: 145,
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        '${ThirdTaskConstants.BaseImagePath}${model.posterPath}',
                      ),
                    ),
                  )
                : Container(
                    height: 280,
                    width: 145,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 7),
                    child: Text(
                      model.overview != null && model.overview != ''
                          ? model.overview!
                          : 'No description',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.4),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'popularity : ${model.popularity}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'release date : ${model.releaseDate}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'adult : ${model.adult == true || model.adult == 1 ? 'Yes' : 'No'}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Colors.amberAccent,
                      ),
                      Text(
                        '${model.voteAverage} / 10',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () => onClick(),
                          icon: inFav
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_border))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
