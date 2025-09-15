import 'package:flutter/material.dart';
import 'package:sio_ecommerce_mobile/cart.dart';
import 'package:sio_ecommerce_mobile/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late String url;

  String? selectedSize;

  @override
  void initState() {
    super.initState();
    url = 'http://172.20.10.5:8000/api/details/${widget.id}';
  }

  Future getDetails() async {
    var responseDetails = await http.get(Uri.parse(url));

    if (responseDetails.statusCode == 200) {
      return json.decode(responseDetails.body);
    } else {
      throw Exception("Gagal ambil data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: getDetails(),
        builder: (index, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator(color: Colors.black);
          }

          if (snapshot.hasError) {
            print("snapshot error");
          }
          {
            final data = snapshot.data;
            final String nama_barang = data['nama_barang'].toString();
            final String harga_barang = data['harga'].toString();
            final List size = data['sizes'] as List;

            final urlPost = Uri.parse("http://172.20.10.5:8000/api/cart");
            postDatabuy() async {
              if (selectedSize!.isEmpty) {
                return ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Pilih Size Terlebih Dahulu")),
                );
              }
              var responsePost = await http.post(
                urlPost,
                headers: {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                },
                body: jsonEncode({
                  "id_user": 1,
                  "id_barang": data['id'],
                  "size": selectedSize,
                  "jumlah": 1,
                }),
              );
              if (responsePost.statusCode == 200) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const CartPage(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Barang telah ditambahkan ke keranjang"),
                  ),
                );
              } else {
                print("STATUS: ${responsePost.statusCode}");
                print("BODY: ${responsePost.body}");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Gagal menambahkan data")),
                );
              }
            }

            postDatacart() async {
              if (selectedSize!.isEmpty) {
                return ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Pilih Size Terlebih Dahulu")),
                );
              }
              var responsePost = await http.post(
                urlPost,
                headers: {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                },
                body: jsonEncode({
                  "id_user": 1,
                  "id_barang": data['id'],
                  "size": selectedSize,
                  "jumlah": 1,
                }),
              );
              if (responsePost.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Barang telah ditambahkan ke keranjang"),
                  ),
                );
              } else {
                print(responsePost.statusCode);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Gagal menambahkan data")),
                );
              }
            }

            // final List<String> sizeList = size
            //     .map((e) => e['size'].toString())
            //     .toList();

            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index)  {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 26),
                      Image.network(
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image)
                        ,
                        data['url_gambar'],
                      ),
                      SizedBox(height: 46),
                      Row(
                        children: [
                          SizedBox(width: 27),
                          Text(
                            nama_barang,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 27),
                          Text(
                            "Rp.$harga_barang",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),

                      SizedBox(height: 27),
                      Row(
                        children: [
                          SizedBox(width: 27),
                          Text(
                            "Size",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          SizedBox(width: 27),
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: size.map((item) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      selectedSize == item['size'].toString()
                                      ? const Color.fromARGB(255, 237, 237, 237)
                                      : Colors.white,
                                  elevation: 4,
                                  foregroundColor: Color.fromRGBO(
                                    39,
                                    39,
                                    39,
                                    1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      16,
                                    ),
                                  ),
                                  minimumSize: Size(50, 50),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedSize = item['size'].toString();
                                  });
                                },
                                child: Text(item['size']),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 91),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(235, 235, 235, 1),
                              foregroundColor: Color.fromRGBO(39, 39, 39, 1),
                              minimumSize: Size(57, 57),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(12),
                              ),
                              elevation: 4,
                            ),
                            onPressed: () {
                              postDatacart();
                            },
                            child: Icon(Icons.shopping_cart),
                          ),

                          SizedBox(width: 23),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(228, 57),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(16),
                              ),
                              backgroundColor: Color.fromRGBO(39, 39, 39, 1),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              postDatabuy();
                            },
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
