import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class SocialDioHelper
{
  static Dio dio;

  static init(){
    dio =Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
      ),
    );
  }


  // static Future <Response> getData(
  //     {
  //       @required String url,
  //       Map<String,dynamic>query,
  //       String lang='en',
  //       String token,
  //     })async
  // {
  //   dio.options.headers=
  //   {
  //     'lang':lang,
  //     'authorization':token,
  //     'Content-Type':'application/json',
  //
  //
  //   };
  //
  //
  //   return await dio.get(url,queryParameters: query);
  //
  // }

  static Future <Response> postData(
      {
        @required String url,
        String token,
        String name,
      })async
  {
    dio.options.headers=
    {
      "to":"$token",
      "notification":
      {
        "title":"you have a message from ${name}",
        "body":"testing body",
        "sound":"default"
      },
      "android":
      {
        "priority":"HIGH",
        "notification":
        {
          "notification_priority":"PRIORITY_MAX",
          "sound":"default",
          "default_sound":true,
          "default_vibrate_timings":true,
          "default_light_setting":true
        }
      },
      "data":
      {
        "type":"order",
        "id":"87",
        "click_action":"FLUTTER_NOTIFICATION_CLICK"
      }
    };

    return dio.post(url);

  }



  //
  // static Future <Response> putData(
  //     {
  //       @required String url,
  //       @required Map<String,dynamic>data,
  //       Map<String,dynamic>query,
  //       String lang='en',
  //       String token,
  //     })async
  // {
  //   dio.options.headers=
  //   {
  //     'lang':lang,
  //     'authorization':token,
  //     'Content-Type':'application/json',
  //
  //
  //   };
  //
  //   return dio.put(url,data: data,queryParameters: query);
  //
  // }

}