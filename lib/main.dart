import 'package:flutter/material.dart';
import 'package:flutter_http_demo/offices.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<OfficesList> officesList;

  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Google offices"),
        ),
        body: Center(
          child: FutureBuilder<OfficesList>(
            future: officesList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.offices.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            "${snapshot.data.offices[index].name}",
                          ),
                          subtitle: Text(
                            "${snapshot.data.offices[index].address}",
                          ),
                          leading: Image.network(
                            "${snapshot.data.offices[index].image}",
                          ),
                          isThreeLine: true,
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('Error');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

/// Old methods
/// 
// Future<http.Response> getData() async {
//   // const url = Uri.https('https://about.google','/static/data/locations.json');
//   var url =
//       Uri.https('about.google', '/static/data/locations.json', {'q': '{http}'});
//   return await http.get(url);
// }
//
// void loadData() {
//   getData().then(
//     (response) {
//       if (response.statusCode == 200) {
//         print(response.body);
//       } else {
//         print(response.statusCode);
//       }
//     },
//   ).catchError((error) {
//     debugPrint(error.toString());
//   });
// }
