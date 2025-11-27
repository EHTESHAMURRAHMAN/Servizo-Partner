import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "localhost";
  String get apiHostFuture => "localhost";
  @override
  String get apiVersion => 'api-version=1.0';
  @override
  String get imageHost => 'http://api.smartprop.io/PropertyImages';

  @override
  String get base => throw UnimplementedError();
}
