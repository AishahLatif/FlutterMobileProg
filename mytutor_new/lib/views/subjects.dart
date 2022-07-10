import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import '../models/subjectmodel.dart';
import '../models/usermodel.dart';
import 'cartscreen.dart';

class SubjectScreen extends StatefulWidget {
  final User user;
  const SubjectScreen({ Key? key, required this.user, }) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Subject> SubjectList = <Subject>[];
  String titlecenter = "Loading...";
  TextEditingController searchController = TextEditingController();
  late double screenHeight, screenWidth, resWidth;
  String search = "";
  //String dropdownvalue = 'Programming 101';
  var numofpage, curpage = 1;
  var color;

  @override
  void initState() {
    super.initState();
    _loadSubjects(1, search);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
          TextButton.icon(
            icon: const Icon(Icons.shopping_cart_sharp,
            color: Colors.white,
            ),           
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder : (content) => CartScreen(user: widget.user))
              );
              _loadSubjects(1, search);
              _loadMyCart();
            },
              label: Text(widget.user.cart.toString(),
              style: const TextStyle(color: Colors.white)
              ),           
          ),
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
            const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Courses Available",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown)),
                ),
              const SizedBox(height: 10),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: (1 / 1),
                      children: List.generate(SubjectList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/courses/" +
                                      SubjectList[index].subjectId.toString() +
                                      '.jpg',
                                  //fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ), 
                              const SizedBox(height: 15),                        
                              Flexible(
                                  flex: 4,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          SubjectList[index]
                                              .subjectName
                                              .toString(),
                                              textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("RM " +
                                            double.parse(SubjectList[index]
                                                    .subjectPrice
                                                    .toString())
                                                .toStringAsFixed(2)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Spacer(),
                                        Text("Session: " +
                                          SubjectList[index]
                                              .subjectSession
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                              Expanded(child: IconButton(
                                          onPressed: () {
                                            _addtoCartDialog(index);
                                          }, 
                                          icon: const Icon(Icons.shopping_cart_sharp))),
                                        ]),
                                        Text("Rating: " +
                                          SubjectList[index]
                                              .subjectRating
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),                                     
                                      ]
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
                              {_loadSubjects(index + 1, search)},
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

  void _loadSubjects(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
      Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_subjects.php"),
      body: {
        'pageno' : pageno.toString(),
        'search' : _search,
      }
    ).then((response) {
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200 && jsondata['status'] == 'success') {
          var extractdata = jsondata['data'];
          numofpage = int.parse(jsondata['numofpage']);
          if (extractdata['subjects'] != null) {
            SubjectList = <Subject>[];
            extractdata['subjects'].forEach((v) {
              SubjectList.add(Subject.fromJson(v));
            });
            setState(() {});
          } else {
            titlecenter = "No Courses Available";
            setState(() {});
          }
        }
      }
    );
  }

  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  height: screenHeight / 6,
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search subject',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          search = searchController.text;
                          Navigator.of(context).pop();
                          _loadSubjects(1, search);
                        },
                        child: const Text("Search"),
                      )
                      //const SizedBox(height: 5),                      
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      "Close", style: TextStyle(),                      
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),                 
                ],
              );           

        });
  }

  void _addtoCartDialog(int index) {
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text("Add subject to Cart", style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes", style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                _addToCart(index);
              },
            ),
            TextButton(child: 
            const Text("No", style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addToCart(int index) {
    http.post(
      Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/insert_cart.php"),
      body: {
        "email": widget.user.email.toString(),
        "subid": SubjectList[index].subjectId.toString(),
      }
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
          'Error', 408
        );
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.user.cart = jsondata['data']['carttotal'].toString();
        });
        Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1, 
          fontSize: 16.0
        );
      }
    });
  }

  void _loadMyCart() {
    http.post(
      Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_mycartqty.php"),
      body: {
        "email": widget.user.email.toString(),
      }
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
          'Error', 408
        );
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.user.cart = jsondata['data']['carttotal'].toString();
        });
      }
    });
  }

}