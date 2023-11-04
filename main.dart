import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

String url = "https://jsonplaceholder.typicode.com/posts/1";
Future<Post> fetchPost() async {
 final response = await http.get(Uri.parse(url));
 if (response.statusCode == 200) {
   return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Gagal memuat post');
  }
}

class Post {
  final int userId;
  final int id; //variable id, untuk menampung id
  final String title;
  final String body;

  Post({
    required this.userId, //this, untuk memanggil variable atasnya
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId:
          json['userId'] ?? 0, //ditulis json, karena dulunya export dri json
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
   // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // Mengambil satu post saat widget dibuat
  final Future<Post> post = fetchPost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post dari API'),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            // Memeriksa status koneksi dari Future
          if (snapshot.connectionState == ConnectionState.waiting) {
              // Menampilkan indikator loading saat menunggu data
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Menampilkan pesan error jika terjadi kesalahan
              return Text('Error: ${snapshot.error}');
            } else {
              // Menampilkan judul dari post yang diambil
              return Text('Judul: ${snapshot.data!.title}');
            }
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// void main() => runApp(const MyApp());

// Future<List<Post>> fetchPosts() async {
//  final response =
//      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//  if (response.statusCode == 200) {
//    List<dynamic> body = json.decode(response.body);
 //   List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
//    return posts;
//  } else {
//    throw Exception('Failed to load posts');
//  }
// }

// class Post {
//  final int userId;
//  final int id;
//  final String title;
//  final String body;

//  Post(
//      {required this.userId,
//      required this.id,
//      required this.title,
//      required this.body});

//  factory Post.fromJson(Map<String, dynamic> json) {
//    return Post(
//      userId: json['userId'] ?? 0,
//      id: json['id'] ?? 0,
//      title: json['title'] ?? '',
//      body: json['body'] ?? '',
//    );
//  }
// }

// class MyApp extends StatelessWidget {
//  const MyApp({super.key});

//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(),
//    );
//  }
// }

//  class MyHomePage extends StatelessWidget {
//   final Future<List<Post>> posts = fetchPosts();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Get API'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Post>>(
//           future: posts,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(snapshot.data![index].title),
//                     subtitle: Text(snapshot.data![index].body),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// void main() => runApp(const MyApp());

// // URL untuk mengambil data dari API
// String url = "https://jsonplaceholder.typicode.com/posts";

// // Model Post
// class Post {
//   final int userId;
//   final int id;
//   final String title;
//   final String body;

//   // Konstruktor untuk menginisialisasi data
//   Post(
//       {required this.userId,
//       required this.id,
//       required this.title,
//       required this.body});

//   // Factory method untuk memetakan data JSON ke objek Post
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'] ?? 0,
//       id: json['id'] ?? 0,
//       title: json['title'] ?? '',
//       body: json['body'] ?? '',
//     );
//   }
// }

// // Future untuk mengambil data dari API
// Future<List<Post>> fetchPosts() async {
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     List<dynamic> body = json.decode(response.body);
//     List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
//     return posts;
//   } else {
//     throw Exception('Failed to load posts');
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'List of Posts'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final Future<List<Post>> posts = fetchPosts();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Post>>(
//           future: posts,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               // Memuat data dari API dan menampilkan dalam ListView
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(snapshot.data![index].title),
//                       subtitle: Text(snapshot.data![index].body),
//                     ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               // Menampilkan pesan jika terjadi error
//               return Text("${snapshot.error}");
//             }

//             // Menampilkan indikator loading saat menunggu data
//             return const CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "FORM",
//       home: GetDataTodos(),
//     );
//   }
// }

// Future<List<Todo>> fetchTodos() async {
//   final response = await http
//       .get(Uri.parse('https://calm-plum-jaguar-tutu.cyclic.app/todos'));
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     if (data.containsKey('data')) {
//       List<dynamic> todosData = data['data'];
//       List<Todo> todos = todosData
//           .map((item) => Todo.fromJson(item as Map<String, dynamic>))
//           .toList();
//       return todos;
//     }
//   }
//   throw Exception('Failed to load Todos');
// }

// class Todo {
//   final String todoName;
//   final bool isComplete;

//   Todo({
//     required this.todoName,
//     required this.isComplete,
//   });

//   factory Todo.fromJson(Map<String, dynamic> json) {
//     return Todo(
//       todoName: json['todoName'] ?? '',
//       isComplete: json['isComplete'] ?? false,
//     );
//   }
// }

// class GetDataTodos extends StatelessWidget {

//   final Future<List<Todo>> Todos = fetchTodos();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todos from API'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Todo>>(
//           future: Todos,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               TodoDetailPage(todo: snapshot.data![index]),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       elevation: 5, // Add elevation for the shadow
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               snapshot.data![index].todoName,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 23,
//                               ),
//                             ),
//                             Text(
//                               'Is Complete: ${snapshot.data![index].isComplete}',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Text('No data available.');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class TodoDetailPage extends StatelessWidget {
//   final Todo todo;

//   const TodoDetailPage({required this.todo});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo Details'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               todo.todoName,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w900,
//                 fontSize: 23,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Is Complete: ${todo.isComplete}',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
