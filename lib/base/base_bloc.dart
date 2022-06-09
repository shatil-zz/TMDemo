import 'package:flutter/cupertino.dart';

abstract class Bloc {
  BuildContext context;
  Bloc(this.context);

  void init();

  void dispose();
}
