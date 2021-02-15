import 'dart:convert';
import 'dart:ui';

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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
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
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.account_circle,
                                          size: 20,
                                          color: Colors.orange[100],
                                        ),
                                        Text("  ${GetStorage().read("auth")['user']['name']}",
                                          style: TextStyle(
                                            color: Colors.orange[100]
                                          ),
                                        ),
                                        Text(" @ Table ${GetStorage().read("meja")}",
                                          style: TextStyle(
                                            color: Colors.orange[100]
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.access_time_outlined,
                                          color: Colors.cyan[100],
                                          size: 20,
                                        ),
                                        Text("  ${TableCtrl.jam.value.hour} : ${TableCtrl.jam.value.minute}",
                                          style: TextStyle(
                                            color: Colors.cyan[100],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: TableCtrl.company?.value?.logo == null?
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey,
                                ):
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(TableCtrl.company?.value?.logo),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.cyan[300],
                                child: InkWell(
                                  onTap: (){
                                    TableCtrl.animateTinggi.value = !TableCtrl.animateTinggi.value;
                                    TableCtrl.lsSearch.assignAll(TableCtrl.lsMenu);
                                    Get.dialog(MySearch());
                                  }, 
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("search ...",
                                        style: TextStyle(
                                          color: Colors.orange[50],
                                          fontSize: 12
                                        ),
                                      ),
                                      Icon(Icons.search,
                                        color: Colors.cyan,
                                        size: 20,
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () => TableCtrl.cobaLogout(),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Text("Logout",
                                      style: TextStyle(
                                        color: Colors.orange[100],
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                      color: Colors.orange[100],
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                    color: Colors.cyan,
                                    size: 16,
                                  ), 
                                  onPressed: (){
                                    TableCtrl.pageCtrl.previousPage(
                                      duration: Duration(microseconds: 500),
                                      curve: Curves.ease
                                    );
                                  }
                                ),
                                Text(group['name'],
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                    color: Colors.cyan,
                                    size: 16,
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
                                            child: produk.foto == null?
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundColor: Colors.grey,
                                            ):
                                            CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 40,
                                              backgroundImage: NetworkImage(produk.foto,),
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
                                                      fontWeight: FontWeight.w100,
                                                      fontSize: 18
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(Pecahan.rupiah(value: int.parse(produk.hargaPro), withRp: true),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.orange,
                                                      fontWeight: FontWeight.values[1]
                                                    ),
                                                  ),
                                                  Text(produk.ket.toLowerCase(),
                                                  overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.w100
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
                                          enableDrag: true,
                                          isScrollControlled: true,
                                          enterBottomSheetDuration: Duration(milliseconds: 1),
                                          exitBottomSheetDuration: Duration(milliseconds: 1)
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

/// details product
/// ================
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
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  BackButton(),
                  Text("Details Product")
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
                        fontSize: 24,
                        fontWeight: FontWeight.w100
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(produk.ket,
                      style: TextStyle(
                        fontWeight: FontWeight.w100
                      ),
                    ),
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
              Row(
                children: [
                  BackButton(),
                  Text("my shopping cart",),
                ],
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
                                fontSize: 18,
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
                                                      fontWeight: FontWeight.w100,
                                                      fontSize: 18
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
                  child: Obx(() => 
                    FlatButton(
                      onPressed: TableCtrl.loadingKirim.value? null: () => TableCtrl.kirimOrderan(),
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
                  )
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () {
                        TableCtrl.qty.value = 1;
                        TableCtrl.note.value = "";
                        Get.back();
                      },
                    ),
                    Expanded(
                      child: Container(
                        child: Text("add order",),
                      ),
                    ),
                    FlatButton(
                      color: Colors.cyan,
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
                          color: Colors.orange[100]
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
                          labelText: "note",
                          prefixIcon: Icon(Icons.edit,
                            color: Colors.cyan,
                          ),
                          hintText: produk.note == null?"eg: more salt": produk.note,
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
      maxChildSize: 1,
      initialChildSize: 0.8,
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
                      Container(
                        padding: EdgeInsets.all(4),
                        child: ListTile(
                          leading: cari?.foto == null?
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey,
                          ):
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(cari?.foto),
                          ),
                          title: Text(cari.namaPro.toLowerCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w100
                            ),
                          ),
                          onTap: () => TableCtrl.dimana(cari),
                        ),
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
  static final loadingKirim = false.obs;

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
    final idx = await compute((_) => lsGroup.map((element) => element['name'].toString().toLowerCase()).toList().indexOf(cari.groupp.toLowerCase()), "");
    
    final List<MenuModel> ls = await compute((_) => lsGroup[idx]['data'], "");
    
    final idx2 = await compute((_) => ls.indexOf(cari), "");

    pageCtrl.jumpToPage(idx);

    await Future.delayed(Duration(milliseconds: 10));
    final ScrollController  scrl = await compute((_) => lsGroup[idx]['lsCon'], "");
    
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

  static cobaLogout()async{

    // cosba hapus meja dulu sebelum logout
    try {
      await ApiController.hapusMeja2(GetStorage().read('host'), GetStorage().read("meja"));
    } catch (e) {
      Get.snackbar("info", e.toString(),
        backgroundColor: Colors.white
      );
    }

    // hapus data di local storage
    GetStorage().remove("auth");
    Get.offNamed("/");
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
    loadingKirim.value = true;
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

    // final ls = lsorderan.map((e) => e['data'].map((x) => x.toJson()).toList()).toList().where((element) => element.length != 0).toList().expand((element) => element).toList(); 

    final res = await ApiController.kirimPaket(paket);
    if(res.data['status']){
      
      Get.back();
      // print("berhasil ${res.data}");
      // final lsbill = lsorderan.map((e) => e['data'].map((x) => x.toJson()).toList()).toList().where((element) => element.length != 0).toList().expand((element) => element).toList();
      // await GetStorage().write("listbill", lsorderan);
      // await GetStorage().write("listmenu", lsMenu);
      await ApiController.hapusMeja2(GetStorage().read("host"), GetStorage().read("meja"));
      await GetStorage().remove("auth");
      Get.reset();

      Get.offNamed('/tunggu-pesanan');
      await GetStorage().write("listbill", lsorderan);
      await GetStorage().write("listmenu", lsMenu);
      
      loadingKirim.value = false;
    }else{
      loadingKirim.value = false;
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
    loadingKirim.value  = false;
  }

}
