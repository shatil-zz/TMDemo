import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/models/credits.dart';

void castInfoBottomSheetMenu(BuildContext context, Cast cast) {
  // double height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          // height: height / 2,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    padding: const EdgeInsets.only(top: 54),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0))),
                    child: Center(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${cast.name}',
                                  style:
                                  Theme.of(context).textTheme.bodyText2,
                                ),
                                Text(
                                  'as',
                                  style:
                                  Theme.of(context).textTheme.bodyText2,
                                ),
                                Text(
                                  '${cast.character}',
                                  style:
                                  Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                              color: Theme.of(context).backgroundColor,
                              width: 3),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (cast.profilePath == null
                                  ? const AssetImage('assets/images/na.jpg')
                                  : NetworkImage(TMDB_BASE_IMAGE_URL +
                                  'w500/' +
                                  cast.profilePath!)) as ImageProvider<
                                  Object>),
                          shape: BoxShape.circle),
                    ),
                  ))
            ],
          ),
        );
      });
}