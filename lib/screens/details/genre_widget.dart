import 'package:flutter/material.dart';
import 'package:tm_demo/models/genres.dart';

class GenreList extends StatefulWidget {
  final List<Genres> genres;
  const GenreList(
      {Key? key, required this.genres}) : super(key: key);

  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.genres.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Chip(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Theme.of(context).backgroundColor),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  label: Text(
                    widget.genres[index].name!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              );
            },
          ),
        ));
  }
}