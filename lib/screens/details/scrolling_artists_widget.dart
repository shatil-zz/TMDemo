import 'package:flutter/material.dart';
import 'package:tm_demo/api/api_constants.dart';
import 'package:tm_demo/models/credits.dart';
import 'package:tm_demo/models/function.dart';

class ScrollingArtists extends StatefulWidget {
  final String? api, title, tapButtonText;
  final Function(Cast)? onTap;

  const ScrollingArtists(
      {Key? key, this.api, this.title, this.tapButtonText, this.onTap})
      : super(key: key);

  @override
  _ScrollingArtistsState createState() => _ScrollingArtistsState();
}

class _ScrollingArtistsState extends State<ScrollingArtists> {
  Credits? credits;

  @override
  void initState() {
    super.initState();
    fetchCredits(widget.api!).then((value) {
      setState(() {
        credits = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        credits == null
            ? Text('No cast information available',
                style: Theme.of(context).textTheme.bodyText1)
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.title!,
                      style: Theme.of(context).textTheme.bodyText1),
                  TextButton(
                    onPressed: null,
                    child: Text(widget.tapButtonText!,
                        style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ),
        SizedBox(
          width: double.infinity,
          height: 120,
          child: credits == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: credits!.cast!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        widget.onTap!(credits!.cast![index]);
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
                                  child: credits!.cast![index].profilePath ==
                                          null
                                      ? Image.asset(
                                          'assets/images/na.jpg',
                                          fit: BoxFit.cover,
                                        )
                                      : FadeInImage(
                                          image: NetworkImage(
                                              TMDB_BASE_IMAGE_URL +
                                                  'w500/' +
                                                  credits!.cast![index]
                                                      .profilePath!),
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
                                credits!.cast![index].name!,
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
