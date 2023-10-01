import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FullBlog extends StatelessWidget {
  List _list = ['All', 'Merchant', 'Business', 'Tutorial','Economics','Stocks'];
  final String title;
  final String image_url;
  FullBlog({required this.title, required this.image_url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Blog and Articles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 0, 0, 0),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      var list = _list[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            height: 20,
                            child: Text(
                              list,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    image_url,
                    fit: BoxFit.cover,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          )),
    );
  }
}
