import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MySetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _berubah = Berubah(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Text('SETTING',
              style: TextStyle(
                fontSize: 42,
                color: Colors.grey
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  onPressed: ()async{
                    SharedPreferences prf = await SharedPreferences.getInstance();
                    prf.clear();
                    Navigator.of(context).pushReplacementNamed('/');
                  }, 
                  child: Text('keluar')
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}

class Berubah extends ValueNotifier{
  Berubah(value) : super(value);
  update(){
    notifyListeners();
  }
}

// class MySetting extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     // final _setting = Provider.of<Map<String,dynamic>>(context);
//     // if(_setting == null) return Center(child: CircularProgressIndicator(),);
//     final _menu = Provider.of<Map>(context);
//     final _malik = Provider.of<MalikDynamic>(context);
//     if(_menu == null) return Center(child: CircularProgressIndicator(),);

//     return Scaffold(
//       body: SafeArea(
//         child: Pagination(
//           pageBuilder: (currentListSize) => lsNya(_malik,_menu[Malik.MENU.toString()],currentListSize),
//           itemBuilder: (index, item) => 
//           Visibility(
//             visible: item[Malik.TERLIHAT.toString()],
//             child: ListTile(
//               title: Text(item['nama_pro']),
              
//             )
//           )
//         ),
//         // child: ListView(
//         //   children: [
//         //     Text('setting'),
//         //     Column(
//         //       crossAxisAlignment: CrossAxisAlignment.start,
//         //       children: [
                
//         //         // FlatButton(
//         //         //   onPressed: ()async{
//         //         //     SharedPreferences prf = await SharedPreferences.getInstance();
//         //         //     prf.remove('menu');
//         //         //     Phoenix.rebirth(context);
//         //         //   }, 
//         //         //   child: Text('bersihkan cache')
//         //         // ),

//         //         // if(!_setting[Setting.ADAHOST.toString()] && _setting[Setting.DEVELOP.toString()])
//         //         // Text('apa kabar')
//         //       ],
//         //     )
//         //   ],
//         // ),
//       ),
//     );
//   }

//   Future<List> lsNya(MalikDynamic _malik,ls,int ini)async{
//     await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
//     if(ini < ls.length){
//       print('tambah');
//       for(var i = ini ; i < ini + 10; i++){
//         ls[i][Malik.TERLIHAT.toString()] = true;
//       }
//       //_malik.update();
//     }
//     return ls;
//   }
  
// }