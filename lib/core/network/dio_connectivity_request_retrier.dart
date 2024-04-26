import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class DioConnectivityRequestRetrier {
  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  final Dio dio;
  final Connectivity connectivity;

  Future<Response<dynamic>> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription<ConnectivityResult>? streamSubscription;
    final Completer<Response<dynamic>> responseCompleter = Completer<Response<dynamic>>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        // Estamos conectados a Wi-Fi o a datos móviles.
        // ignore: unrelated_type_equality_checks
        if (result != ConnectionState.none) {
          await streamSubscription?.cancel();

          // Completa el completer en lugar de devolverlo.
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
                contentType: requestOptions.contentType,
                responseType: requestOptions.responseType,
                receiveTimeout: requestOptions.receiveTimeout,
                sendTimeout: requestOptions.sendTimeout,
                extra: requestOptions.extra,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
