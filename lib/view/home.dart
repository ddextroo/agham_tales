import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/bookshelf.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero, // Removes default padding
      //     children: [
      //       DrawerHeader(
      //         decoration: const BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Column(
      //           children: [
      //             Image.asset(
      //               "assets/images/logo-no-bg.png",
      //               width: 100,
      //               height: 100,
      //             ),
      //             Text("Agham Tales", style: TextStyle(color: Colors.white, fontSize: 16),)
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text('Home'),
      //         onTap: () {
      //           // Handle navigation or actions
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.info),
      //         title: Text('About us'),
      //         onTap: () {
      //           // Handle navigation or actions
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0284c7),
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     _scaffoldKey.currentState!.openDrawer();
        //   },
        //   color: Colors.white,
        //   icon: const Icon(Icons.menu),
        //   iconSize: 20,
        // ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.info), iconSize: 20, color: Colors.white,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Books", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.60,
                children: const [
                  BookCover(
                    imageUrl: "assets/images/cover_books/bennie.png",
                    title: "Bennie's ForceTastic Adventure",
                    progress: 0.7,
                    isLocked: false,
                    currentPage: 420,
                    totalPages: 600,
                    quizScore: 8,
                    totalQuizScore: 10,
                  ),
                  BookCover(
                    imageUrl: "assets/images/cover_books/lily.png",
                    title: "Lily and the Swing",
                    progress: 0.3,
                    isLocked: true,
                    currentPage: 90,
                    totalPages: 300,
                  ),
                  BookCover(
                    imageUrl: "assets/images/cover_books/wonder.png",
                    title: "The Day of Moving Wonders",
                    progress: 0.5,
                    isLocked: false,
                    currentPage: 150,
                    totalPages: 300,
                    quizScore: 5,
                    totalQuizScore: 10,
                  ),
                  BookCover(
                    imageUrl: "assets/images/cover_books/mystical.png",
                    title: "Leo and the Mystical Cave",
                    progress: 0.0,
                    isLocked: true,
                    currentPage: 0,
                    totalPages: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
