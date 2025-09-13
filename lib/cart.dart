import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late String endpoint;
  final int id = 1;
  bool isAll = false;
  List<bool> checked = [];

  @override
  void initState() {
    super.initState();
    endpoint = 'http://172.20.10.5:8000/api/cart/details';
  }

  Future getCart() async {
    var url = Uri.parse(endpoint);
    var responseCart = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"id_user": id}),
    );

    if (responseCart.statusCode == 200) {
      print(responseCart.body);
      final data = json.decode(responseCart.body) as Map<String, dynamic>;
      final List items = data["0"];
      if (checked.length != items.length) {
        checked = List.filled(items.length, false);
      }
      return json.decode(responseCart.body);
    } else {
      throw Exception("Gagal ambil data");
    }
  }

  Widget build(BuildContext context) {
    getCart();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map<String, dynamic> data =
                snapshot.data as Map<String, dynamic>;
            final List items = data["0"];
            final int total = data["total"];

            return Column(
              children: [
                Container(
                  height: 53,
                  child: Row(
                    children: [
                      SizedBox(width: 22),
                      Checkbox(
                        value: isAll,
                        onChanged: (bool? newValue) {
                          setState(() {
                            for (var i = 0; i < checked.length; i++) {
                              isAll = newValue ?? false;
                              checked[i] = isAll;
                            }
                          });
                        },
                      ),
                      Text(
                        "All",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final details = item['details'];
                      final String nama_barang = details['nama_barang'].toString();
                      final String size = item['size'].toString();
                      final String harga = item['harga_satuan'].toString();
                      final String jumlah = item['jumlah'].toString();
                      final String urlGambar = details['url_gambar'].toString();


                      return Column(
                        children: [
                          SizedBox(
                            width: 365,
                            height: 86,
                            child: Row(
                              children: [
                                SizedBox(width: 9),
                                Checkbox(
                                  value: checked[index],
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      checked[index] = newValue ?? false;
                                      isAll = checked.every(
                                        (element) => element == true,
                                      );
                                    });
                                  },
                                ),

                                Image.network(urlGambar, width: 58, height: 58),
                                SizedBox(width: 21),
                                SizedBox(
                                  width: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        nama_barang,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Rp.$harga",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        "Size: $size",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 56),

                                SizedBox(
                                  width: 38,
                                  height: 23,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(),
                                    onPressed: () {},
                                    child: Text("-"),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsetsGeometry.directional(start: 8,end: 8),
                                  child: Text(jumlah),
                                ),
                                SizedBox(
                                  width: 38,
                                  height: 23,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      alignment: AlignmentGeometry.center,
                                    ),
                                    onPressed: () {},
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.directional(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Text("Total Harga: Rp.$total",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      SizedBox(width: 23,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(157, 57),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
                          backgroundColor: Color.fromRGBO(39, 39, 39, 1),
                          foregroundColor: Colors.white
                        ),
                        onPressed: (){}, child: Text("Checkout",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold ),)),
                    ],
                  ),)
              ],
            );
          } else {
            return Text("tidak ada data");
          }
        },
      ),
    );
  }
}
