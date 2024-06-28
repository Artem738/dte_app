import 'package:dte_app/env_config.dart';
import 'package:http/http.dart' as http;

class ApiResult {
  final bool success;
  final String? errorMessage;
  final dynamic data;

  ApiResult({required this.success, this.errorMessage, this.data});
}

bool checkInternet = EnvConfig.checkInternetMsftConnectTest; //

Future<bool> hasInternetConnectionCheck() async {
  try {
    final response = await http.get(Uri.parse('http://www.msftconnecttest.com/redirect')).timeout(Duration(seconds: 3));
    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
}

Future<ApiResult> makeApiRequest(String url) async {
  try {
    final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 3));
    if (response.statusCode == 200) {
      return ApiResult(success: true, data: response.body);
    } else {
      return ApiResult(
        success: false,
        errorMessage: 'Failed to load data: ${response.reasonPhrase}',
      );
    }
  } catch (error) {
    if (checkInternet) {
      final internetAvailable = await hasInternetConnectionCheck();
      if (!internetAvailable) {
        return ApiResult(
          success: false,
          errorMessage: 'No internet connection',
        );
      }
    }
    return ApiResult(
      success: false,
      errorMessage: 'Failed to load data: ${error.toString()}',
    );
  }
}
