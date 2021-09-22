import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'devices_db.dart';
import 'rooms_db.dart';

Future<void> grp() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oreca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List newDevices = Devices_DATA;
  List devicesData = Devices_DATA;
  List roomsData = Rooms_DATA;
  List DevicesOfRooms = [];
  String DevicesOfRoomsStr;


  bool accepted = false;
  int devicesindex;
  int roomsindex;

  @override
  Widget build(BuildContext context) {
    final double iconSize = 35.0;
    final Size size = MediaQuery.of(context).size;
    final double roomsHeight = size.height * 0.4;



    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // const Color(0xFF2196F3),
              // const Color(0xFF382cb4),
              // const Color(0xFFC0C0C0),
              const Color(0xFFFFFFFF),
              const Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Center(
                child: Text(
                  'Devices Grouping',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            leading: RawMaterialButton(
              onPressed: () {},
              constraints: BoxConstraints.tight(Size(40, 40)),
              child: Icon(
                Icons.menu,
                size: 40,
                color: Colors.blue,
              ),
              shape: CircleBorder(),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10,top: 5),
                child: RawMaterialButton(
                  onPressed: () {},
                  constraints: BoxConstraints.tight(Size(40, 40)),
                  elevation: 5.0,
                  fillColor: Colors.blue,
                  child: Icon(
                    Icons.add_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  shape: CircleBorder(),
                ),
              ),
            ],
          ),
          body: Container(
            height: size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: roomsData.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, roomsindex) {
                        return SingleChildScrollView(
                          child: DragTarget(
                            builder: (context, data, rejectedData) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 150,
                                        height: roomsHeight,
                                        margin: EdgeInsets.only(right: 0),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: ExactAssetImage(
                                                  "assets/images/${roomsData[roomsindex]["image"]}"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.5),
                                                  BlendMode.darken),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                  Colors.black.withAlpha(100),
                                                  blurRadius: 10.0),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                roomsData[roomsindex]["name"],
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${roomsData[roomsindex]["NoOfDevices"]
                                                    .toString()} Devices',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                child: roomsData[roomsindex]["devices"] != null?
                                                Expanded(
                                                  child: ListView.builder(
                                                      itemCount: roomsData[roomsindex]["NoOfDevices"],
                                                      scrollDirection: Axis.vertical,
                                                      physics: BouncingScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        return SingleChildScrollView(
                                                          child: Draggable(
                                                            child: Icon(Icons.lightbulb,color: Colors.white,size: 45,),
                                                            feedback: Icon(Icons.lightbulb,color: Colors.white,size: 45,),
                                                            childWhenDragging: Container(),
                                                            onDragStarted: (){
                                                              devicesindex = index;
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                )
                                                    :Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            onWillAccept: (data){
                              return true;
                            },
                            onAccept: (data){
                              setState(() {
                                /** refresh List of devices and Rooms **/
                                accepted = true;

                                devicesData[devicesindex]["room"] = roomsData[roomsindex]["name"];

                                DevicesOfRoomsStr = roomsData[roomsindex]["devices"];
                                // print(DevicesOfRoomsStr);
                                DevicesOfRoomsStr = '$DevicesOfRoomsStr,${devicesData[devicesindex]["name"]}';
                                DevicesOfRoomsStr = DevicesOfRoomsStr.replaceAll('null', '');
                                DevicesOfRooms = DevicesOfRoomsStr.split(',');

                                // print(DevicesOfRoomsStr);
                                // print(DevicesOfRooms);
                                // print(DevicesOfRooms.length);
                                roomsData[roomsindex]["NoOfDevices"] = DevicesOfRooms.length - 1;
                                roomsData[roomsindex]["devices"] = DevicesOfRoomsStr;
                                // print(roomsData[roomsindex]["devices"]);


                                newDevices.removeAt(devicesindex);
                                DevicesOfRooms = [];

                                // print("---- .... ---- devicesindex= $devicesindex,roomsindex= $roomsindex");
                                // print(roomsData);
                              });
                            },
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: newDevices.length,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: LongPressDraggable(
                            child: Container(
                                height: 90,
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    // color: Colors.blue.shade400,
                                    gradient: LinearGradient(
                                      // center: const Alignment(0.7, -0.6),
                                      // radius: 0.2,
                                      colors: [
                                        const Color(0xFFFFFFFF),
                                        const Color(0xFFC0C0C0),
                                      ],
                                      // stops: [0.4, 1.0],
                                    ),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Text(
                                            newDevices[index]["name"],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              RawMaterialButton(
                                                onPressed: () {},
                                                constraints: BoxConstraints.tight(
                                                    Size(iconSize, iconSize)),
                                                elevation: 5.0,
                                                fillColor: Colors.white,
                                                child: Icon(
                                                  Icons.arrow_upward,
                                                  size: iconSize,
                                                ),
                                                shape: CircleBorder(),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              RawMaterialButton(
                                                onPressed: () {},
                                                constraints: BoxConstraints.tight(
                                                    Size(iconSize, iconSize)),
                                                elevation: 5.0,
                                                fillColor: Colors.white,
                                                child: Icon(
                                                  Icons.pause,
                                                  size: iconSize,
                                                ),
                                                shape: CircleBorder(),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              RawMaterialButton(
                                                onPressed: () {},
                                                constraints: BoxConstraints.tight(
                                                    Size(iconSize, iconSize)),
                                                elevation: 5.0,
                                                fillColor: Colors.white,
                                                child: Icon(
                                                  Icons.arrow_downward,
                                                  size: iconSize,
                                                ),
                                                shape: CircleBorder(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/images/${newDevices[index]["image"]}",
                                        height: double.infinity,
                                      )
                                    ],
                                  ),
                                )),
                            feedback: Container(
                                height: 90,
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    // color: Colors.blue.shade400,
                                    gradient: LinearGradient(
                                      // center: const Alignment(0.7, -0.6),
                                      // radius: 0.2,
                                      colors: [
                                        const Color(0xFFFFFFFF),
                                        const Color(0xFFC0C0C0),
                                      ],
                                      // stops: [0.4, 1.0],
                                    ),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                newDevices[index]["name"],
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  RawMaterialButton(
                                                    onPressed: () {},
                                                    constraints: BoxConstraints.tight(
                                                        Size(iconSize, iconSize)),
                                                    elevation: 5.0,
                                                    fillColor: Colors.white,
                                                    child: Icon(
                                                      Icons.arrow_upward,
                                                      size: iconSize,
                                                    ),
                                                    shape: CircleBorder(),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  RawMaterialButton(
                                                    onPressed: () {},
                                                    constraints: BoxConstraints.tight(
                                                        Size(iconSize, iconSize)),
                                                    elevation: 5.0,
                                                    fillColor: Colors.white,
                                                    child: Icon(
                                                      Icons.pause,
                                                      size: iconSize,
                                                    ),
                                                    shape: CircleBorder(),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  RawMaterialButton(
                                                    onPressed: () {},
                                                    constraints: BoxConstraints.tight(
                                                        Size(iconSize, iconSize)),
                                                    elevation: 5.0,
                                                    fillColor: Colors.white,
                                                    child: Icon(
                                                      Icons.arrow_downward,
                                                      size: iconSize,
                                                    ),
                                                    shape: CircleBorder(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/images/${newDevices[index]["image"]}",
                                            height: double.infinity,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            childWhenDragging: Icon(Icons.lightbulb,color: Colors.white,size: 45,),
                            onDragStarted: (){
                              devicesindex = index;
                            },
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void function(@required int index) {
    devicesindex = index;
  }

  @override
  void initState() {
    super.initState();
    // getPostsData();
    function;
    /** This is to Disappear Room Cards by scrolling **/
    // controller.addListener(() {
    //
    //   double value = controller.offset/119;
    //
    //   setState(() {
    //     topContainer = value;
    //     closeTopContainer = controller.offset > 50;
    //   });
    // });
  }
}