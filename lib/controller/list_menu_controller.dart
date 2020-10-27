import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/api_controller.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:presto_qr/model/model_response_listbill.dart';
import 'package:presto_qr/model/paket_orderan_model.dart';
import 'package:presto_qr/model/user_model.dart';



class ListMenuNya extends GetxController{
  static ListMenuNya get to => Get.find();

  final box = GetStorage();
  final mn = MenuModel().obs;
  final listMenu = List<MenuModel>().obs;
  final noteController = <TextEditingController>[].obs;
  //final banyakScroll = 0.obs;
  final keatas = 0.obs;
  final kebawah = 0.obs;

  /* tambahan */
  final host = "".obs;
  final user = <String,dynamic>{}.obs;
  final meja = "".obs;
  final totalan = false.obs;
  final totalQty = 0.obs;
  final totalValue = 0.obs;
  final totalOrder = 0.obs;
  final totalanBawah = false.obs;
  final adaOrderan = false.obs;
  final totalListOrderan = <MenuModel>[].obs;
  final cariController = TextEditingController().obs;
  final scrollController = ScrollController().obs;
  final pesananNya = ResponseListBill().obs;

  kosongkanMeja(String meja,String host)async{
    await new Dio().post(host+'/api/clearTable/'+meja);
    Get.snackbar("judul", "meja dihapus");
  }


  scrollListener(){
    scrollController.value.addListener(() {
      if(this.scrollController.value.position.userScrollDirection == ScrollDirection.forward){
        this.keatas.value ++;
        if(this.keatas.value > 20){
          this.totalanBawah.value = false;
          this.keatas.value = 0;
        }
      }else{
        this.kebawah.value ++;
        if(this.kebawah.value > 20){
          this.totalanBawah.value = true;
          this.kebawah.value = 0;
        }
      }
      print(this.kebawah.value);
    });
  }

  // sub menu
  final subMenu = [
    {
      "nama": "FOOD",
      "dipilih": true
    },
    {
      "nama": "BEVERAGE",
      "dipilih": false
    },
    {
      "nama": "OTHERS",
      "dipilih": false
    }
  ].obs;

  getListMenu()async{
    final str = GetStorage();
    if(str.hasData("listmenu")){
      listMenu.value =  (str.read("listmenu") as List).map((e) => MenuModel.fromJson(e)).toList();
      print('load dari storage');
    }else{
      final Response res = await Dio().get("${str.read('host')}/api/getMenu?product=&group=&subgroup=");
      listMenu.value = (res.data as List).map((e) => MenuModel.fromJson(e)).toList();
      await str.write("listmenu", res.data);
      print('load list menu dari serverx');
    }

    listMenu.forEach((e){
        e.note = "";
        e.lihatTambah = false;
        e.lihatEditTambah = false;
        e.qty = 0;
        if(e.groupp.toString().trim() == "FOOD"){
          e.terlihat = true;
        }else{
          e.terlihat = false;
        }
    });

    this.noteController.value = List.generate(listMenu.length, (index) => TextEditingController());
    this.listMenu.update((value) {});
  }

  // meghitung total
  hitungTotal(){
    this.totalValue.value = this.listMenu.where((MenuModel e) => e.qty != 0).map((e) => int.parse(e.hargaPro.toString()) * int.parse(e.qty.toString())).reduce((value, element) => value + element);
    this.totalQty.value = this.listMenu.where((MenuModel e) => e.qty != 0).map((e) => e.qty).reduce((value, element) => value + element);
    this.totalOrder.value = this.listMenu.where((e) => e.qty != 0).toList().length;
  }

  // kurangi qty
  kurangiQty(int i){
    this.listMenu[i].qty --;
    if(this.listMenu[i].qty < 1){
      this.noteController[i].text = "";
      this.listMenu[i].qty = 0;
      this.listMenu[i].note = "";
      this.listMenu[i].lihatEditTambah = false;
    }
    // disini : cek total saat pengurangan
    try {
      var apa = this.listMenu.where((e) => e.qty != 0).map((e) => e.qty).reduce((a, b) => a+b) > 0;
      if(apa){
        this.hitungTotal();
      }
    } catch (e) {
      this.adaOrderan.value = false;
    }
   
    this.listMenu.update((value) {print('pengurangan qty');});
  }


 
  // tambah qty
  tambahQty(i){
    this.listMenu[i].qty ++;
    this.hitungTotal();
    this.adaOrderan.value = true;
    this.listMenu.update((value) {print('tambah qty order');});
  }

  // lihat total orderannya
  lihatListOrderannya(){
    this.totalListOrderan.value = this.listMenu.where((e) => e.qty != 0 ).toList();
    print("total orderannya : "+this.totalListOrderan.length.toString());
  }

  // hapus orderan
  hapusOrderan(int i){
    if(this.listMenu.where((e) => e.qty != 0 ).toList().length > 1){
      this.listMenu[i].qty = 0;
      this.listMenu[i].note = "";
      hitungTotal();
    }else{
      this.listMenu[i].qty = 0;
      this.listMenu[i].note = "";
      this.adaOrderan.value = false;
      Get.back();
    }
    this.noteController[i].text = "";
    this.listMenu.update((value) {print('hapus orderan');});

  }

  // prosses orderan
  prossesOrderan(BuildContext context)async{
    final box = GetStorage();
    final user = UserModel.fromJson(box.read('auth'));

    final listBill = this.listMenu.where((e) => e.qty != 0).map((e) => BillDetail(
      note: e.note,
      productId: e.kodePro,
      qty: e.qty,
      productPrice: e.hargaPro
    )).toList();

    final paket = PaketOrderan(
      customerId: user.phone,
      email: user.email,
      name: user.name,
      phone: user.phone,
      billDetail: listBill
    );

    final apaBerhasil = await ApiController.kirimPaket(paket);
    if(apaBerhasil){
      print('berhasil kirim paketan');
      await box.remove('auth');
      await box.remove('meja');
      await box.remove('host');
      Get.offAllNamed('/');
    }else{
      print('gagal kirim paketan');
    }
  }


  cariListMenu()async{
    for(var i = 0; i< this.listMenu.length;i++){
      if(this.listMenu[i].namaPro.toString().toLowerCase().contains(this.cariController.value.text)){
        this.listMenu.value[i].terlihat = true;
      }else{
        this.listMenu.value[i].terlihat = false;
      }
    }
    this.listMenu.update((value) { });
  }


  lihatPesanan(){
    this.pesananNya.value = ResponseListBill.fromJson(box.read('pesanan'));
  }

  keluar(){
    box.erase();
    Get.offAllNamed('/');
  }
}