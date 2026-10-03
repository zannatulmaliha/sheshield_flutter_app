import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/helper/data/models/helper_history_item_model.dart';
import 'package:sheshield/features/helper/data/models/helper_stats_model.dart';

/// `/helper/stats` and `/helper/history`.
class HelperActivityApiDataSource {
  const HelperActivityApiDataSource(this._dioClient);

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  Future<HelperStatsModel> fetchStats() => guardApiCall(() async {
        final response = await _dio.get<dynamic>('/helper/stats');
        return HelperStatsModel.fromJson(readDataObject(response));
      });

  Future<List<HelperHistoryItemModel>> fetchHistory() => guardApiCall(() async {
        final response = await _dio.get<dynamic>('/helper/history');
        return readDataList(response).map(HelperHistoryItemModel.fromJson).toList();
      });
}
