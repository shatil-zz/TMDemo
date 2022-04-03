import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/base/base_resource.dart';
import 'package:tm_demo/models/function.dart';
import 'package:tm_demo/models/movie.dart';
import 'package:tm_demo/models/tv_show.dart';
import 'package:tm_demo/screens/details/movie_detail_widget.dart';
import 'package:tm_demo/screens/home/home_bloc.dart';
import 'package:tm_demo/screens/home/image_title_item.dart';
import 'package:tm_demo/utils/app_routes.dart';
import 'package:tm_demo/utils/widgets.dart';

class ScrollingTvWidget extends StatelessWidget {
  final Stream<Resource<TvShowList>> stream;
  final String title;

  const ScrollingTvWidget(
      {Key? key, required this.stream, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(
      builder: (context, bloc, child) {
        return StreamBuilder<Resource<TvShowList>>(
            stream: stream,
            builder: (context, snapshot) {
              Widget? childWidget = getLoadingOrErrorWidget(snapshot.data);
              if (childWidget == null) {
                final List<TvShow> tvList = (snapshot.data?.model?.tvShows)!;
                childWidget = SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: tvList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ImageTitleItem(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.tvShowDetails,
                              arguments: {'tv_show': tvList[index]});
                        },
                        title: tvList[index].title,
                        posterPath: tvList[index].posterPath,
                      );
                    },
                  ),
                );
              }
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title,
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ],
                  ),
                  childWidget,
                ],
              );
            });
      },
    );
  }
}
