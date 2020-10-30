import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/model/user_model.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final user = UserModel().obs;

  init()async{
    await getUserNya();
  }

  getUserNya()async{
    user.value = UserModel.fromJson(GetStorage().read('auth'));
    //print(GetStorage().read('auth'));
  }
}