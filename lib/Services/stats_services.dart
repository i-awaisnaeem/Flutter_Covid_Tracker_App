import 'dart:convert';

import 'package:covid_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/world_stats_model.dart';

class StatsServices{

  Future<WorldStatsModel> fetchWorldStatsRecords () async{

    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));
    if (response.statusCode == 200){
      print('Data fetched Successfully');
       var data = jsonDecode(response.body);
      print('Response data: $data');
      return WorldStatsModel.fromJson(data);
    }
    else  {
      print('failed to load data');
      throw Exception(
        'Error'
      );
    }
  }

  Future<List<dynamic>> countriesListApi ()async{

    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200){
      print('Data fetched Successfully');
      data = jsonDecode(response.body);
      print('Response data: $data');
      return data;
      }
    else  {
      print('failed to load data');
      throw Exception(
          'Error'
      );
    }
  }
}