import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PageSearchDetail extends StatefulWidget {
  var searchData;
  PageSearchDetail({Key? key, required this.searchData}) : super(key: key);

  @override
  State<PageSearchDetail> createState() => _PageSearchDetailState();
}

class _PageSearchDetailState extends State<PageSearchDetail> {
  var searchData;
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
                      items: searchData['anh'].toString().split(',').map((item) {
                        return Container(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            child: Image.network(
                              item.trim(), // trim() để loại bỏ khoảng trắng thừa
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
                              icon: const Icon(Icons.arrow_back, color: Colors.white,),
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
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //Giá
                        Text("${searchData['gia']} vnđ", style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 17),),
                        const SizedBox(width: 130,),
                        const Icon(Icons.star, size: 16,),
                        const Text("4.5", style: TextStyle(fontSize: 16),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      searchData['tenDV'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Icon(Icons.phone_rounded),
                        const SizedBox(width: 5,),
                        Text(searchData['sdt'], style: const TextStyle(fontSize: 16),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Image.asset("assets/images/maps-and-flags.png", width: 20,),
                        Expanded(
                          child: Text(searchData['diaChi'], style: const TextStyle(fontSize: 16))),
                        const SizedBox(width: 5,)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text(searchData['moTa'])
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
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
  @override
  void initState() {
    searchData = widget.searchData;
    super.initState();
  }
}