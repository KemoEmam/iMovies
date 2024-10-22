import 'package:clean_architecture_app/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';



class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 300);

    if (dio == null) {
      dio = Dio();
      init();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: ApiConstance.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 300),
          receiveTimeout: const Duration(seconds: 300),
          headers: {
            'Content-Type': 'application/json',
            
          }),
    );
  }
}
