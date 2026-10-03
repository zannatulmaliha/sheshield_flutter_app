import 'package:dio/dio.dart';

/// The Go backend wraps every payload as `{ "data": ... }`. These helpers
/// unwrap it once, tolerating the `null` it sends for empty lists.
Map<String, dynamic> readDataObject(Response<dynamic> response) =>
    (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;

/// Like [readDataObject], but tolerates a `null`/absent `data` payload
/// instead of throwing -- for endpoints where "no data" is a valid result.
Map<String, dynamic>? readDataObjectOrNull(Response<dynamic> response) =>
    (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>?;

List<Map<String, dynamic>> readDataList(Response<dynamic> response) {
  final rawList = (response.data as Map<String, dynamic>)['data'] as List<dynamic>?;
  return (rawList ?? const <dynamic>[]).cast<Map<String, dynamic>>();
}
