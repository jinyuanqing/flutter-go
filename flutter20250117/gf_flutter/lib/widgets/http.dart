import 'package:dio/dio.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:path/path.dart';
import '/model1.dart';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';

import 'package:get/get.dart' as Get;
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "en";
const String TOKEN = "Bearer token";


//单例模式
class YXHttp {
  static final YXHttp _instance = YXHttp._internal();
  factory YXHttp() => _instance;

  late Dio _dio;

  /// 单例初始
  YXHttp._internal() {
    // header 头
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      // AUTHORIZATION: TOKEN,
      // DEFAULT_LANGUAGE: DEFAULT_LANGUAGE
    };

    // 初始选项
   
 var options = BaseOptions( headers: headers,   baseUrl: url1,
    connectTimeout:   Duration(seconds: connectTimeout0),
    receiveTimeout:Duration(seconds: connectTimeout0),
    responseType: ResponseType.json,
    // validateStatus: (status) {
    //   // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
    //   return true;
    // },
     
  );
 
    // 初始 dio
    _dio = Dio(options);

    // 拦截器 - 日志打印
    // if (!kReleaseMode) {
    //   _dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //   ));
    // }

    // 拦截器
   // _dio.interceptors.add(RequestInterceptors());
  }

//返回1,有错.无错直接返回response.函数返回值是json格式, 用户调用后函数返回值就是gf服务器返回的最终的数据集合了.
dynamic http_post(String api, dynamic formdata) async {
// Future<dynamic> YXHttp().http_post(String api, dynamic formdata) async { //future返回的函数使用.then
  Response response;
 
  response = await _dio.post(api, data: formdata);
  // return response;
  // json_result = convert.jsonDecode(response.data.toString());//此处不用进行json转换.已经是json的map形式了.直接用json[""]就行

  if (response.statusCode == 200) {
    if (response.data["code"].toString() == "0") {
      // print(response.data["data"]["res"].runtimeType);//查看变量的数据类型
      print(api);
       Get.Get.snackbar("结果", "操作成功!", snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
      return response.data["data"]; //返回是直接的数据集合.所以直接使用函数返回值就行
    } else {
      // print('服务器返回结果是错误的');
      print("错误code:");  print(response.data["code"]); //返回服务器错误码
     print("错误message:");  print(response.data["message"]);

      Get.Get.snackbar("结果", response.data["code"] + response.data["message"],
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
       return null; //返回错误时,返回null调用此函数语句下边加if (response==null){return;}//返回值为null,说明发生错误,因此返回.
    // return   response.data["data"]; //返回是直接的数据集合.所以直接使用函数返回值就行
    }
  } else {
    print('网络错误');

    Get.Get.snackbar("结果", "网络错误",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
  }
}

Future<dynamic>  http_get(String api, dynamic formdata) async {
  Response response;
 
  response = await _dio.get(api, queryParameters: formdata);
  // return response;
  // json_result = convert.jsonDecode(response.data.toString());//此处不用进行json转换.已经是json的map形式了.直接用json[""]就行

  if (response.statusCode == 200) {
    print(response.data);
    if (response.data["code"].toString() == "0") {
      Get.Get.snackbar("结果", "操作成功!", snackPosition: SnackPosition.BOTTOM);
      return response.data["data"]; //返回可能是map或者直接的数据
    } else {
      // print('服务器返回结果是错误的');
      print(response.data["code"]); //返回服务器错误码
      print(response.data["message"]);

      Get.Get.snackbar("结果", response.data["code"] + response.data["message"],
          snackPosition: SnackPosition.BOTTOM);
      return response.data["data"]; //返回可能是map或者直接的数据
    }
  } else {
    print('网络错误');
    // BotToast.showText(text: "网络错误!"); //弹出一个提示文本框;
    Get.Get.snackbar("结果", "网络错误", snackPosition: SnackPosition.BOTTOM);
  }
}
  // /// get 请求
  // Future<Response> get(
  //   String url, {
  //   Map<String, dynamic>? params,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   Options requestOptions = options ?? Options();
  //   Response response = await _dio.get(
  //     url,
  //     queryParameters: params,
  //     options: requestOptions,
  //     cancelToken: cancelToken,
  //   );
  //   return response;
  // }

  // /// post 请求
  // Future<Response> post(
  //   String url, {
  //   dynamic data,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   var requestOptions = options ?? Options();
  //   Response response = await _dio.post(
  //     url,
  //     data: data ?? {},
  //     options: requestOptions,
  //     cancelToken: cancelToken,
  //   );
  //   return response;
  // }

  // /// put 请求
  // Future<Response> put(
  //   String url, {
  //   dynamic data,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   var requestOptions = options ?? Options();
  //   Response response = await _dio.put(
  //     url,
  //     data: data ?? {},
  //     options: requestOptions,
  //     cancelToken: cancelToken,
  //   );
  //   return response;
  // }

  // /// delete 请求
  // Future<Response> delete(
  //   String url, {
  //   dynamic data,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   var requestOptions = options ?? Options();
  //   Response response = await _dio.delete(
  //     url,
  //     data: data ?? {},
  //     options: requestOptions,
  //     cancelToken: cancelToken,
  //   );
  //   return response;
  // }
}

/// 拦截
// class RequestInterceptors extends Interceptor {
  //

  /// 发送请求
  /// 我们这里可以添加一些公共参数，或者对参数进行加密
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // super.onRequest(options, handler);

//     // http header 头加入 Authorization
//     // if (UserService.to.hasToken) {
//     //   options.headers['Authorization'] = 'Bearer ${UserService.to.token}';
//     // }

//     return handler.next(options);
//     // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
//     // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
//     //
//     // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
//     // 这样请求将被中止并触发异常，上层catchError会被调用。
//   }

//   /// 响应
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     // 200 请求成功, 201 添加成功
//     if (response.statusCode != 200 && response.statusCode != 201) {
//       handler.reject(
//         DioException(
//           requestOptions: response.requestOptions,
//           response: response,
//           type: DioExceptionType.badResponse,
//         ),
//         true,
//       );
//     } else {
//       handler.next(response);
//     }
//   }

//   // // 退出并重新登录
//   // Future<void> _errorNoAuthLogout() async {
//   //   await UserService.to.logout();
//   //   IMService.to.logout();
//   //   Get.toNamed(RouteNames.systemLogin);
//   // }

//   /// 错误
//   // @override
//   Future<void> onError( DioException err, ErrorInterceptorHandler handler) async {
//     final exception = HttpException(err.message ?? "error message");
//     switch (err.type) {
//       case DioExceptionType.badResponse: // 服务端自定义错误体处理
//         {
//           final response = err.response;
//           final errorMessage = ErrorMessageModel.fromJson(response?.data);
//           switch (errorMessage.statusCode) {
//             // 401 未登录
//             case 401:
//               // 注销 并跳转到登录页面
//               // _errorNoAuthLogout();
//               break;
//             case 404:
//               break;
//             case 500:
//               break;
//             case 502:
//               break;
//             default:
//               break;
//           }
          
//         //  if(errorMessage.message != null){
//            // Loading.error(errorMessage.message);
//          // }
//         }
//         break;
//       case DioExceptionType.unknown:
//         break;
//       case DioExceptionType.cancel:
//         break;
//       case DioExceptionType.connectionTimeout:
//         break;
//       default:
//         break;
//     }
//     DioException errNext = err.copyWith(
//       error: exception,
//     );
//     handler.next(errNext);
//   }
// }