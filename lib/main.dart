import 'dart:convert';
import 'package:blog_app/fullblog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> blogs = [];
  void fetchBlogs() async {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      List<dynamic> blogsJson = json.decode(response.body)['blogs'];
      setState(() {
        blogs = blogsJson;
      });
    } else {
      print('Request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      title: Container(
          width: 200,
          color: Colors.white,
          child: Image.asset(
            'asset/images/logo.png',
          ),
        ),
        actions:const [
          Icon(
            Icons.menu,
            size: 40,color: Colors.white,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 0, 0, 0),
        child: 
        ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              var blog=blogs[index];
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                 
                  Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        blog['image_url'],
                        fit: BoxFit.cover,
                      )),
                  Spacer(),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      child: Text(
                        blog['title'],
                        style:const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FullBlog(title:blog['title'],image_url: blog['image_url'],)));
                    },
                  ),
                  Spacer()
                ]),
              );
            }),
      ),
    );
  }
}
