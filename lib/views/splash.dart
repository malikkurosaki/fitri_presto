import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:presto_qr/controller/splash_controller.dart';
import 'package:presto_qr/views/login.dart';
import 'package:presto_qr/views/my_home.dart';
import 'package:presto_qr/component/garis_putus.dart';


class RootView extends StatelessWidget {
  final spl = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      spl.pindah.value = true;
      print("pindah lah");
    });
    return Obx(()=>spl.pindah.value?Login():Splash());
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('presto',
                style: TextStyle(
                  fontSize: 36,
                  color: Color(0.satu()),
                  fontStyle: FontStyle.normal
                ),
              ),
              Text('QR',
                style: TextStyle(
                  fontSize: 42,
                  color: Color(0.empat()),
                ),
              )
            ],
          ),
        ),
      ),      
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:presto_qr/views/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:validators/sanitizers.dart';


// class Splash extends StatefulWidget{
//   final meja, host, scure;
//   const Splash({Key key, this.meja, this.host, this.scure}) : super(key: key);

//   @override
//   _SplashState createState() => _SplashState(meja, host, scure);
// }

// class _SplashState extends State<Splash> {
//   final meja, host, scure;

//   _SplashState(this.meja, this.host, this.scure);
//   @override
//   void initState() {
//     Future.delayed(Duration(seconds: 1),()async{
//       SharedPreferences prf = await SharedPreferences.getInstance();
//       if(prf.getString('user') != null){
//         Navigator.of(context).pushReplacementNamed('/open-table');
//       }else{
//         if(meja == null || host == null){
//           Navigator.of(context).pushReplacementNamed('/home');
//         }else{
//           var aman = toBoolean(scure)?"https://":"http://";
//           var hostNya = "$aman$host/prestoqr/public";
//           print(hostNya);
//           Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => Login(meja: meja,host: hostNya,),));
//         }
//       } 
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('splash');
//     return Scaffold(
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Text('Presto',
//               style: TextStyle(
//                 fontSize: 42,
//                 color: Colors.grey
//               ),
//             ),
//             Text('QR',
//               style: TextStyle(
//                 fontSize: 52,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepOrange
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
