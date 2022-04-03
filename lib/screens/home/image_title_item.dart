import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';

class ImageTitleItem extends StatelessWidget {
  final Function? onTap;
  final String? posterPath;
  final String? title;

  const ImageTitleItem({Key? key, this.onTap, this.title, this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: SizedBox(
          width: 100,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage(
                    image: NetworkImage(
                        TMDB_BASE_IMAGE_URL + 'w500/' + posterPath!),
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/images/loading.gif'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
