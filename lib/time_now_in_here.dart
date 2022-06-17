import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class TimeNow extends StatefulWidget {
  const TimeNow({Key? key}) : super(key: key);

  @override
  State<TimeNow> createState() => _TimeNowState();
}

class _TimeNowState extends State<TimeNow> {
  DateTime dt = DateTime.now();
  late String _timeString;
  late WeatherFactory wf;
  late Future<Weather> w;
  String _formatDateTime(DateTime dt) {
    return (dt.hour).toString() +
        ":" +
        dt.minute.toString() +
        ":" +
        dt.second.toString();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  Future<Weather> getCurrentWeatherInCairo(WeatherFactory wf) async {
    return await wf.currentWeatherByCityName("Cairo");
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    wf = WeatherFactory("1a0ae82160420c926a6ec032454e5639",
        language: Language.ENGLISH);
    w = getCurrentWeatherInCairo(wf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[900],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(50)),
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                      child: Text("Time",
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                  SizedBox(height: 10),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ], color: Colors.white, shape: BoxShape.circle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _timeString,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Container(
                  child: FutureBuilder<Weather>(
                future: w,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "weather",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    snapshot.data!.weatherDescription
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  )),
                            ],
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "temperature",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      snapshot.data!.temperature.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "wind speed",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      snapshot.data!.windSpeed.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    } else {
                      /* return Container(
                                child: Text(
                              "sad it's not working",
                              style: TextStyle(color: Colors.white),
                            ));*/
                      return Container(
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'windy but good',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            Text("wind speed: " + 355.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            Text(
                              "100 C",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        )),
                      );
                    }
                  } else {
                    return Container(
                        child: Text(
                      'loading',
                      style: TextStyle(color: Colors.black),
                    ));
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
