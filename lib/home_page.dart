import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:test_lamp/ui_helper.dart';

class HomeView extends StatefulWidget {
  String user;
  String pass;
  String vhost;
  String host;
  HomeView({this.user, this.pass, this.vhost, this.host,});
  
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Client client;
  RMQService rmqService = new RMQService();
  String status_allLamp = "OFF";
  String status_lamp1="OFF";
  String status_lamp2 = "OFF";
  String status_lamp3 = "OFF";
  String status_lamp4 = "OFF";
  String values = "0000";
  bool check_status = false;
  bool allLamp = true;
  bool lamp1 = false;
  bool lamp2 = false;
  bool lamp3 = false;
  bool lamp4 = false;



  @override
  void initState(){
    super.initState();
    connect();
    LampuSemua(false);
    // setState(() {
    //   lamp1 = false;
    //   lamp2 = false;
    //   lamp3 = false;
    //   lamp4 = false;
    //   if(allLamp = false){
    //     values = "0000";
    //     lamp1 = allLamp;
    //     lamp2 = allLamp;
    //     lamp3 = allLamp;
    //     lamp4 = allLamp;
    //   }
    //
    // });
  }


  void connect() {
    try {
      client = rmqService.dataConnect(
        widget.user, widget.pass, widget.vhost, widget.host
      );
      // client.channel().then((Channel channel){
      //   return channel.queue("Sensor", durable: true);
      // }).then((Queue queue){
      //   queue.publish("Succes");
      // } );xx
      client.connect().then((value) {
        setState(() {
          check_status = true;
        });
      });
    } catch (e) {
      print("kesalahan 344or $e");
    }
  }

  void replaceCharAt( int index,String newChar){
    values =values.substring(0, index) + newChar + values.substring(index + 1);
    print(values);
  }

  void LampuSemua(bool status){
    if(status){
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#0000",client);
    }else{
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#1111",client);
    }
    allLamp = status;
  }
  void lampu1(bool status){
    if(status){
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }else{
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }
    lamp1 = status;
  }

  void lampu2(bool status){
    if(status){
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }else{
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }
    lamp2 = status;
  }

  void lampu3(bool status){
    if(status){
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }else{
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }
    lamp3 = status;
  }

  void lampu4(bool status){
    if(status){
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }else{
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#$values",client);
      print(values);
    }
    lamp4 = status;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Testing Lamp Home Automation"),
        ),
        backgroundColor: Color(0xffF1F4F6),
        body: SingleChildScrollView(
          child:Center (
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Container(
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: InkWell(
                          onTap : (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LampView(context)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              verticalSpaceMedium,
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child:Icon(FontAwesomeIcons.lightbulb,color: Colors.blue,),
                              ),
                              verticalSpaceMedium,
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "All Lamp",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "$status_allLamp",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(color: Colors.grey, fontSize: 10.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 7,bottom: 15,top: 10),
                                child:  InkWell(
                                  splashColor: Colors.white,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.decelerate,

                                    width: 50,
                                    decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(color: Color(0xff0079E2)),
                                      color: allLamp ? Color(0xff0079E2) : Color(0xFFFFFFFF),
                                    ),
                                    child: AnimatedAlign(
                                      duration: const Duration(milliseconds: 300),
                                      alignment:
                                      allLamp ? Alignment.centerRight : Alignment.centerLeft,
                                      curve: Curves.decelerate,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: allLamp ? Color(0xFFFFFFFF):Color(0xff0079E2),
                                            borderRadius: BorderRadius.circular(100.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      print("semua lampu");
                                      allLamp = !allLamp;
                                      allLamp ? status_allLamp = "ON":status_allLamp = "OFF";
                                      LampuSemua(allLamp);
                                      // onChanged(front);
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget LampView(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffF1F4F6),
      appBar: AppBar(
        title: Text("Daftar Lampu"),
      ),
      body: SingleChildScrollView(
        child:Center (
          child: Column(
            children: <Widget>[
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Container(
                    width: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child:Icon(FontAwesomeIcons.lightbulb,color: Colors.blue,),
                          ),
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Lampu 1",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "$status_lamp1",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.grey, fontSize: 10.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7,bottom: 15,top: 10),
                            child:  InkWell(
                              splashColor: Colors.white,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.decelerate,

                                width: 50,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Color(0xff0079E2)),
                                  color: lamp1 ? Color(0xff0079E2) : Color(0xFFFFFFFF),
                                ),
                                child: AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  alignment:
                                  lamp1 ? Alignment.centerRight : Alignment.centerLeft,
                                  curve: Curves.decelerate,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: lamp1 ? Color(0xFFFFFFFF):Color(0xff0079E2),
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  print("dsds");
                                  lamp1 = !lamp1;
                                  lamp1 ? status_lamp1 = "ON":status_lamp1 = "OFF";
                                  if(lamp1){
                                    replaceCharAt( 0, "0");
                                    lampu1(lamp1);
                                  }else{
                                    replaceCharAt( 0,"1");
                                    lampu1(lamp1);
                                  }
                                  // model.lampu1(front);
                                  // onChanged(front);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ),
                  Expanded(child:Container(
                    width: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child:Icon(FontAwesomeIcons.lightbulb,color: Colors.blue,),
                          ),
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Lampu 2",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "$status_lamp2",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.grey, fontSize: 10.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7,bottom: 15,top: 10),
                            child: InkWell(
                              splashColor: Colors.white,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.decelerate,

                                width: 50,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Color(0xff0079E2)),
                                  color: lamp2 ? Color(0xff0079E2) : Color(0xFFFFFFFF),
                                ),
                                child: AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  alignment:
                                  lamp2 ? Alignment.centerRight : Alignment.centerLeft,
                                  curve: Curves.decelerate,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: lamp2 ? Color(0xFFFFFFFF):Color(0xff0079E2),
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  print("dsds");
                                  lamp2 = !lamp2;
                                  lamp2 ? status_lamp2 = "ON":status_lamp2 = "OFF";
                                  if(lamp2){
                                    replaceCharAt( 1,"0");
                                    lampu2(lamp2);
                                  }else{
                                    replaceCharAt( 1,"1");
                                    lampu2(lamp2);
                                  }
                                  // model.lampu2(front2);
                                  // onChanged(front);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),),
                  Expanded(child:Container(
                    width: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child:Icon(FontAwesomeIcons.lightbulb,color: Colors.blue,),
                          ),
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Lampu 3",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "$status_lamp3",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.grey, fontSize: 10.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7,bottom: 15,top: 10),
                            child: InkWell(
                              splashColor: Colors.white,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.decelerate,

                                width: 50,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Color(0xff0079E2)),
                                  color: lamp3 ? Color(0xff0079E2) : Color(0xFFFFFFFF),
                                ),
                                child: AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  alignment:
                                  lamp3 ? Alignment.centerRight : Alignment.centerLeft,
                                  curve: Curves.decelerate,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: lamp3 ? Color(0xFFFFFFFF):Color(0xff0079E2),
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  print("dsds");
                                  lamp3 = !lamp3;
                                  lamp3 ? status_lamp3 = "ON":status_lamp3 = "OFF";
                                  if(lamp3){
                                    replaceCharAt( 2, "0");
                                    lampu3(lamp3);
                                  }else{
                                    replaceCharAt( 2, "1");
                                    lampu3(lamp3);
                                  }
                                  // model.lampu2(front3);
                                  // onChanged(front);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 118,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child:Icon(FontAwesomeIcons.lightbulb,color: Colors.blue,),
                          ),
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Lampu 4",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "$status_lamp4",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: Colors.grey, fontSize: 10.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7,bottom: 15,top: 10),
                            child:  InkWell(
                              splashColor: Colors.white,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.decelerate,

                                width: 50,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Color(0xff0079E2)),
                                  color: lamp4 ? Color(0xff0079E2) : Color(0xFFFFFFFF),
                                ),
                                child: AnimatedAlign(
                                  duration: const Duration(milliseconds: 300),
                                  alignment:
                                  lamp4 ? Alignment.centerRight : Alignment.centerLeft,
                                  curve: Curves.decelerate,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: lamp4 ? Color(0xFFFFFFFF):Color(0xff0079E2),
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  print("dsds");
                                  lamp4 = !lamp4;
                                  lamp4 ? status_lamp4 = "ON":status_lamp4 = "OFF";
                                  if(lamp4){
                                    replaceCharAt( 3, "0");
                                    lampu4(lamp4);
                                  }else{
                                    replaceCharAt( 3,"1");
                                    lampu4(lamp4);
                                  }
                                  // model.lampu1(front);
                                  // onChanged(front);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RMQService {
  final String userQueue = "homeauto";
  final String passQueue = "homeauto12345!";
  final String vHostQueue = "/Homeauto";
  final String hostQueue = "192.168.4.174";
  final String queues = "Sensor";
  Client dataConnect(String user,String pass,String vHost,String host){
    ConnectionSettings settings = new ConnectionSettings(
      host: host,
      authProvider: new PlainAuthenticator(user, pass),
      virtualHost: vHost,
    );
    Client client = new Client(settings: settings);
    return client;
  }
  void publish(String message,Client client) {
    // // ConnectionSettings settings = new ConnectionSettings(
    // //   host: hostQueue,
    // //   authProvider: new PlainAuthenticator(userQueue, passQueue),
    // //   virtualHost: vHostQueue,
    // );
    // Client client = new Client(settings: settings);
    print("Kirim Data!");
    client.channel().then((Channel channel) {
      return channel.queue(queues, durable: true);
    }).then((Queue queue) {
      queue.publish(message);
      client.close();
    });
  }
}



