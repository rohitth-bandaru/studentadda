import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentadda/services/dataService.dart';
import 'package:studentadda/services/locationService.dart';
import 'package:studentadda/views/homeScreen/roomCard.dart';

import 'customAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ref = FirebaseFirestore.instance.collection('rooms').snapshots();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: CustomAppBar(image: user.photoURL!, name: user.displayName!),
      body: Consumer<LocationService>(
        builder: (context, locationService, _) => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Find your Sweet Home',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         builder: (context) {
                    //           return Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: <Widget>[
                    //               ListTile(
                    //                 leading:
                    //                     new Icon(Icons.arrow_upward_rounded),
                    //                 title: new Text('Sort by Price Ascending'),
                    //                 onTap: () {
                    //                   locationService.setSortChoice(true);
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //               ListTile(
                    //                 leading:
                    //                     new Icon(Icons.arrow_downward_rounded),
                    //                 title: new Text('Sort by Price Descending'),
                    //                 onTap: () {
                    //                   locationService.setSortChoice(false);
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //             ],
                    //           );
                    //         });
                    //   },
                    //   icon: Icon(Icons.sort),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          locationService.setChoice(0);
                        },
                        child: Container(
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(
                              color: locationService.choice == 0
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.05),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 15),
                                  blurRadius: 27,
                                  color: Colors.black.withOpacity(0.05),
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('All'),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          locationService.setChoice(1);
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: locationService.choice == 1
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.05),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 15),
                                  blurRadius: 27,
                                  color: Colors.black.withOpacity(0.05),
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Apartment'),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          locationService.setChoice(2);
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: locationService.choice == 2
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.05),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 15),
                                  blurRadius: 27,
                                  color: Colors.black.withOpacity(0.05),
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Hostel'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: StreamBuilder(
                  stream: DataService().getLocationBasedData(
                    locationService.location,
                    locationService.choice,
                  ),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something\'s Wrong'));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.data == null) {
                      return Center(
                        child: Text('No Rooms available for your selection'),
                      );
                    } else if (snapshot.requireData.size == 0) {
                      return Center(
                        child: Text('No Rooms available for your selection'),
                      );
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return RoomCard(data: data.docs[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
