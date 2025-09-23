import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
            ),
          ),

          SizedBox(height: 32,),

          Center(
            child: SizedBox(
              height: 48,
              width: 290,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(16)
                  )
                ),
              ),
            ),
          ),

          SizedBox(height: 32,),

          Center(
            child: SizedBox(
              height: 48,
              width: 290,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(16)
                  )
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}