import 'package:flutter/material.dart';
import 'package:vinpearl_app/cart_page/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartModel> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey[300]
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(item.cartItems.anh[0], fit: BoxFit.cover,))
                ),
                SizedBox(width: 5,),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(item.resortService.tenDV, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Quantity"),

                        ],
                      )
                    ],
                  ),

                ),



              ],
            ),
            // child: ListTile(
            //   leading: Image.network(item.resortService.anh[0]),
            //   title: Text(item.resortService.tenDV),
            //   subtitle: Text(item.resortService.gia),
            //   trailing: IconButton(
            //     icon: Icon(Icons.delete),
            //     onPressed: () {
            //       setState(() {
            //         CartManager.removeFromCart(item);
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(content: Text("Đã xóa thành công"),duration: Duration(seconds: 2),),
            //         );
            //       });
            //     },
            //   ),
            // ),
          );
        },
      ),

    );
  }
}