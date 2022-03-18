import '../utils.dart';

abstract class BoxEndpoint with Utils {
  BoxEndpoint(this.endpoint, {this.params = const {}});

  final String endpoint;
  final Map<String, dynamic> params;
}
