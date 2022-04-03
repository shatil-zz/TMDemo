import 'package:flutter/material.dart';
import 'package:tm_demo/base/base_resource.dart';

Widget? getLoadingOrErrorWidget(Resource? resource) {
  if (resource?.status == ResourceStatus.success) {
    return null;
  } else if (resource?.status == ResourceStatus.failed) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      child: Text(
        resource?.message ?? "Failed",
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  } else {
    return Container(
        alignment: Alignment.center,
        height: 200,
        child: const SizedBox(
          child: CircularProgressIndicator(),
          width: 50,
          height: 50,
        ));
  }
}
