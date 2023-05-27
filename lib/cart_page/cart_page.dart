import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinpearl_app/cart_page/cart_data.dart';

import '../service_data/resort_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartData>(context);
    final List<dynamic> cartItems = cartProvider.cartItems; // gọi provider và gán list để sử dụng
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index]; // mỗi item ở đây là 1 snapshot ( resort, restaurantt, ... )
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
                    // tại vì là dynamic nên trong item sẽ nhiều kiểu khác nhau nên sẽ không truyền thẳng là item.resortService.anh[0] đc
                      // vì thằng khác vd như restaurant sẽ lỗi nên thay vào đó ta tạo hàm get lấy thông tin của mỗi kiểu ở mỗi trang
                      // data service của nó
                    child: Image.network(item.getAnh(),fit: BoxFit.cover,)),
                ),
                SizedBox(width: 5,),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(item.getTenDV(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                item.decreaseQuantity(); // Decrease quantity
                              });
                            },
                          ),
                          Text(
                            item.getQuantity().toString(), // Display quantity
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                item.increaseQuantity(); // Increase quantity
                              });
                            },
                          ),
                        ],
                      ),
                      Text("${item.updatePrice()}")
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