import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pecahan_rupiah/pecahan_rupiah.dart';
import 'package:presto_qr/main.dart';
import 'package:get/get.dart';
import 'package:presto_qr/model/menu_model.dart';
import 'package:story_view/story_view.dart';
import 'package:swipe_up/swipe_up.dart';

class TungguPesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeUp(
      onSwipe: () => Get.dialog(Pesanan()) ,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.keyboard_arrow_up_outlined,
              color: Colors.white
            ),
            Text('show last order', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body : Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: TungguCtrl.init(),
            builder: (context, snapshot) => 
            snapshot.connectionState != ConnectionState.done?
            Text("tunggu"): Obx(() => 
              TungguCtrl.lsStory.length == 0? Text("loading item"):
              StoryView(
                storyItems: TungguCtrl.lsStory,
                repeat: true,
                controller: TungguCtrl.controller,
              )
            )
          ),
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
                for(MenuModel psn in TungguCtrl.lsPesanan)
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

class ItemStory implements StoryItem{
  final data;
  final url;
  final ket;
  final harga;
  ItemStory({this.data, this.url, this.ket, this.harga});

  @override
  bool shown = true;

  @override
  Duration get duration => Duration(seconds: 3);

  @override
  Widget get view => Center(
    child: Container(
      color: Colors.black,
      child: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.only(top: 32),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text("Rp"),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(Pecahan.rupiah(value: int.parse(harga)),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(url,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                        Center(
                          child: Text("error image"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black
                            ]
                          )
                        ),
                        height: double.infinity,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(bottom: 50),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(8),
          //         child: Text(data,
          //           style: TextStyle(
          //             fontSize: 24,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(8,),
          //         child: Text(ket,
          //           style: TextStyle(
          //             color: Colors.white
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    ),
  );
  
}

class TungguCtrl extends MyCtrl{
  static final lsPesanan = [].obs;
  static final lsmenu = [].obs;
  static final lsStory = <StoryItem>[].obs;
  static final StoryController controller = StoryController();
  static final scrCon = ScrollController();
  static final tinggi = 0.obs;

  static init()async{
    await getListmenu();
    await getListPesanan();
  }

  static getListmenu()async{
    try {
      final List lm = await GetStorage().read("listmenu");
      //print(lm);
      final itm = lm.map((e) => ItemStory(
        data: e['nama_pro'],
        url: e['foto'],
        ket: e['ket'],
        harga: e['harga_pro']
      ));

      lsStory.assignAll(itm);
      lsmenu.assignAll(lm);
    } catch (e) {
      print(e.toString());
    }
  }

  static getListPesanan()async{
    try {
      final ps = await GetStorage().read("listbill");
      lsPesanan.assignAll(ps);
      
      //print(lsPesanan);
    } catch (e) {
      print(e.toString());
    }
  }
}