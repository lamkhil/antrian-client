import 'package:antrian_guest/app/data/models/response_api.dart';
import 'package:antrian_guest/app/data/models/service_category.dart';
import 'package:antrian_guest/app/network/config.dart';

class AntrianServices {
  static Future<ResponseApi<List<ServiceCategory>>> getServiceCategory() async {
    try {
      final result = await dio.get('service');
      if (result.statusCode != 200) {
        return ResponseApi(
          data: null,
          success: false,
          message: result.data['message'] ?? 'Terjadi Kesalahan Server',
        );
      }
      return ResponseApi(
        data: (result.data['data'] as List)
            .map((e) => ServiceCategory.fromJson(e))
            .toList(),
        success: true,
      );
    } catch (e) {
      return ResponseApi(data: null, success: false, message: e.toString());
    }
  }
}
