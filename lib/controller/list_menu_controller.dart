import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/api_controller.dart';
import 'package:presto_qr/controller/user_controller.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:presto_qr/model/model_response_listbill.dart';
import 'package:presto_qr/model/paket_orderan_model.dart';
import 'package:presto_qr/model/user_model.dart';
import 'package:get/get.dart';
import 'package:presto_qr/component/garis_putus.dart';



class ListMenuNya extends GetxController{
  static ListMenuNya get to => Get.find();

  final box = GetStorage();
  final mn = MenuModel().obs;
  final listMenu = List<MenuModel>().obs;
  final noteController = <TextEditingController>[].obs;
  final banyakScroll = 0.obs;
  // final keatas = 0.obs;
  // final kebawah = 0.obs;

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

  kosongkanData(){
    listMenu.value = [];
    noteController.value = [];
    banyakScroll.value = 0;
    host.value = "";
    user.value = {};
    meja.value = "";
    totalan.value = false;
    totalQty.value = 0;
    totalValue.value = 0;
    totalOrder.value = 0;
    totalanBawah.value = false;
    adaOrderan.value = false;
    totalListOrderan.value = [];
    cariController.value = TextEditingController();
    scrollController.value = ScrollController();
    pesananNya.value = ResponseListBill();
  }

  kosongkanMeja(String meja,String host)async{
    await new Dio().post(host+'/api/clearTable/'+meja);
    Get.snackbar("judul", "meja dihapus");
  }
  scrollListener(){
    scrollController.value.addListener(() {
      if(this.scrollController.value.position.userScrollDirection == ScrollDirection.forward){
        this.banyakScroll.value ++;
        if(this.banyakScroll.value > 20){
          this.totalanBawah.value = false;
          this.banyakScroll.value = 0;
        }
      }else{
        this.banyakScroll.value ++;
        if(this.banyakScroll.value > 20){
          this.totalanBawah.value = true;
          this.banyakScroll.value = 0;
        }
      }
      print(this.banyakScroll.value);
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
    this.listMenu.value = await ApiController.getListMenu();
    for(var i = 0; i < this.listMenu.length;i++){
      this.listMenu[i].note = "";
      this.listMenu[i].lihatTambah = false;
      this.listMenu[i].lihatEditTambah = false;
      this.listMenu[i].qty = 0;
      // if(this.listMenu[i].groupp.toString().trim() == "FOOD"){
      //   this.listMenu[i].terlihat = true;
      // }else{
      //   this.listMenu[i].terlihat = false;
      // }
    }
    this.listMenu.forEach((el) { el.groupp.toString().trim() == "FOOD"?el.terlihat = true:el.terlihat = false;});
    this.noteController.value = List.generate(listMenu.length, (index) => TextEditingController());
    update();
    this.listMenu.update((value) {print('update abis ambil list menu');});
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

  tambahOrderan(int i){
    this.listMenu[i].qty = 1;
    this.adaOrderan.value = true;
    this.hitungTotal();
    this.listMenu.update((value) { print('tamabah item');});
  }

  /* tambah note */
  tambahNote(int i){
    print("note");
    if(this.noteController[i].text != "") this.listMenu[i].note = this.noteController[i].text;
    this.listMenu[i].lihatEditTambah = !this.listMenu[i].lihatEditTambah;
    this.listMenu.update((value) { 
      print('act : tombol edit note');
    });
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
    this.listMenu[i].lihatEditTambah = false;
    this.listMenu.update((value) {print('hapus orderan');});
    Get.snackbar('success', 'one item remove success',
      snackPosition: SnackPosition.BOTTOM
    );
  }


  sortSubMenu(int i){
    print(i.toString().ungu());
    this.subMenu.forEach((el) { el['nama'] == this.subMenu[i]['nama']?el['dipilih'] = true:el['dipilih'] = false;});
    this.listMenu.forEach((el) { el.groupp.toString().trim().toUpperCase() == this.subMenu[i]['nama'].toString().toUpperCase()?el.terlihat = true:el.terlihat = false;});
    this.listMenu.update((value) { print("update sort menu list".hijau()); });
  }

  // prosses orderan
  prossesOrderan(BuildContext context)async{
    Get.dialog(Center(child: CircularProgressIndicator(),));
    final user = UserController.to.user.value;

    final listBill = this.listMenu.where((e) => e.qty != 0).map((e) => BillDetail(
      note: e.note,
      productId: e.kodePro,
      qty: e.qty,
      productPrice: e.hargaPro
    )).toList();

    final paket = PaketOrderan(
      customerId: user.user.phone,
      email: user.user.email,
      name: user.user.name,
      phone: user.user.phone,
      billDetail: listBill
    );

    print(paket.toJson().toString());
    Response res = await ApiController.kirimPaket(paket);
    if(res.data['status']){
      keluar(psn: res);
    }else{
      Get.snackbar('info', res.data['note']);
      //Get.dialog(Center(child: Card(child: Text("failed"),),));
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
    update();
  }


  lihatPesanan(){
    this.pesananNya.value = ResponseListBill.fromJson(box.read('pesanan'));
  }

  keluar({Response psn})async{
    await ApiController.hapusMeja();
    box.remove('auth');
    box.remove('pesanan');
    if(psn != null) await box.write('pesanan', psn.data);
    Get.offAllNamed('/');
  }
}