import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sio_ecommerce_mobile/cart.dart';
import 'package:sio_ecommerce_mobile/details.dart';
import 'package:sio_ecommerce_mobile/login.dart';
import 'package:http/http.dart' as http;
import 'package:sio_ecommerce_mobile/profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final String url = 'http://172.20.10.5:8000/api/index';

  getIndexData() async {
    var responseIndex = await http.get(Uri.parse(url));

    if (responseIndex.statusCode == 200) {
      return json.decode(responseIndex.body);
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 24),
          SizedBox(
            width: 320,
            height: 60,
            child: Card(
              color: Color.fromRGBO(39, 39, 39, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 89,
                children: [
                  Icon(size: 29, color: Colors.white, Icons.notifications),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Icon(size: 29, color: Colors.white, Icons.person),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                    child: Icon(
                      size: 29,
                      color: Colors.white,
                      Icons.shopping_bag,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("510 Merch", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(builder: (context) => const LoginPage()),
            );
            print("tombol logout");
          },
          child: Icon(Icons.logout),
        ),
        backgroundColor: Colors.white,

        actions: [
          GestureDetector(
            onTap: () {
              print("tombol search");
            },
            child: Icon(Icons.search),
          ),

          SizedBox(width: 22),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 22),
        children: [
          Image.asset("assets/banner.png"),
          SizedBox(height: 29),
          SizedBox(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 2),
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    foregroundColor: Color.fromRGBO(39, 39, 39, 1),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text("T-SHIRT"),
                ),

                SizedBox(width: 9),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    foregroundColor: Color.fromRGBO(39, 39, 39, 1),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text("LONGSLEEVE"),
                ),

                SizedBox(width: 9),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    foregroundColor: Color.fromRGBO(39, 39, 39, 1),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text("HOODIE"),
                ),

                SizedBox(width: 9),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    foregroundColor: Color.fromRGBO(39, 39, 39, 1),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text("WORK JACKET"),
                ),
              ],
            ),
          ),
          SizedBox(height: 39),
          FutureBuilder(
            future: getIndexData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List data = snapshot.data as List;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 23,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => DetailsPage(id: item['id']),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 180,
                        height: 189,
                        child: Card(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          elevation: 6,
                          child: Column(
                            children: [
                              Image.network(

                                item['url_gambar'],

                                width: 132,
                                height: 132,
                              ),

                              Text(
                                item['nama_barang'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Rp ${item['harga']}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return LinearProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
