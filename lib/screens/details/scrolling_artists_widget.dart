import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/models/credits.dart';


class ScrollingArtists extends StatelessWidget {
  final Credits credits;
  final Function(Cast)? onTap;

  const ScrollingArtists({Key? key, required this.credits, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Cast', style: Theme.of(context).textTheme.bodyText1),
            TextButton(
              onPressed: null,
              child: Text('See full cast & crew',
                  style: Theme.of(context).textTheme.caption),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 120,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: credits.cast!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  onTap!(credits.cast![index]);
                },
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: credits.cast![index].profilePath == null
                                ? Image.asset(
                                    'assets/images/na.jpg',
                                    fit: BoxFit.cover,
                                  )
                                : FadeInImage(
                                    image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                        'w500/' +
                                        credits.cast![index].profilePath!),
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(
                                        'assets/images/loading.gif'),
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          credits.cast![index].name!,
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
