import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';

class SearchItemWidget extends StatelessWidget {
  final String? posterPath, title, voteAverage;

  const SearchItemWidget(
      {Key? key, this.posterPath, this.title, this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: posterPath == null
                    ? Image.asset(
                        'assets/images/na.jpg',
                        fit: BoxFit.cover,
                      )
                    : FadeInImage(
                        image: NetworkImage(
                            TMDB_BASE_IMAGE_URL + 'w500/' + posterPath!),
                        fit: BoxFit.cover,
                        placeholder:
                            const AssetImage('assets/images/loading.gif'),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title ?? "",
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          voteAverage ?? "",
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Icon(Icons.star, color: Colors.green)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Divider(
            color: Theme.of(context).backgroundColor,
          ),
        )
      ],
    );
  }
}
