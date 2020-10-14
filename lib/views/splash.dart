import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presto_qr/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/sanitizers.dart';


class Splash extends StatefulWidget{
  final meja, host, scure;
  const Splash({Key key, this.meja, this.host, this.scure}) : super(key: key);

  @override
  _SplashState createState() => _SplashState(meja, host, scure);
}

class _SplashState extends State<Splash> {
  final meja, host, scure;
  var load = false;

  _SplashState(this.meja, this.host, this.scure);
  @override
  void initState() {
    if(!load){
      Future.delayed(Duration(seconds: 4),()async{
        SharedPreferences prf = await SharedPreferences.getInstance();
        if(prf.getString('user') != null){
          Navigator.of(context).pushReplacementNamed('/open-table');
        }else{
          if(meja == null || host == null){
            Navigator.of(context).pushReplacementNamed('/home');
          }else{
            var aman = toBoolean(scure)?"https://":"http://";
            var hostNya = "$aman$host/prestoqr/public";
            print(hostNya);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => Login(meja: meja,host: hostNya,),));
          }
        } 
      });
      load = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('splash');
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Presto',
              style: TextStyle(
                fontSize: 42,
                color: Colors.grey
              ),
            ),
            Text('QR',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class Splash extends StatelessWidget{
//   final meja,host;
  
//   Splash({Key key, this.meja, this.host}) : super(key: key);
  
//   final _load = Map();

//   void _memuat(BuildContext context, MalikDynamic _malik)async{
//     if(_load['udah'] == null){
//         if(_malik != null){
//           _malik.prf.setString('meja', meja.toString());
//           _malik.prf.setString('host', host.toString());
          
//           await _malik.loadMalik();
//           _malik.update();
//           _load['udah'] = true;
//           await Future.delayed(Duration(seconds: 1));
//           Navigator.of(context).pushReplacementNamed('/masuk');
//         }
//       }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("iam in spalsh screen");
//     final _malik = Provider.of<MalikDynamic>(context);

//     _memuat(context,_malik);

//     // Future.delayed(Duration(seconds: 4),()async{

//     //   if(_malik.meja == null){
//     //     print('menuju ke login');
//     //     _malik.prf.setString('meja', meja.toString());
//     //     _malik.prf.setString('host', host.toString());
        
//     //     await _malik.loadMalik();
//     //     Navigator.of(context).pushReplacementNamed('/masuk');
//     //   }else{
//     //     _malik.meja = null;
//     //   }
//     // });
    
//     return Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Presto',
//                   style: TextStyle(
//                     fontSize: 42,
//                     color: Colors.grey
//                   ),   
//                 ),
//                 Text('QR',
//                   style: TextStyle(
//                     fontSize: 52,
//                     color: Colors.deepOrange
//                   ),
//                 )
//               ],
//             ),
//             Text('PROBUS SYSTEM',
//               style: TextStyle(
//                 color: Colors.blue[300]
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// // class Splash extends StatefulWidget{
// //   @override
// //   _SplashState createState() => _SplashState();
// // }

// // class _SplashState extends State<Splash> {

// //   @override
// //   void initState() {
// //     super.initState();

// //     Future.delayed(Duration(seconds: 2),()async{
// //       SharedPreferences prf = await SharedPreferences.getInstance();
// //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => prf.getString('auth') == null?Login():OpenOrder()),);
// //     });
// //   }
// //   @override
// //   Widget build(BuildContext context) {
    
// //     return Scaffold(
// //       body: Center(
// //         child: Text('Presto QR'),
// //       ),
// //     );
// //   }
// // }