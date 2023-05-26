import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PopularServiceDetail extends StatelessWidget {
  const PopularServiceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.36,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: [
                        "https://cf.bstatic.com/xdata/images/hotel/square600/418142776.webp?k=e313a78bc7c97efe03aa10423cd819b7147c621722bf078b93cf92427594b12c&o=&s=1",
                        "https://cf.bstatic.com/xdata/images/hotel/max1024x768/37343067.jpg?k=4d1e431b5cb0e40c1c352bc7a7d1c204c57e581ae586fc24a465030cd7f84b2e&o=&hp=1",
                        "https://cf.bstatic.com/xdata/images/hotel/max1024x768/164416341.jpg?k=73b5d341a6d1e78901defadef918198c456836ce697063502ca79843e6d0ceb2&o=&hp=1",
                        "https://cf.bstatic.com/xdata/images/hotel/max1024x768/164416368.jpg?k=51d31521358431111c7037d72ee72d715c86c52e68551839efef7438a3ee1628&o=&hp=1"
                        // Add more image URLs here
                      ].map((item) {
                        return Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Image.network(
                              item,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white,),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(child: Container()), // To align the title to the center, you can use an Expanded widget
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //Giá
                        Text("2.000.000vnd", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 17),),
                        SizedBox(width: 130,),
                        Icon(Icons.star, size: 16,),
                        Text("4.5", style: TextStyle(fontSize: 16),)
                      ],
                    ),

                    SizedBox(height: 10,),

                    Text(
                      "Vinpearl Luxury Nha Trang",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.phone_rounded),
                        SizedBox(width: 5,),
                        Text("0258 359 9099", style: TextStyle(fontSize: 16),),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/images/maps-and-flags.png", width: 20,),
                        SizedBox(width: 5,),
                        Text("Hon Tre Island, Nha Trang, Vietnam", style: TextStyle(fontSize: 16),)
                      ],
                    ),

                    SizedBox(height: 10,),
                    Text("Desription", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

                    SizedBox(height: 10,),
                    Text("Vinpearl Luxury Nha Trang provides a secluded getaway on Hon Tre Island. "
                        "Located along Nha Trang Beach, this seafront resort features an overwater spa and a private beach area. "
                        "Spacious villas showcase elegant touches of traditional Vietnamese culture and are fitted with classic "
                        "wooden furnishings. All villas feature a plunge pool, private garden and a balcony overlooking the sea. "
                        "Each offers free Wi-Fi, 46-inch LCD TV and luxury bathroom amenities such as sea salts and candles. "
                        "Guests can pamper themselves with a massage by the sea or work out with a game of tennis. "
                        "An outdoor pool with a spa pool and poolside bar is also available. Traditional "
                        "Vietnamese delights can be enjoyed at Vietnam Restaurant while international "
                        "favourites are served at International Restaurant. Refreshing drinks are offered in the resort’s bar.")

                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 220,
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add service to cart logic goes here
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Add to cart ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Icon(Icons.navigate_next_outlined,)
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      primary: Colors.orange[300],
                      minimumSize: Size(220, 60),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
