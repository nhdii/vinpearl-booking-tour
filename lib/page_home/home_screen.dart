import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:vinpearl_app/auth.dart';
import 'package:vinpearl_app/page_detail/page_popular_service_detail.dart';
import 'package:vinpearl_app/page_profile/page_profile.dart';
import 'package:vinpearl_app/service_page/meeting_page.dart';
import 'package:vinpearl_app/service_page/page_golf.dart';
import 'package:vinpearl_app/service_page/page_resort.dart';
import 'package:vinpearl_app/service_page/page_restaurant.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final  User? user = Auth().currentUser;

  Future<void> signOut() async{
    await Auth().signOut();
  }

  Widget _title(){
    return const Text('Firebase Auth');
  }

  Widget _userUid(){
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton(){
    return ElevatedButton(
        onPressed: signOut,
        child: const Text('Sign Out')
    );
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _openDrawer,
        ),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: 1, end: 0),
                badgeAnimation: const badges.BadgeAnimation.scale(),
                child: const Icon(
                  Icons.shopping_cart,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),

      //drawer
      drawer: Drawer(
        width: 280,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
           DrawerHeader(
             child: Container(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     CircleAvatar(
                       child: Text("${user!.email!.substring(0,1)}", style: TextStyle(fontSize: 30),),
                       backgroundColor: Colors.cyan,
                       maxRadius: 30,
                     ),
                     _userUid(),
                   ],
                 ),
               ),
             ),),

            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Profile', style: TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_long_outlined),
              title: Text('Your Bill', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Xử lý khi người dùng chọn mục xem bill
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Setting', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Xử lý khi người dùng chọn mục cai dat
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Log Out', style: TextStyle(fontSize: 16)),
              onTap: () {
                signOut();
                // Xử lý khi người dùng chọn mục log out
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("VINPEARL", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),),
              const Text("Booking your tour", style: TextStyle(fontSize: 25),),
              const SizedBox(height: 35,),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Điều chỉnh hướng đổ bóng
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        // Xóa nội dung của TextField
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none, // Xóa viền biên của TextField
                    ),
                    filled: true,
                    fillColor: Colors.white, // Màu nền cho TextField
                  ),
                  onChanged: (value) {
                    // Xử lý khi giá trị của TextField thay đổi
                  },
                ),
              ),

              const SizedBox(height: 40,),
              const Text("Categories", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

              Container(
                padding: const EdgeInsets.only(top: 25.0, bottom: 40.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResortPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/resort.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Resort", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/restaurant.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Restaurant", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GolfPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/golf.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Golf", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingPage(),));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              // color: Colors.white,
                              child: Image.asset('assets/images/meeting-room.png', width: 40,),
                            ),
                            const SizedBox(height: 15,),
                            const Text("Meeting", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Text("Popular", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

              SizedBox(height: 30,),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.9,
                  mainAxisSpacing: 25,
                ),

                // itemCount: popularServic`es.length,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PopularServiceDetail(),));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  // name Service
                                  Text(
                                    "Vinpearl Luxury Nha Trang",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                    ),
                                  ),

                                  SizedBox(height: 15,),

                                  //Phone number
                                  Row(
                                    children: [
                                      Icon(Icons.phone_outlined, size: 20,),
                                      Text("0258 359 9099", style: TextStyle(fontSize: 13),)
                                    ],
                                  ),

                                  SizedBox(height: 15,),

                                  // address
                                  Row(
                                    children: [
                                      Image.asset("assets/images/maps-and-flags.png", width: 20,),
                                      Expanded(
                                          child: Text("Hon Tre Island, Nha Trang, Vietnam", style: TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis,))
                                    ],
                                  ),

                                  SizedBox(height: 15,),

                                  // rating
                                  Row(
                                    children: [
                                      Icon(Icons.star, size: 20),
                                      Text("4.5", style: TextStyle(fontSize: 13)),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network('https://cf.bstatic.com/xdata/images/hotel/square600/418142776.webp?k=e313a78bc7c97efe03aa10423cd819b7147c621722bf078b93cf92427594b12c&o=&s=1',  width: 170, height: 180,fit: BoxFit.cover)
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}


