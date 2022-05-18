import 'package:flutter/material.dart';
import 'weather_app_icons.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
    const WeatherApp({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(fontFamily: 'SourceSansPro'),
            home: Scaffold(
                body: Column(
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                Container(
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                            Icon(Icons.menu),
                                            Icon(Icons.wb_sunny)
                                        ],
                                    ),
                                    width: 330,
                                    margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                                )
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                            Row(
                                                children: [
                                                    const Text(
                                                        'temperature',
                                                        style: TextStyle(
                                                            fontSize: 40,
                                                            fontWeight: FontWeight.w300,
                                                        ),
                                                    )
                                                ]
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Column(
                                                        children: [
                                                            const Text(
                                                                '28.0 °C',
                                                                style: TextStyle(
                                                                    fontSize: 26,
                                                                    fontWeight: FontWeight.w300,
                                                                ),
                                                            )
                                                        ]
                                                    ),
                                                    Column(children: [const Icon(WeatherAppIcons.thermometer_half)]),
                                                ],
                                            ),
                                        ],
                                    ),
                                    margin: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                                    padding: const EdgeInsets.all(20),
                                    height: 150,
                                    width: 332,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[350], 
                                                spreadRadius: 3,
                                                blurRadius: 10,
                                            )
                                        ]
                                    ),
                                ), 
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                            Row(
                                                children: [
                                                    const Text(
                                                        'humidity',
                                                        style: TextStyle(
                                                            fontSize: 40,
                                                            fontWeight: FontWeight.w300,
                                                        ),
                                                    )
                                                ]
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Column(
                                                        children: [
                                                            const Text(
                                                                '43%',
                                                                style: TextStyle(
                                                                    fontSize: 26,
                                                                    fontWeight: FontWeight.w300,
                                                                ),
                                                            )
                                                        ]
                                                    ),
                                                    Column(children: [const Icon(WeatherAppIcons.thermometer_half)]),
                                                ],
                                            ),
                                        ],
                                    ),
                                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 50),
                                    padding: const EdgeInsets.all(20),
                                    height: 150,
                                    width: 332,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[350], 
                                                spreadRadius: 3,
                                                blurRadius: 10,
                                            )
                                        ]
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                            Row(
                                                children: [
                                                    const Text(
                                                        'heat index',
                                                        style: TextStyle(
                                                            fontSize: 40,
                                                            fontWeight: FontWeight.w300,
                                                        ),
                                                    )
                                                ]
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Column(
                                                        children: [
                                                            const Text(
                                                                '27.9 °C',
                                                                style: TextStyle(
                                                                    fontSize: 26,
                                                                    fontWeight: FontWeight.w300,
                                                                ),
                                                            )
                                                        ]
                                                    ),
                                                    Column(children: [const Icon(WeatherAppIcons.thermometer_sun)]),
                                                ],
                                            ),
                                        ],
                                    ),
                                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 50),
                                    padding: const EdgeInsets.all(20),
                                    height: 150,
                                    width: 332,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[350], 
                                                spreadRadius: 3,
                                                blurRadius: 10,
                                            )
                                        ]
                                    ),
                                ),
                            ],
                        ),
                    ],
                ),
            )
        );
    }
}
