

import 'package:tm_demo/base/response_parser.dart';

class Resource<T> {
  ResourceStatus status;
  T? model;
  String? message;
  int code;

  Resource(
      {this.model,
      this.message,
      this.status = ResourceStatus.empty,
      this.code = 0});

  @override
  String toString() {
    return 'Resource{status: $status, data: $model, message: $message, code: $code}';
  }
}

enum ResourceStatus { empty, loading, success, failed }
