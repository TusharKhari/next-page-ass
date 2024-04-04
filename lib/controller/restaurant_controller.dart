 import 'dart:convert';
import 'dart:developer';
import 'dart:io';
 import 'package:get/get.dart';
import 'package:nextpageass/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class RestaurantController extends GetxController {
  RxList<RestaurantDetailModel> resList = <RestaurantDetailModel>[].obs;
  Future<void> getRestaurantModel() async {
     await Dio()
        .get("https://run.mocky.io/v3/17720874-0c0f-4b0b-ab5d-4382c9d8ca26")
        .then((restaurantList) {
       List data = restaurantList.data as List; 
      for (var element in data) {
         var dec = RestaurantDetailModel.fromJson(element);
        resList.add(dec);
        updateRatings();
        }
     }).onError((error, stackTrace) {
      log("error ---> $error");
     });
    }

 

 
 Future<void> updateRating({int? id, double? rating}) async{
     Directory tempDir = await getTemporaryDirectory();
var directoryPath = tempDir.path;
  Directory directory = Directory(directoryPath);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true); 
  }
   File jsonFile = File('$directoryPath/data.json');
   if(await jsonFile.exists()){
    // jsonFile.delete();
     }else{
    List jsonData = [];
  jsonFile.writeAsStringSync(jsonData.toString());
   }
  //
  if(id != null){
 await addInJsonFile({"id":id,"rating":rating});
 //
  List allRatings = await readJsonFile();
     log("allRatings updateRating $allRatings");
     for(int i =0; i<resList.length; i++){
      for(var rest in allRatings){
        var el = resList[i];
        int idd = int.parse(rest["id"].toString());
        double rat = double.parse(rest["rating"].toString());
        if(el.id == idd && el.id == id){
          log("message $i ${el.averageRating} ${rat}");
              double newAverageRating = ((el.averageRating??0) * (50) + rat) /
        ((50) + 1);
        String avg = newAverageRating.toStringAsFixed(2);
        newAverageRating = double.parse(avg);
        var newRes = el.copyWith(averageRating: newAverageRating);
        resList.removeAt(i);
        resList.insert(i, newRes);
        }
      }
     }
 //
   }else{
   }
 
}

 


Future<dynamic> readJsonFile() async {
    Directory tempDir = await getTemporaryDirectory();
var filePath = "${tempDir.path}/data.json";
  try {
     File jsonFile = File(filePath);
    String jsonString = await jsonFile.readAsString();
        List<dynamic> listFromJson = jsonDecode(jsonString);
     return listFromJson;
  } catch (e) {
    print('Error reading JSON file: $e');
    return null;
  }
}
//
 Future<void> addInJsonFile(Map idNRating)async{
   List allRatings = await readJsonFile();
   int isAlreadyPresentAt  = -1;
   for (var i = 0; i < allRatings.length; i++) {
      if(allRatings[i]["id"].toString() == idNRating["id"].toString()){
      isAlreadyPresentAt = i;
     }
   }
   if(isAlreadyPresentAt != -1){
    allRatings.removeAt(isAlreadyPresentAt);
    allRatings.add(idNRating);
   }else{
    allRatings.add(idNRating);
   }
  await  writeJsonFile(allRatings);


}
// ======
 Future<void> writeJsonFile(List data) async {
  // Path to the JSON file
   Directory tempDir = await getTemporaryDirectory();
var filePath = "${tempDir.path}/data.json";
 
  try {
    // Convert the list of maps to a JSON string
    String jsonString = json.encode(data);

    // Write the JSON string to the file
    File jsonFile = File(filePath);
    await jsonFile.writeAsString(jsonString);
     } catch (e) {
    print('Error writing JSON file: $e');
  }
}

  Future<void> updateRatings() async{
     List allRatings = await readJsonFile();
     log("allRatings  $allRatings");
     for(int i =0; i<resList.length; i++){
      for(var rest in allRatings){
        var el = resList[i];
        int id = int.parse(rest["id"].toString());
        double rat = double.parse(rest["rating"].toString());
        if(el.id == id){
          log("message $i ${el.averageRating} ${rat}");
              double newAverageRating = ((el.averageRating??0) * (50) + rat) /
        ((50) + 1);
        String avg = newAverageRating.toStringAsFixed(2);
        newAverageRating = double.parse(avg);
        var newRes = el.copyWith(averageRating: newAverageRating);
        resList.removeAt(i);
        resList.insert(i, newRes);
        }
      }
     }
  }
}
