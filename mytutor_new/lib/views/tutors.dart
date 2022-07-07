import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/tutormodel.dart';
import 'package:http/http.dart' as http;

class TutorScreen extends StatefulWidget {
  const TutorScreen({ Key? key }) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  List <Tutor> TutorList = <Tutor> [];
  
  String titlecenter = "Loading...";

  late double screenHeight, screenWidth, resWidth;

  var numofpage, curpage = 1;
  var color;

  void initState() {
    super.initState();
    _loadTutors(1);
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
        title: const Text('Tutors Available'),
        actions: const [
        ],
      ),
      body: TutorList.isEmpty
          ? Center(
            child: Text(
              titlecenter, style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold
              )
            )
          )
          : Column(children: [
              /*Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),*/
              const SizedBox(height: 10),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(TutorList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {_loadTutorDetails(index)},
                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/tutors/" +
                                      TutorList[index].tutorId.toString() +
                                      '.jpg',
                                  //fit: BoxFit.cover,
                                  //width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Flexible(
                                  flex: 4,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          TutorList[index]
                                              .tutorName
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        /*const SizedBox(height: 5),
                                        Text(
                                          TutorList[index]
                                              .tutorEmail
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),*/
                                        const SizedBox(height: 5),
                                        Text(
                                          TutorList[index]
                                              .tutorPhone
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ))
                            ],
                          )),
                        );
                      }))),
              SizedBox(
                height: 35,
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
                              {_loadTutors(index + 1)},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
    );
  }

  void _loadTutors(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
      Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_tutors.php"),
      body: {
        'pageno': pageno.toString(),
      }
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
          'Error', 408);
        },
        ).then((response) {
          var jsondata = jsonDecode(response.body);

          print(jsondata);
          if (response.statusCode == 200 && jsondata['status'] == 'success') {
            var extractdata = jsondata['data'];
            numofpage = int.parse(jsondata['numofpage']);

            if (extractdata['tutors'] != null) {
              TutorList = <Tutor>[];
              extractdata['tutors'].forEach((v) {
                TutorList.add(Tutor.fromJson(v));
              });
              titlecenter = TutorList.length.toString() + " Tutors Available";             
            } else {
              titlecenter = "No Tutors Available";
              TutorList.clear();
            }
            setState(() {});
          } else {
            titlecenter = "No Tutors Available";
            TutorList.clear();
            setState(() {});
          }
        });
      }  

  _loadTutorDetails(int index) {}
}