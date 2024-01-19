import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //reset function
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";

    setState(() {
      laps.add(lap);
    });
  }

//start timer function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 15, 48),
      body: /*Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 255, 0, 123), Color.fromARGB(255, 0, 0, 0)],
        ),
      ),*/
      Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://cdn.dribbble.com/users/925716/screenshots/3333720/attachments/722375/night.png'), // Replace with your image URL
          fit: BoxFit.cover,
        ),
      ),
      child : SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "StopWatch",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "$digitHours:$digitMinutes:$digitSeconds",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 82,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Color.fromARGB(101, 33, 0, 77),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 18, left: 21, right: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap ${index + 1}",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();

                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Color.fromARGB(255, 33, 0, 77),
                        width: 2),
                      ),
                      child: Text(
                        (!started) ? "Start" : "Pause",
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  ), //start btn
                  SizedBox(
                    width: 8,
                  ),

                  IconButton(
                    onPressed: () {
                      addLaps();

                    },
                    icon: Icon(
                      Icons.flag,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Color.fromARGB(255, 33, 0, 77),
                      shape: StadiumBorder(
                          //side: BorderSide(color: Colors.blue),
                          ),
                      child: Text(
                        "Reset",
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  ), //stop btn
                ],
              )
            ],
          ),
        ),
      ),
    ),
    );
  }
}
