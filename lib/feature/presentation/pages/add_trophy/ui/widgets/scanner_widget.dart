// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_mobile_vision/qr_camera.dart';

// class Scanner extends StatefulWidget {
//   const Scanner({Key? key}) : super(key: key);

//   @override
//   _ScannerState createState() => _ScannerState();
// }

// class _ScannerState extends State<Scanner> {
//   @override
//   Widget build(BuildContext context) {
//     // AddTrophyProvider provider = Provider.of(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(120.0),
//         child: Container(
//           height: 120.0,
//           padding: EdgeInsets.only(top: 32.0),
//           child: AppBar(
//               centerTitle: false,
//               leading: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: SvgPicture.asset('assets/img/cancel.svg'),
//               ),
//               elevation: 0.0,
//               shadowColor: Colors.white,
//               iconTheme: IconThemeData(color: Color(0xFF333333)),
//               backgroundColor: Colors.white,
//               title: Text(
//                 'Scan Serial Number',
//                 style: GoogleFonts.raleway(
//                     fontFeatures: [FontFeature.enable('lnum')],
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black),
//               )),
//         ),
//       ),
//       body: Container(
//         child: QrCamera(
//           qrCodeCallback: (String value) {
//             print(value);
//             // provider.setBarcode(value.replaceAll('A', ''));
//           },
//           child: Container(
//             child: Center(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 46.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     provider.scanValue != null
//                         ? Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.white)),
//                             height: 130.0,
//                             child: Container(
//                               padding: EdgeInsets.only(bottom: 13.0),
//                               alignment: Alignment.bottomCenter,
//                               child: Text(
//                                 provider.scanValue,
//                                 style: GoogleFonts.raleway(
//                                     fontFeatures: [FontFeature.enable('lnum')],
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           )
//                         : Container(),
//                     SizedBox(
//                       height: 41.0,
//                     ),
//                     provider.scanValue != null
//                         ? Container(
//                             width: double.infinity,
//                             height: 40.0,
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                 padding: EdgeInsets.all(0.0),
//                                 backgroundColor: ThemeDefaults.primaryColor,
//                               ),
//                               onPressed: () =>
//                                   Navigator.pop(context, provider.scanValue),
//                               child: Text(
//                                 'OK',
//                                 style: GoogleFonts.raleway(
//                                     fontFeatures: [FontFeature.enable('lnum')],
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w800,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           )
//                         : SizedBox()
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
