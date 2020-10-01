import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presto_qr/views/login.dart';

class Splash extends StatelessWidget{
  final meja,host;
  
  const Splash({Key key, this.meja, this.host}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("touch splash screen");

    Future.delayed(Duration(seconds: 4),(){
      print('menuju ke login');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login(meja: meja,host: host,),));
    });
    
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    color: Colors.deepOrange
                  ),
                )
              ],
            ),
            Text('PROBUS SYSTEM',
              style: TextStyle(
                color: Colors.blue[300]
              ),
            )
          ],
        ),
      ),
    );
  }
}
// class Splash extends StatefulWidget{
//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(Duration(seconds: 2),()async{
//       SharedPreferences prf = await SharedPreferences.getInstance();
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => prf.getString('auth') == null?Login():OpenOrder()),);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: Center(
//         child: Text('Presto QR'),
//       ),
//     );
//   }
// }