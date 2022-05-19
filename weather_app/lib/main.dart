import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'weather_app_icons.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
    runApp(const WeatherApp());

    WeatherService reading = WeatherService();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: DefaultFirebaseOptions.firebaseUser, 
        password: DefaultFirebaseOptions.firebasePassword
    );

    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099).onError((error, stackTrace) => print(error));
    DatabaseReference ref = FirebaseDatabase.instance.ref('firemqtt');
    ref.orderByKey().limitToLast(1).onChildAdded.listen((DatabaseEvent event) { 
        Map<String, dynamic>.from(event.snapshot.value as dynamic).forEach((key, value) => {
            if(key == 'temperature')
                reading.temperature = value
            else if (key == 'humidity')
                reading._humidity = value
            else if (key == 'heat_index')
                reading.heat_index = value
        });
        //print(reading.temperature);
    });
}

class WeatherService {
    static final WeatherService _instance = WeatherService._internal();

    factory WeatherService() => _instance;
    
    WeatherService._internal() {
        String _temperature = 'waiting for data...';
        String _humidity = 'waiting for data...';
        String _heat_index = 'waiting for data...';
    }

    String? _temperature;
    String? _humidity;
    String? _heat_index;

    String? get temperature => _temperature;
    String? get humidity => _humidity;
    String? get heat_index => _heat_index;

    set temperature(String? value) => _temperature = value;
    set humidity(String? value) => _humidity = value;
    set heat_index(String? value) => _heat_index = value;
}

class WeatherApp extends StatelessWidget {
    const WeatherApp({Key? key}) : super(key: key);


    @override
    Widget build(BuildContext context) {
        WeatherService reading = WeatherService();

        const Color nicePurpleBro = Color.fromRGBO(112, 112, 255, 1);
        const Color grey70 = Color.fromRGBO(78, 78, 78, 1);

        const Color cardColor = Color.fromRGBO(255, 255, 255, 1);
        const EdgeInsetsGeometry cardMargin = EdgeInsets.fromLTRB(30, 0, 30, 30);
        const EdgeInsetsGeometry cardPadding = EdgeInsets.all(25);
        const double cardWidth = 332;
        const double cardHeight = 165;
        const double cardBorderRadius = 25;
        const BoxShadow cardBoxShadow = BoxShadow(
                                                color: Color.fromRGBO(247, 247, 249, 1), 
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                offset: Offset(0, 5)
                                            );

        const double cardHeaderFontSize = 30;
        const Color cardHeaderFontColor = grey70;

        const double cardDataFontSize = 40;
        const FontWeight cardDataFontWeight = FontWeight.w600;

        const double cardIconFontSize = 60;
        //const Color cardIconColor = nicePurpleBro;
        const Color cardIconColor = Color.fromARGB(255, 163, 156, 244);

        return MaterialApp(
            theme: ThemeData(
                textTheme: Theme.of(context).textTheme.apply(
                    //fontFamily: 'SourceSansPro',
                    //fontFamily: GoogleFonts.didactGothic(fontWeight: FontWeight.w400).fontFamily,
                    fontFamily: GoogleFonts.lexendDeca(fontWeight: FontWeight.w300).fontFamily,
                    //fontFamily: GoogleFonts.alata(fontWeight: FontWeight.w200).fontFamily,
                    bodyColor: nicePurpleBro,
                    displayColor: const Color.fromRGBO(0, 0, 0, 1)
                )
            ),
            home: Scaffold(
                backgroundColor: const Color.fromRGBO(242, 252, 255, 1),
                body: Column(
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                Container(
                                    width: 330,
                                    margin: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const <Widget>[
                                            Icon(
                                                Icons.menu,
                                                color: grey70,
                                            ),
                                            Icon(
                                                Icons.wb_sunny,
                                                color: grey70,
                                            )
                                        ],
                                    ),
                                )
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Container(
                                    margin: cardMargin,
                                    padding: cardPadding,
                                    height: cardHeight,
                                    width: cardWidth,
                                    decoration: BoxDecoration(
                                        color: cardColor,
                                        borderRadius: BorderRadius.circular(cardBorderRadius),
                                        boxShadow: const [cardBoxShadow]
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                            Row(
                                                children: const [
                                                    Text(
                                                        'temperature',
                                                        style: TextStyle(
                                                            color: cardHeaderFontColor,
                                                            fontSize: cardHeaderFontSize,
                                                            fontWeight: FontWeight.w300,
                                                        ),
                                                    )
                                                ]
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Column(
                                                        children: const [
                                                            Text(
                                                                '28.0 °C',
                                                                style: TextStyle(
                                                                    fontSize: cardDataFontSize,
                                                                    fontWeight: cardDataFontWeight,
                                                                ),
                                                            )
                                                        ]
                                                    ),
                                                    Column(
                                                        children: const [
                                                            Icon(
                                                                WeatherAppIcons.thermometer_half,
                                                                size: cardIconFontSize,
                                                                color: cardIconColor
                                                            )
                                                        ]
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ), 
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Container(
                                    margin: cardMargin,
                                    padding: cardPadding,
                                    height: cardHeight,
                                    width: cardWidth,
                                    decoration: BoxDecoration(
                                        color: cardColor,
                                        borderRadius: BorderRadius.circular(cardBorderRadius),
                                        boxShadow: const [cardBoxShadow]
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                            Row(
                                                children: const [
                                                    Text(
                                                        'humidity',
                                                        style: TextStyle(
                                                            color: cardHeaderFontColor,
                                                            fontSize: cardHeaderFontSize,
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
                                                            Text(
                                                                '${reading.humidity}',
                                                                style: const TextStyle(
                                                                    fontSize: cardDataFontSize,
                                                                    fontWeight: cardDataFontWeight,
                                                                ),
                                                            )
                                                        ]
                                                    ),
                                                    Column(
                                                        children: const [
                                                            Icon(
                                                                WeatherAppIcons.moisture,
                                                                size: cardIconFontSize,
                                                                color: cardIconColor
                                                            )
                                                        ]
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Container(
                                    margin: cardMargin,
                                    padding: cardPadding,
                                    height: cardHeight,
                                    width: cardWidth,
                                    decoration: BoxDecoration(
                                        color: cardColor,
                                        borderRadius: BorderRadius.circular(cardBorderRadius),
                                        boxShadow: const [cardBoxShadow]
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                            Row(
                                                children: const [
                                                    Text(
                                                        'heat index',
                                                        style: TextStyle(
                                                            color: cardHeaderFontColor,
                                                            fontSize: cardHeaderFontSize,
                                                            fontWeight: FontWeight.w300,
                                                        ),
                                                    )
                                                ]
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Column(
                                                        children: const [
                                                            Text(
                                                                '27.9 °C',
                                                                style: TextStyle(
                                                                    fontSize: cardDataFontSize,
                                                                    fontWeight: cardDataFontWeight,
                                                                ),
                                                            )
                                                        ]
                                                    ),
                                                    Column(
                                                        children: const [
                                                            Icon(
                                                                WeatherAppIcons.thermometer_sun,
                                                                size: cardIconFontSize,
                                                                color: cardIconColor
                                                            )
                                                        ]
                                                    ),
                                                ],
                                            ),
                                        ],
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
