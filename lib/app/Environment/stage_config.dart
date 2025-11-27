// ignore_for_file: annotate_overrides

import 'base_config.dart';

class StagConfig implements BaseConfig {
  String get apiHost => "localhost";
  String get apiHostFuture => "localhost";
  String get apiVersion => 'api-version=1.0';
  String get imageHost => 'http://api.smartprop.io/PropertyImages';

  @override
  // TODO: implement base
  String get base => throw UnimplementedError();
}
