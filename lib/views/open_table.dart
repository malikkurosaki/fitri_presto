import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hide_keyboard/hide_keyboard.dart';
import 'package:pecahan_rupiah/pecahan_rupiah.dart';
import 'package:presto_qr/controller/api_controller.dart';
import 'package:presto_qr/main.dart';
import 'package:presto_qr/model/company_model.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:presto_qr/views/login.dart';

class OpenTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx( () => 
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.cyan,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(TableCtrl.company?.value?.name?.toString()??"",
                                  style: TextStyle(
                                    color: Colors.orange[100],
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(GetStorage().read("auth")['user']['name'].toString(),
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                    Text(" @ Table ${GetStorage().read("meja")}",
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Flexible(
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Text("${TableCtrl.jam.value.hour} : ${TableCtrl.jam.value.minute}",
                                      style: TextStyle(
                                        fontSize: 24
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                        Image.network(TableCtrl.company?.value?.logo??"",
                          height: 70,
                          width: 70,
                          errorBuilder: (context, error, stackTrace) => 
                          Center(
                            child: Text("loading .... "),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: FlatButton(
                minWidth: double.infinity,
                color: Colors.grey[200],
                onPressed: (){
                  TableCtrl.animateTinggi.value = !TableCtrl.animateTinggi.value;
                  TableCtrl.lsSearch.assignAll(TableCtrl.lsMenu);
                  Get.dialog(MySearch());
                }, 
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("search ...",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      Icon(Icons.search,
                        color: Colors.cyan,
                      )
                    ],
                  ),
                )
              ),
            ),
            Flexible(
              child: FutureBuilder(
                future: TableCtrl.init(),
                builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done?
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 0.5,
                    backgroundColor: Colors.cyan[900],
                  ),
                ): 
                Obx( () => 
                  PageView(
                    controller: TableCtrl.pageCtrl,
                    physics: ClampingScrollPhysics(),
                    children: [
                      for(final group in TableCtrl.lsGroup)
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(group['name'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.cyan
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                    color: Colors.cyan
                                  ), 
                                  onPressed: () => 
                                  TableCtrl.pageCtrl.nextPage(
                                    duration: Duration(microseconds: 500),
                                    curve: Curves.ease
                                  )
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              color: Colors.grey[100],
                              child: ListView(
                                addAutomaticKeepAlives: true,
                                physics: ScrollPhysics(),
                                controller: group['lsCon'],
                                children: [
                                  for(final MenuModel produk in group['data'])
                                  Container(
                                    height: 130,
                                    color: produk.terlihat == null? Colors.white: Colors.orange[50],
                                    margin: EdgeInsets.only(bottom: 1),
                                    child: ListTile(
                                      dense: true,
                                      title: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () => Get.dialog(DetailsProduct(produk: produk,)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.cyan[900],
                                                border: Border.all(color: Colors.orange, width: 0.1)
                                              ),
                                              margin: EdgeInsets.all(4),
                                              child: Image.network(produk.foto,
                                                height: 70,
                                                width: 70,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => 
                                                Container(
                                                  height: 70,
                                                  width: 70,
                                                  child: Center(
                                                    child: Text("no image",
                                                      style: TextStyle(
                                                        color: Colors.orange[100]
                                                      ),
                                                    )
                                                  )
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(produk.namaPro.toLowerCase(),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.grey[700]
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(Pecahan.rupiah(value: int.parse(produk.hargaPro), withRp: true),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.orange
                                                    ),
                                                  ),
                                                  Text(produk.ket.toLowerCase(),
                                                  overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey
                                                    ),
                                                  ),
                                                  produk.qty == null?SizedBox.shrink():
                                                  InkWell(
                                                    onTap: () {
                                                      TableCtrl.qty.value = produk.qty;
                                                      TableCtrl.note.value = produk.note;
                                                      Get.bottomSheet(
                                                        TambahOrder(
                                                          produk: produk,
                                                          data: TableCtrl.lsGroup[TableCtrl.lsGroup.indexOf(group)]['data'],
                                                        )
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(4),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets.all(4),
                                                              child: Text(produk.note,
                                                                style: TextStyle(
                                                                  color: Colors.cyan
                                                                ),
                                                              )
                                                            )
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(width: 0.3, color: Colors.grey)
                                                            ),
                                                            padding: EdgeInsets.only(bottom: 4,left: 16, top: 4, right: 16),
                                                            child: Text("QTY : ${produk.qty}",
                                                              style: TextStyle(
                                                                color: Colors.cyan
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ) ,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                          )
                                        ],
                                      ),
                                      trailing: produk.qty == null? 
                                      // tambah orderan
                                      IconButton(
                                        onPressed: () => 
                                        Get.bottomSheet(
                                          TambahOrder(
                                            produk: produk,
                                            data: TableCtrl.lsGroup[TableCtrl.lsGroup.indexOf(group)]['data'],
                                          ),
                                        ),
                                        icon: Icon(Icons.plus_one,
                                          color: Colors.cyan
                                        ),
                                      ): 
                                      // hapus orderan
                                      IconButton(
                                        icon: Icon(Icons.remove_circle,
                                          color: Colors.red,
                                        ), 
                                        onPressed: (){
                                          produk.note = null;
                                          produk.qty = null;
                                          TableCtrl.lsGroup.refresh();
                                          TableCtrl.cekAdaOrderan();
                                        }
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ),
                          
                          Obx(() => 
                            TableCtrl.adaOrderan.value?
                            Container(
                              padding: EdgeInsets.all(8),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.add_shopping_cart,
                                    color: Colors.cyan,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.cyan,
                                    child: Text(TableCtrl.totalOrder.toString(),
                                      style: TextStyle(
                                        color: Colors.orange[100]
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text("next to proccess",
                                      style: TextStyle(
                                        color: Colors.cyan
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios,
                                      color: Colors.cyan,
                                    ), 
                                    onPressed: (){
                                      Get.dialog(ProsesOrder());
                                    }
                                  )
                                ],
                              )
                            ):
                            SizedBox.shrink()
                          )
                        ],
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
   
  }

}


class DetailsProduct extends StatelessWidget {
  final MenuModel produk;

  const DetailsProduct({Key key, this.produk}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1,
      initialChildSize: 1,
      builder: (context, scrollController) => 
      Card(
        child: Column(
          children: [
            Container(
              color: Colors.cyan,
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  BackButton(),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                controller: scrollController,
                children: [
                  Container(
                    child: Image.network(produk.foto,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => 
                      Container(
                        color: Colors.cyan[900],
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: Text("No Image",
                            style: TextStyle(
                              color: Colors.orange[100]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(produk.namaPro,
                      style: TextStyle(
                        fontSize: 24
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(produk.ket),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// proses orderan
/// ======================================
class ProsesOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DraggableScrollableSheet(
        builder: (context, scrollController) => 
        Card(
          child: Column(
            children: [
              Container(
                color: Colors.cyan,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: [
                    BackButton(),
                    Text("my shopping cart",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange[100]
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  controller: scrollController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(final odr in TableCtrl.lsorderan)
                        Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(odr['name'],
                              style: TextStyle(
                                fontSize: 18
                              ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for(MenuModel itm in odr['data'])
                                    Container(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Image.network(itm.foto,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(itm.namaPro.toLowerCase(),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text(Pecahan.rupiah(value: int.parse(itm.hargaPro), withRp: true)),
                                                  Text("${itm.qty} x")
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: OutlineButton(
                                              onPressed: () => TableCtrl.dimana(itm),
                                              child: Text("edit",
                                              style: TextStyle(
                                                color: Colors.cyan
                                              ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Text("Esimation : ${Pecahan.rupiah(value: odr['total'], withRp: true)}"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text("Total Extimation : ${Pecahan.rupiah(value: TableCtrl.lsorderan.map((e) => e['total']).toList().reduce((value, element) => value + element), withRp: true)}")
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Card(
                  color: Colors.cyan,
                  child: FlatButton(
                    onPressed: () => TableCtrl.kirimOrderan(),
                    child: Container(
                      padding: EdgeInsets.only(right: 16, top: 4, left: 16, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("proccess",
                            style: TextStyle(
                              color: Colors.orange[100]
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                            color: Colors.orange[100],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// tambah order
/// =======================================
class TambahOrder extends StatelessWidget {
  final MenuModel produk;
  final List<MenuModel> data;

  const TambahOrder({Key key, this.produk, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) => Card(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                color: Colors.cyan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      color: Colors.orange[100],
                      onPressed: () {
                        TableCtrl.qty.value = 1;
                        TableCtrl.note.value = "";
                        Get.back();
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text("add order",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.orange[100]
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.orange[100],
                      onPressed: (){
                        data[data.indexOf(produk)].note = TableCtrl.note.value;
                        data[data.indexOf(produk)].qty = TableCtrl.qty.value;
                        TableCtrl.lsGroup.refresh();

                        TableCtrl.qty.value = 1;
                        TableCtrl.note.value = "";

                        TableCtrl.cekAdaOrderan();
                        Get.back();
                      }, 
                      child: Text("OK",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.cyan[900]
                        ),
                      )
                    )
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  controller: scrollController,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        onChanged: (value) => TableCtrl.note.value = value,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Icon(Icons.edit,
                            color: Colors.cyan,
                          ),
                          hintText: produk.note == null?"add some note": produk.note,
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                          alignLabelWithHint: true
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios), 
                            onPressed: (){
                              TableCtrl.qty.value --;
                              if(TableCtrl.qty.value < 1) TableCtrl.qty.value = 1;
                            }
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.cyan,
                            child: Obx(() =>
                              Text(TableCtrl.qty.value.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange[100]
                                ),
                              )
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios), 
                            onPressed: (){
                              TableCtrl.qty.value ++;
                            }
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// my search
class MySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) => 
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Flexible(
                child: Obx( () => 
                  ListView(
                    controller: scrollController,
                    children: [
                      for(final cari in TableCtrl.lsSearch)
                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(1),
                          margin: EdgeInsets.all(2),
                          color: Colors.grey[100],
                          child: Image.network(cari.foto,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                            Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Text("no image"),
                              ),
                            ),
                          ),
                        ),
                        title: Text(cari.namaPro.toLowerCase()),
                        onTap: () => TableCtrl.dimana(cari),
                        // onTap: () async{
                        //   final idx = TableCtrl.lsGroup.map((element) => element['name'].toString().toLowerCase()).toList().indexOf(cari.groupp.toLowerCase());
                        //   final List<MenuModel> ls = TableCtrl.lsGroup[idx]['data'];
                        //   final idx2 = ls.indexOf(cari);
                        //   TableCtrl.pageCtrl.jumpToPage(idx);
                        //   await Future.delayed(Duration(milliseconds: 500));
                        //   final ScrollController  scrl = TableCtrl.lsGroup[idx]['lsCon'];
                          
                        //   ls[idx2].terlihat = true;
                        //   TableCtrl.lsGroup.refresh();

                        //   // scrl.jumpTo((100 * idx2).toDouble());
                        //   scrl.animateTo(100 * idx2.toDouble(),
                        //     duration: Duration(milliseconds: 500),
                        //     curve: Curves.ease
                        //   );
                        //   Get.back();

                        //   Future.delayed(Duration(seconds: 2),(){
                        //     ls[idx2].terlihat = null;
                        //     TableCtrl.lsGroup.refresh();
                        //   });
                        // },
                      )
                    ],
                  )
                ) 
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffix: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.cancel_sharp),
                    ),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(4),
                    hintText: "search",
                  ),
                  onChanged: (value) {
                    TableCtrl.lsSearch.assignAll(TableCtrl.lsMenu.where((e) => e.namaPro.toLowerCase().contains(value)));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TableCtrl extends MyCtrl{
  static final lsMenu = <MenuModel>[].obs;
  static final lsSearch = <MenuModel>[].obs;
  static final lsFood = <MenuModel>[].obs;
  static final lsBeverage = <MenuModel>[].obs;
  static final lsOthers = <MenuModel>[].obs;
  static final qty = 1.obs;
  static final note = "".obs;
  static final adaOrderan = false.obs;
  static final lsorderan = [].obs;
  static final totalOrder = 0.obs;

  static final PageController pageCtrl = PageController();
  static final animateTinggi = false.obs;
  static final tinggiScroll = 150.0.obs;

  static final jam = DateTime.now().obs;

  static final company = ModelCompany().obs;

  static final lsGroup = [
    {
      "name": "food",
      "data": lsFood,
      "lsCon": ScrollController()
    },
    {
      "name": "beverage",
      "data": lsBeverage,
      "lsCon": ScrollController()
    },
    {
      "name": "others",
      "data": lsOthers,
      "lsCon": ScrollController()
    }
  ].obs;

  static init()async{

    // kosongkan orderan jika login yang kedua kalinya
    lsorderan.assignAll([]);
    adaOrderan.value = false;

    await getData();
    List<ScrollController> con = [lsGroup[0]['lsCon'], lsGroup[1]['lsCon'], lsGroup[2]['lsCon']];
    for(final c in con){
      c.addListener(() {
        if(c.position.userScrollDirection == ScrollDirection.forward){
          //print("kebawah");
          tinggiScroll.value += 4;
          if(tinggiScroll.value > 150) tinggiScroll.value = 150;
          animateTinggi.value = false;
        }else{
          //print("keatas");
          tinggiScroll.value -= 4;
          if(tinggiScroll.value < 0 ) tinggiScroll.value = 0;
          animateTinggi.value = true;
        }

      });
    }

    getDtaCompany();
  }

  static void getDtaCompany()async{
    try {
      // final res = await new Dio().get("${GetStorage().read("host")}/api/getCompanyProfile");
      final res = GetStorage().read("company");
      company.value = await compute((_) => ModelCompany.fromJson(res), "" );
      //print(company.value.name);
    } catch (e) {
      print(e.toString());
    }
  }

  static getData()async{
    final List<MenuModel> data = await ApiController.getListMenu();
    
    lsMenu.assignAll(data);
    final preFood = await compute( (_) => data.where((element) => element.groupp.toLowerCase().contains("food")),"");
    lsFood.assignAll(preFood);
    final preBeverage = await compute((_) => data.where((element) => element.groupp.toLowerCase().contains("beverage")),"");
    lsBeverage.assignAll(preBeverage);
    final preOthers = await compute((_) => data.where((element) => element.groupp.toLowerCase().contains("others")),"");
    lsOthers.assignAll(preOthers);
    
  }

  static cekAdaOrderan(){
    final od = lsGroup.map((element) => element['data']).toList().expand((element) => element).toList().where((element) => element.qty != null).toList();
    totalOrder.value = od.length;
    adaOrderan.value = totalOrder.value > 0;
    ambilListOrderan();
  }

  static dimana(MenuModel cari)async{
    final idx = lsGroup.map((element) => element['name'].toString().toLowerCase()).toList().indexOf(cari.groupp.toLowerCase());
    
    final List<MenuModel> ls = lsGroup[idx]['data'];
    
    final idx2 = ls.indexOf(cari);

    pageCtrl.jumpToPage(idx);

    await Future.delayed(Duration(milliseconds: 10));
    final ScrollController  scrl = lsGroup[idx]['lsCon'];
    
    ls[idx2].terlihat = true;
    lsGroup.refresh();

    scrl.animateTo(130 * idx2.toDouble(),
      duration: Duration(milliseconds: 500),
      curve: Curves.ease
    );
    Get.back();

    Future.delayed(Duration(seconds: 2),(){
      ls[idx2].terlihat = null;
      lsGroup.refresh();
    });
  }

  static ambilListOrderan(){
    final ls = [
      {
        "name": "food",
        "data": lsFood.where((e) => e.qty != null).toList(),
        "total": lsFood.where((e) => e.qty != null).toList().length == 0? 0: lsFood.where((e) => e.qty != null).toList().map((e) => int.parse(e.hargaPro)).toList().reduce((value, element) => value + element) * lsFood.where((e) => e.qty != null).toList().map((e) => e.qty).toList().reduce((value, element) => value + element)
      },
      {
        "name": "beverage",
        "data": lsBeverage.where((e) => e.qty != null).toList(),
        "total": lsBeverage.where((e) => e.qty != null).toList().length == 0? 0:lsBeverage.where((e) => e.qty != null).toList().map((e) => int.parse(e.hargaPro)).toList().reduce((value, element) => value + element) * lsBeverage.where((e) => e.qty != null).toList().map((e) => e.qty).toList().reduce((value, element) => value + element)
      },
      {
        "name": "others",
        "data": lsOthers.where((e) => e.qty != null).toList(),
        "total": lsOthers.where((e) => e.qty != null).toList().length == 0? 0: lsOthers.where((e) => e.qty != null).toList().map((e) => int.parse(e.hargaPro)).toList().reduce((value, element) => value + element) * lsOthers.where((e) => e.qty != null).toList().map((e) => e.qty).toList().reduce((value, element) => value + element)
      }
    ];
    lsorderan.assignAll(ls);
  }

  static kirimOrderan()async{
    final listBill = lsorderan.map((element) => element['data']).toList().expand((element) => element).toList().map((e) => {
      "note": e.note,
      "product_id": e.kodePro,
      "qty": e.qty,
      "product_price": e.hargaPro
    }).toList();
    // final listBill = dataBill.map((e) => MenuModel(
    //   note: e['note'],
    //   kodePro: e['kode_pro'],
    //   qty: e['qty'],
    //   hargaPro: e['harga_pro']
    // )).toList();

    final user = GetStorage().read("auth")['user'];
    
    final paket = {
      "customer_id": user['phone'],
      "email": user['email'],
      "name": user['name'],
      "phone": user['phone'],
      "billDetail": listBill,
      "token": GetStorage().read('token')
    };

    //print(jsonEncode(paket));

    final res = await ApiController.kirimPaket(paket);
    if(res.data['status']){
      Get.back();
      // print("berhasil ${res.data}");
      await GetStorage().write("listbill", lsorderan);
      await GetStorage().write("listmenu", lsMenu);
      await ApiController.hapusMeja2(GetStorage().read("host"), GetStorage().read("meja"));
      await GetStorage().remove("auth");
      Get.reset();
      Get.offNamed('/tunggu-pesanan');
    }else{
      
      Get.dialog(
        Center(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(res.data['note']),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: OutlineButton(
                      onPressed: () => Get.back(),
                      child: Text("OK"),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      );

      await GetStorage().remove("auth");
      await ApiController.hapusMeja2(GetStorage().read("host"), GetStorage().read("meja"));
      // print(res.data.toString());
    }
  }

}



// class OpenTable extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return HideKeyboard(
//       child: GetX<ListMenuNya>(
//         initState: (state) => ListMenuNya.to.getListMenu(),
//         builder: (controller) => 
//           Container(
//             child: Scaffold(
//             // disini : bottom sheet
//             // bottomSheet: DetailBawah(),
//             floatingActionButton: !controller.adaOrderan.value?null:
//             FloatingActionButton.extended(
//               backgroundColor: Color(0.enam()),
//               onPressed: (){
//                 showModalBottomSheet(
//                   context: context, 
//                   backgroundColor: Colors.transparent,
//                   isScrollControlled: true,
//                   builder: (_) => DetailOrderan()
//                 );

//                 // showModalBottomSheet(
//                 //   context: context, 
//                 //   backgroundColor: Colors.transparent,
//                 //   isScrollControlled: true,
//                 //   builder: (_) => Natya()
//                 // );
                
//               },
              
//               label: Text(controller.totalQty.toString()+" item of "+controller.totalOrder.toString()+" order"),
//               icon: Icon(Icons.shopping_cart),
//             ),
//             body: ListMenuNya.to.listMenu.isEmpty?Padding(
//               padding: const EdgeInsets.all(64),
//               child: Center(child: Image.asset('assets/images/logo_qr_presto.png')),
//             ):
//             SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: Visibility(
//                       visible: !ListMenuNya.to.totalanBawah.value,
//                       child: Column(
//                         children: [
//                           AppBarAtas(),
//                         ],
//                       ),
//                     ),
//                   ),
//                   PanelBar(),
//                   Flexible(
//                     child: ListMenuView()
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DetailBawah extends StatelessWidget {
//   final _theMenu = Get.find<ListMenuNya>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Obx(()=> 
//         !_theMenu.totalanBawah.value & _theMenu.adaOrderan.value?
//         Card(
//           color: Color(0.enam()),
//           child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Estimation Order",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           GarisPutus(warna: Colors.white,),
//                           Text("total order : "+ _theMenu.totalValue.value.toString().rupiah()).putih(),
//                           Text("total qty : "+ _theMenu.totalQty.value.toString()).putih()
//                         ],
//                       )
//                     ),
//                   ),
//                   Container(
//                     // disini : lihat totalan
//                     // disini : icon keranjang
//                     child: IconButton(
//                       icon: Icon(Icons.shopping_cart,
//                         color: Colors.white,
//                       ), 
//                       onPressed: (){
//                         _theMenu.lihatListOrderannya();
                        
//                         showModalBottomSheet(
//                           backgroundColor: Colors.transparent,
//                           isScrollControlled: true,
//                           context: context, 
//                           builder: (context) => 
//                           DetailOrderan()
//                         );
//                       }
//                     ),
//                   )
//                 ],
//               )
//           ),
//         ):SizedBox.shrink()
//       ),
//     );
//   }
// }


// //  cari list
// class CariListMenu extends StatelessWidget {
//   final _theMenu = Get.find<ListMenuNya>();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.white
//         )
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               onChanged: (val){
//                 _theMenu.cariListMenu();
//               },
//               controller: _theMenu.cariController.value,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 isDense: true,
//                 filled: true,
//                 fillColor: Colors.white
//               ),
//             ),
//           ),
//           InkWell(
//             child: Icon(
//               Icons.search,size: 24,
//               color: Colors.white
//             ).paddingSymmetric(horizontal: 8),
//             onTap: () => _theMenu.cariListMenu(),
//           )
//         ],
//       )
//     ).marginAll(8);
//   }
// }

// // appa bar atas
// class AppBarAtas extends StatelessWidget {
//   // final _box = GetStorage();
//   @override
//   Widget build(BuildContext context) {
  
//   return 
//   GetX<CompanyProfileController>(
//     initState: (state){
//       CompanyProfileController.to.init();
//       UserController.to.init();
//     },
//     builder: (controller) => 
//     controller.cp.value.data == null?Text("loading"):
//     Container(
//       color: Color(0.enam()),
//       padding: EdgeInsets.all(8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 InkWell(
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.account_circle_sharp),
//                   ),
//                   onTap: () => showModalBottomSheet(
//                     context: context, 
//                     isScrollControlled: true,
//                     backgroundColor: Colors.transparent,
//                     builder: (context) => UserProfile()
//                   )
//                 ),
//                 UserController.to.user.value.isNull?Text("name"):
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   child: Text(UserController.to.user.value.name??"loading ...").judulPutih
//                 )
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(CompanyProfileController?.to?.cp?.value?.data?.name??"name").putih(),
//               Text("Table "+ListMenuNya.to.meja.value).putih(),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
//   }
// }


// // panek bar
// class PanelBar extends StatelessWidget {
//   final _theMenu = Get.find<ListMenuNya>();
//   @override
//   Widget build(BuildContext context) {
//     return Obx(()=>
//       Container(
//         color: Color(0.enam()),
//         child: Column(
//           children: [
//             CariListMenu(),
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 for(var i = 0; i < _theMenu.subMenu.length;i++)
//                 Expanded(
//                   child: Column(
//                     children: [
//                       InkWell(
//                         onTap: () => ListMenuNya.to.sortSubMenu(i), 
//                         child: Container(
//                           color: _theMenu.subMenu[i]['dipilih']?Colors.orange:Color(0.enam()),
                          
//                           child: Container(
//                             color: Color(0.enam()),
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.only(bottom: 4),
//                             child: Text(_theMenu.subMenu[i]['nama'],
//                               style: TextStyle(
//                                 color: Colors.white
//                               ),
//                             ),
//                           ),
//                         )
//                       ),
//                     ],
//                   ),
//                 ),
                
//               ],
//             ),
//           ],
//         ),
//       )
//     );
//   }
// }


// class ListMenuView extends StatelessWidget {
//   final _theMenu = Get.find<ListMenuNya>();
//   @override
//   Widget build(BuildContext context) {
//     _theMenu.scrollListener();

//     return Container(
//       child: Obx(
//         (){
//           return _theMenu.listMenu.isEmpty?Center(child: Image.asset('assets/images/logo_qr_presto.png'),):
//           ListView.builder(
//             addAutomaticKeepAlives: true,
//             //controller: _theMenu.scrollController.value,
//             itemCount: _theMenu.listMenu.length,
//             itemBuilder: (context, i) => 
//             Visibility(
//               visible: _theMenu.listMenu[i].terlihat??false,
//               child: Container(
//                 padding: EdgeInsets.all(8),
//                 color: Colors.white,
//                 margin: EdgeInsets.only(bottom: 7),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           child: Card(
//                             child: CachedNetworkImage(
//                               width: 70,
//                               height: 70,
//                               fit: BoxFit.cover,
//                               imageUrl: _theMenu.listMenu[i].foto??"",
//                               placeholder: (context, url) => Center(child: Image.asset('assets/images/logo_qr_presto.png'),),
//                               errorWidget: (context, url, error) => 
//                               Center(child: Image.asset('assets/images/logo_qr_presto.png')),
//                             ),
//                           ),
//                           onTap: (){
//                             showModalBottomSheet(
//                               context: context, 
//                               backgroundColor: Colors.transparent,
//                               isScrollControlled: true,
//                               builder: (context) => 
//                               DetailMenu(listMenu: _theMenu.listMenu[i],i: i,tambah: true,),
//                             );
//                           }
//                         ),
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.only(left: 16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(_theMenu.listMenu[i].namaPro,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0.lima())
//                                   ),
//                                 ).paddingOnly(bottom: 8),
//                                 Text(_theMenu.listMenu[i].hargaPro.toString().rupiah(),
//                                   style: TextStyle(
//                                     color: Color(0.empat()),
//                                     fontSize: 18,
//                                   ),
//                                 ).paddingOnly(bottom: 8),
//                                 Text(_theMenu.listMenu[i].ket,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontStyle: FontStyle.italic
//                                   ),
//                                 ),
//                                 /* disini : keterangan note */
//                                 Container(
//                                   padding: EdgeInsets.symmetric(vertical: 8),
//                                   child: !_theMenu.listMenu[i].lihatEditTambah?
//                                   Visibility(
//                                     visible: _theMenu.listMenu[i].note == ""?false:true,
//                                     child: Container(
//                                       child: Text(_theMenu.listMenu[i].note??"",
//                                         style: TextStyle(
//                                           backgroundColor: Colors.green[50],
//                                           color: Colors.green
//                                         ),
//                                       )
//                                     ),
//                                   ):
//                                   // disini : input note
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 8),
//                                     child: Card(
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                           fillColor: Colors.grey[100],
//                                           isDense: true,
//                                           filled: true,
//                                           hintText: "eg : more salt",
//                                           contentPadding: EdgeInsets.all(8),
//                                           border: InputBorder.none
//                                         ),
//                                         maxLength: 100,
//                                         controller: _theMenu.noteController[i],
//                                         onChanged: (nilai){
//                                           _theMenu.listMenu[i].note = nilai;
//                                         },
//                                       ),
//                                     ),
//                                   )
//                                 ),
//                                 _theMenu.listMenu[i].qty == 0?
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Card(
//                                     color: Color(0.enam()),
//                                     child: InkWell(
//                                       child: Container(
//                                         padding: EdgeInsets.all(8),
//                                         child: Text("add +",
//                                           style: TextStyle(
//                                             color: Colors.white
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: ()=>ListMenuNya.to.tambahOrderan(i),
//                                     ),
//                                   ),
//                                 ):
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       // tambah note
//                                       Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 8),
//                                         child: InkWell(
//                                           // disini : tombol note
//                                           child: Card(
//                                             child:Icon(Icons.edit,
//                                               color: Colors.orange,
//                                             ),
//                                           ),
//                                           onTap: () => ListMenuNya.to.tambahNote(i),
//                                         ),
//                                       ),
//                                       Card(
//                                         child: Row(
//                                           children: [
//                                             InkWell(
//                                               child: Container(
//                                                 padding: EdgeInsets.all(8),
//                                                 child: Text("-")
//                                               ),
//                                               onTap: () => ListMenuNya.to.kurangiQty(i),
//                                             ),
//                                             Container(
//                                               padding: EdgeInsets.all(8),
//                                               child: Text(
//                                                 _theMenu.listMenu[i].qty.toString(),
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Color(0.enam()),
//                                                   fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                             InkWell(
//                                               child: Container(
//                                                 padding: EdgeInsets.all(8),
//                                                 child: Text("+")
//                                               ),
//                                               onTap: () => ListMenuNya.to.tambahQty(i),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: InkWell(
//                                             child: Card(
//                                               child: Icon(Icons.remove_circle,
//                                                 color: Colors.red,
//                                               )
//                                             ),
//                                             onTap: () => ListMenuNya.to.hapusOrderan(i),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             )
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ),
//           );
//         }
//       ),
//     );
//   }
// }
