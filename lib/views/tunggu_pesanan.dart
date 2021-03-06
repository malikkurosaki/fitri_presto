import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pecahan_rupiah/pecahan_rupiah.dart';
import 'package:presto_qr/controller/api_controller.dart';
import 'package:presto_qr/main.dart';
import 'package:get/get.dart';
import 'package:presto_qr/model/company_model.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:presto_qr/views/open_table.dart';
import 'package:presto_qr/views/thank.dart';
import 'package:story_view/story_view.dart';
import 'package:swipe_up/swipe_up.dart';

class TungguPesanan extends StatelessWidget {
  // Get.dialog(Pesanan()) 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: TungguCtrl.init(),
          builder: (context, snapshot) => 
          snapshot.connectionState != ConnectionState.done?
          Obx(() => 
            TungguCtrl.company.value == null?Text("loading"):
            TungguCtrl.company.value.image == null? Center(
              child: CircularProgressIndicator(),
            ):
            Image.network(TungguCtrl.company.value.image,
              height: double.infinity,
              width: double.infinity,
            )
          ): Obx(() => 
            Stack(
              children: [
                Column(
                  children: [
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: [
                          for(final MenuModel itm in TungguCtrl.lsmenu)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white
                              ),
                              color: Colors.grey,
                            ),
                            child: GestureDetector(
                              onTap: () => Get.bottomSheet(
                                DetailsGambar(model: itm,),
                                enableDrag: true,
                                isScrollControlled: true,
                                isDismissible: true,
                                persistent: true,

                              ),
                              child: Image.network(itm.foto,
                                key: UniqueKey(),
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => Get.bottomSheet(Pesanan(),
                      isDismissible: true,
                      enableDrag: true,
                      isScrollControlled: true,
                    ) ,
                    child: Card(
                      color: Colors.cyan,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_circle_up_outlined,
                              color: Colors.white
                            ),
                            Text("show last order",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                )
              ],
            )
          )
        ),
      ),
    );
  }
}

class DetailsGambar extends StatelessWidget {
  final MenuModel model;

  const DetailsGambar({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1,
      initialChildSize: 1,
      builder: (context, scrollController) => 
      Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            Flexible(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.foto == null? Center(
                      child: CircularProgressIndicator.adaptive(),
                    ):
                    Image.network(model.foto,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(model.namaPro,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(Pecahan.rupiah(value: int.parse(model.hargaPro), withRp: true),
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.orange
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(model.ket,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class Pesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DraggableScrollableSheet(
        builder: (context, scrollController) => 
        Card(
          child: Container(
            child: ListView(
              controller: scrollController,
              children: [
                Container(
                  child: Row(
                    children: [
                      BackButton(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("Las Order",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        )
                      )
                    ],
                  ),
                ),
                for(MenuModel psn in TableCtrl.lsorderan.map((element) => element['data']).toList().expand((element) => element))
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.network(psn.foto,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                              child: Text("no image",
                                style: TextStyle(
                                  color: Colors.orange
                                ),
                              ),
                            ),
                          ), 
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(psn.namaPro.toLowerCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text("${psn.qty} x")
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TungguCtrl extends MyCtrl{
  static final lsPesanan = [].obs;
  static final lsmenu = [].obs;
  static final lsStory = <StoryItem>[].obs;
  static final StoryController controller = StoryController();
  static final scrCon = ScrollController();
  static final tinggi = 0.obs;

  static final company = ModelCompany().obs;

  static init()async{
    await thank();
    await Future.delayed(Duration(seconds: 3));
    await getListmenu();
    await getListPesanan();

    await Future.delayed(Duration(seconds: 3));
  }

  static thank()async{
    final cm = await GetStorage().read("company");
    company.value = await compute((_) => ModelCompany.fromJson(cm),"");
    // print(company.value.image);
  }
  
  static getListmenu()async{
    final listmenu = await GetStorage().read("listmenu");
    Future.delayed(Duration(seconds: 2));

    try {
      lsmenu.assignAll(listmenu.map((e) => MenuModel.fromJson(e)));
    } catch (e) {
      lsmenu.assignAll(listmenu);
      print(e.toString());
    }
  }

  static getListPesanan()async{
    try {
      final ps = await GetStorage().read("listbill");
      // print(TableCtrl.lsorderan.map((element) => element['data']).toList());
    } catch (e) {
      print(e.toString());
    }
  }
}