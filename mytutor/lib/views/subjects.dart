import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/subject.dart';

class Subject extends StatefulWidget {
  const Subject({Key? key}) : super(key: key);

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  List<Subject> SubjectList = <Subject>[];

  String titlecenter = "Loading...";

  late double screenHeight, screenWidth, resWidth;

  var _tapPosition;
  var numofpage, curpage = 1;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  var color;

  void initState() {
    super.initState();
    _loadSubjects(1,"","All");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Product'),
        actions: const [
          /*IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          )*/
        ],
      ),
      body: SubjectList.isEmpty
          ? Center(
            child: Text(
              titlecenter, style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold
              )
            )
          )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: types.map((String char) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: ElevatedButton(
                        child: Text(char),
                        onPressed: () {
                          _loadSubjects(1, "", char);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),*/
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(SubjectList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {_loadSubjectDetails(index)},
                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/assets/course/" +
                                      SubjectList[index].subjectId.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Text(
                                        SubjectList[index]
                                            .subjectName
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("RM " +
                                          double.parse(SubjectList[index]
                                                  .subjectPrice
                                                  .toString())
                                              .toStringAsFixed(2)),
                                      Text(SubjectList[index]
                                              .subjectQty
                                              .toString() +
                                          " units"),
                                      Text(SubjectList[index]
                                          .subjectStatus
                                          .toString()),
                                    ],
                                  ))
                            ],
                          )),
                        );
                      }))),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () =>
                              {_loadSubjects(index + 1, "", "All")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
      /*floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: "New Product",
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (content) => const NewProduct()));
          _loadSubjects(1, '', "All");
        },
      ),*/
    );
  }

  void _loadSubjects(int i, String s, String char) {
    //curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_products.php"),
        body: {
          //'pageno': pageno.toString(),
          //'search': _search,
          //'type': _type,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);

      // ignore: avoid_print
      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['products'] != null) {
          SubjectList = <Subject>[];
          extractdata['products'].forEach((v) {
            SubjectList.add(Subject.fromJson(v));
          });
          titlecenter = SubjectList.length.toString() + " Products Available";
        } else {
          titlecenter = "No Product Available";
          SubjectList.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Product Available";
        SubjectList.clear();
        setState(() {});
      }
    });
  }

  _loadSubjectDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Product Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/slumshop/assets/products/" +
                      SubjectList[index].subjectId.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  SubjectList[index].subjectName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Product Description: \n" +
                      SubjectList[index].subjectDesc.toString()),
                  Text("Price: RM " +
                      double.parse(SubjectList[index].subjectPrice.toString())
                          .toStringAsFixed(2)),
                  Text("Quantity Available: " +
                      SubjectList[index].subjectQty.toString() +
                      " units"),
                  Text("Product Status: " +
                      SubjectList[index].subjectStatus.toString()),
                  Text("Product Date: " +
                      df.format(DateTime.parse(
                          SubjectList[index].subjectDate.toString()))),
                ])
              ],
            )),
            actions: [
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}