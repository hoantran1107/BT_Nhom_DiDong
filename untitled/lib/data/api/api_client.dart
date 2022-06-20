import 'package:get/get.dart';
import 'package:untitled/utils/app_containt.dart';

class ApiClient extends GetConnect implements GetxService{
  //api Client Token for connect with sever
  late String token;
  //sever url
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    token=AppConstants.TOKEN;
    baseUrl = appBaseUrl;
    //time out for get Api
    timeout = Duration(seconds: 30);
    //header of resquest to sever
    _mainHeaders ={
      //send json data form sever
      'Content-type' : 'application/json; charset=UTF-8',
      //Authorization send token to sever
      //token bearer type
      'Authorization' : 'Bearer $token'
    };
  }
  //Response form GetXsever , Respone = data
  Future<Response> getData(String uri,) async{
    try{
      //Get connect
      Response response= await get(uri);
      return response;
    }
    catch(e){
      //Respone
      //false send statusCode 1 , statusText = errors
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}

