import 'package:flutter/material.dart';

import 'pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/main-page': (context) => const MainPage(),
        '/home-page': (context) => const HomePage(),
        '/add-reminder-page': (context) => const AddReminderPage(),
        '/empty-reminder-page': (context) => const EmptyReminderPage(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //SystemChrome.setPreferredOrientations({DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight});

//     // return StreamProvider.value(
//     //   value: AuthServices74.firebaseUserStream,
//     //   initialData: null,
//     //child:
//     return MaterialApp(
//       // theme: ThemeData(
//       //     //textTheme:GoogleFonts.modakTextTheme() //offline, daftarkan di assets: bukan di fonts:
//       //     textTheme: GoogleFonts.srirachaTextTheme()
//       //         .copyWith(bodyText1: GoogleFonts.modak())),
//       home: MainPage(),
//       //),
//     );
//   }
// }


// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
// // class MainPage extends StatelessWidget {
// //   Map<String, Widget> menu = {
// //     "Bismillah": SizedBox(),
// //     "Bismillah": SizedBox(),
// //   };

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Drawer(
//           child: ListView(
//         reverse: true,
//         children: [
//           UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     "https://avatars.githubusercontent.com/u/97085797?s=400&u=ee10c0be4413b0f95f64939cc574f5ddfd9e42aa&v=4"),
//               ),
//               accountName: Text("Isna Febriani"),
//               accountEmail:
//                   Text("github.com/IsnaFebriani/flutter_erico_ytplaylist")),
//           ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: menu.length,
//               itemBuilder: (_, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(menu.keys.elementAt(index)),
//                     leading: Text("$index"),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => menu.values.elementAt(index)));
//                     },
//                   ),
//                 );
//               })
//         ],
//       )),
//     );
//   }
// }
