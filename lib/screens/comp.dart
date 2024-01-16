// import 'package:component/services/post_api_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Comp extends StatefulWidget {
//   const Comp({super.key});
//
//   @override
//   State<Comp> createState() => _CompState();
// }
//
// class _CompState extends State<Comp> {
//
//
//   late List<bool> tools = [true, true, true, true];
//   late List<String> toolAction = ["in", "in", "in", "in"];
//
//
//
//   // @override
//   // void initState(){
//   //   setState(() {
//   //     condition = false;
//   //   });
//   // }
//
//   // _apiCall(){
//   //   PostAPIService().postTools();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     // Handle tap gesture here
//                     // _apiCall();
//                     setState(() {
//                       // condition = !condition;
//                       tools[0] = !tools[0];
//
//                     });
//                     if(tools[0]){
//                       setState(() {
//                           toolAction[0] = "in";
//                       });
//                     }
//                     else if(!tools[0]){
//                       toolAction[0] = "out";
//                     }
//                     PostAPIService().postTools(toolAction[0], 1);
//                     // Add your desired actions within this function
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 3.0,
//                       ),
//                     ),
//                     height: MediaQuery.of(context).size.height * 0.33,
//                     width: MediaQuery.of(context).size.width * 0.49,
//                     child: Image(
//                       image: tools[0]
//                           ? const AssetImage('assets/images/wrenches_green.png')
//                           : const AssetImage('assets/images/wrenches_red.png'),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 GestureDetector(
//                   onTap: () {
//                     // Handle tap gesture here
//                     setState(() {
//                       tools[1] = !tools[1];
//                     });
//                     if(tools[1]){
//                       setState(() {
//                         toolAction[1] = "in";
//                       });
//                     }
//                     else if(!tools[1]){
//                       toolAction[1] = "out";
//                     }
//                     PostAPIService().postTools(toolAction[1], 2);
//                     // Add your desired actions within this function
//                   },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 3.0,
//                     ),
//                   ),
//                   // color: Colors.red,
//                   height: MediaQuery.of(context).size.height * 0.33,
//                   width: MediaQuery.of(context).size.width * 0.49,
//                   child: Image(
//                     image: tools[1]
//                         ? const AssetImage('assets/images/bolt_green.png')
//                         : const AssetImage('assets/images/bolt_red.png'),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 ),
//
//               ],
//             ),
//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//
//                 GestureDetector(
//                   onTap: () {
//                     // Handle tap gesture here
//                     setState(() {
//                       tools[2] = !tools[2];
//                     });
//                     if(tools[2]){
//                       setState(() {
//                         toolAction[2] = "in";
//                       });
//                     }
//                     else if(!tools[2]){
//                       toolAction[2] = "out";
//                     }
//                     PostAPIService().postTools(toolAction[2], 3);
//                     // Add your desired actions within this function
//                   },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 3.0,
//                     ),
//                   ),
//                   // color: Colors.red,
//                   height: MediaQuery.of(context).size.height * 0.33, // Set height to 75% of screen
//                   width: MediaQuery.of(context).size.width * 0.49,
//                   child: Image(
//                     image: tools[2]
//                         ? const AssetImage('assets/images/plier_green.png')
//                         : const AssetImage('assets/images/plier_red.png'),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 ),
//
//                 GestureDetector(
//                   onTap: () {
//                     // Handle tap gesture here
//                     setState(() {
//                       // condition = !condition;
//                       tools[3] = !tools[3];
//                     });
//                     if(tools[3]){
//                       setState(() {
//                         toolAction[3] = "in";
//                       });
//                     }
//                     else if(!tools[3]){
//                       toolAction[3] = "out";
//                     }
//                     PostAPIService().postTools(toolAction[3], 4);
//                     // Add your desired actions within this function
//                   },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 3.0,
//                     ),
//                   ),
//                   // color: Colors.red,
//                   height: MediaQuery.of(context).size.height * 0.33,
//                   width: MediaQuery.of(context).size.width * 0.49,
//                   child: Image(
//                     image: tools[3]
//                         ? const AssetImage('assets/images/screwdriver_green.png')
//                         : const AssetImage('assets/images/screwdriver_red.png'),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 ),
//
//               ],
//             ),
//
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //   children: [
//             //     Container(
//             //       decoration: BoxDecoration(
//             //         border: Border.all(
//             //           color: Colors.grey,
//             //           width: 3.0,
//             //         ),
//             //       ),
//             //       // color: Colors.red,
//             //       height: MediaQuery.of(context).size.height * 0.33, // Set height to 75% of screen
//             //       width: MediaQuery.of(context).size.width * 0.49,
//             //       child: Padding(
//             //         padding: const EdgeInsets.all(8.0),
//             //         child: Image(
//             //           image: tools[3]
//             //               ? const AssetImage('assets/images/wrenches_green.png')
//             //               : const AssetImage('assets/images/wrenches_red.png'),
//             //           fit: BoxFit.contain,
//             //         ),
//             //       ),
//             //     ),
//             //     Container(
//             //       decoration: BoxDecoration(
//             //         border: Border.all(
//             //           color: Colors.grey,
//             //           width: 3.0,
//             //         ),
//             //       ),
//             //       // color: Colors.red,
//             //       height: MediaQuery.of(context).size.height * 0.33,
//             //       width: MediaQuery.of(context).size.width * 0.49,
//             //     ),
//             //
//             //   ],
//             // ),
//           ],
//         ),
//
//       );
//   }
// }
