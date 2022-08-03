// import 'package:flutter/material.dart';
// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:salebee/Data/static_data.dart';
// import 'package:salebee/Model/login_model.dart';
// import 'package:salebee/Service/sharedPref_service.dart';
// import 'package:salebee/Utils/my_colors.dart';
// import 'package:salebee/Widget/bottom_bar.dart';
//
// import '../../Widget/custom_clipper.dart';
// import '../Attendance/chek_in_out.dart';
// import '../SplashScreen.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation degOneTranslationAnimation,
//       degTwoTranslationAnimation,
//       degThreeTranslationAnimation;
//   late Animation rotationAnimation;
//
//   double getRadiansFromDegree(double degree) {
//     double unitRadian = 57.295779513;
//     return degree / unitRadian;
//   }
//
//   @override
//   void initState() {
//     animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 250));
//     degOneTranslationAnimation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 75.0),
//       TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 25.0),
//     ]).animate(animationController);
//     degTwoTranslationAnimation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 55.0),
//       TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 45.0)
//     ]).animate(animationController);
//     degThreeTranslationAnimation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.75), weight: 35.0),
//       TweenSequenceItem(tween: Tween(begin: 1.75, end: 1.0), weight: 65.0)
//     ]).animate(animationController);
//     rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
//         CurvedAnimation(parent: animationController, curve: Curves.easeOut));
//     super.initState();
//     animationController.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (animationController.isCompleted) {
//       animationController.forward();
//     } else {
//       animationController.forward();
//     }
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: MyColors.appColor,
//       body: Container(
//         width: size.width,
//         height: size.height,
//         child: Stack(
//           children: [
//             Column(children: [
//               SizedBox(
//                 height: 20,
//               ),
//               ListTile(
//                 title: Text("Name:${StaticData.name}"),
//                 subtitle: Text("Employee ID:${StaticData.employeeID}"),
//                 trailing: GestureDetector(
//                     onTap: (){
//                       SharedPreff.to.prefss.remove("loggedIN");
//                       SharedPreff.to.prefss.remove("userNAME");
//                       SharedPreff.to.prefss.remove("proLink");
//                       SharedPreff.to.prefss.remove("employeeID");
//                       SharedPreff.to.prefss.remove("token");
//                       Get.to(() => Splash());
//                     },
//                     child: Icon(Icons.settings)),
//               ),
//             ]),
//             Positioned(
//               left: 10,
//               bottom: 280,
//               child: Stack(
//                 children: [
//                   Transform.translate(
//                     offset: Offset.fromDirection(getRadiansFromDegree(360),
//                         degOneTranslationAnimation.value * 130),
//                     child: Transform(
//                       transform: Matrix4.rotationZ(
//                           getRadiansFromDegree(rotationAnimation.value))
//                         ..scale(degOneTranslationAnimation.value),
//                       alignment: Alignment.center,
//                       child: CircularButton(
//                         color: Colors.white,
//                         width: 50,
//                         height: 50,
//                         icon: Icon(
//                           Icons.add,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset.fromDirection(getRadiansFromDegree(330),
//                         degOneTranslationAnimation.value * 120),
//                     child: Transform(
//                       transform: Matrix4.rotationZ(
//                           getRadiansFromDegree(rotationAnimation.value))
//                         ..scale(degOneTranslationAnimation.value),
//                       alignment: Alignment.center,
//                       child: CircularButton(
//                         color: Colors.white,
//                         width: 50,
//                         height: 50,
//                         icon: Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset.fromDirection(getRadiansFromDegree(300),
//                         degOneTranslationAnimation.value * 120),
//                     child: Transform(
//                       transform: Matrix4.rotationZ(
//                           getRadiansFromDegree(rotationAnimation.value))
//                         ..scale(degOneTranslationAnimation.value),
//                       alignment: Alignment.center,
//                       child: CircularButton(
//                         color: Colors.white,
//                         width: 50,
//                         height: 50,
//                         icon: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset.fromDirection(getRadiansFromDegree(270),
//                         degOneTranslationAnimation.value * 120),
//                     child: Transform(
//                       transform: Matrix4.rotationZ(
//                           getRadiansFromDegree(rotationAnimation.value))
//                         ..scale(degOneTranslationAnimation.value),
//                       alignment: Alignment.center,
//                       child: CircularButton(
//                         color: Colors.white,
//                         width: 50,
//                         height: 50,
//                         icon: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset.fromDirection(getRadiansFromDegree(30),
//                         degOneTranslationAnimation.value * 120),
//                     child: Transform(
//                       transform: Matrix4.rotationZ(
//                           getRadiansFromDegree(rotationAnimation.value))
//                         ..scale(degOneTranslationAnimation.value),
//                       alignment: Alignment.center,
//                       child: CircularButton(
//                         color: Colors.white,
//                         width: 50,
//                         height: 50,
//                         icon: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset.fromDirection(getRadiansFromDegree(60),
//                         degOneTranslationAnimation.value * 120),
//                     child: Transform(
//                       transform: Matrix4.rotationZ(
//                           getRadiansFromDegree(rotationAnimation.value))
//                         ..scale(degOneTranslationAnimation.value),
//                       alignment: Alignment.center,
//                       child: CircularButton(
//                         color: Colors.white,
//                         width: 50,
//                         height: 50,
//                         icon: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset.fromDirection(getRadiansFromDegree(90),
//                         degOneTranslationAnimation.value * 120),
//                     child: Transform(
//                       transform: Matrix4.rotationZ(
//                           getRadiansFromDegree(rotationAnimation.value))
//                         ..scale(degOneTranslationAnimation.value),
//                       alignment: Alignment.center,
//                       child: CircularButton(
//                         color: Colors.white,
//                         width: 50,
//                         height: 50,
//                         icon: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform(
//                     transform: Matrix4.rotationZ(
//                         getRadiansFromDegree(rotationAnimation.value)),
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap: () {
//
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight:Radius.circular(100) ),
//                           color: Colors.blue[300],
//                         ),
//                         width: 100,
//                         height: 100,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CircularButton extends StatelessWidget {
//   final double? width;
//   final double? height;
//   final Color? color;
//   final Icon? icon;
//   Widget? child;
//
//   CircularButton({this.color, this.width, this.height, this.icon, this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//       width: width,
//       height: height,
//       child: child,
//     );
//   }
// }
