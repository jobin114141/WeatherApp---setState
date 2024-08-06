import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myweatherapp/model/weatherModel.dart';
import 'package:myweatherapp/services/RemoteServices.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final currentDate = DateTime.now();
  List<WhetherDetails> weatherDetailsList = [];
  double? currentTemperature;
  double? currentwind;
  int? currentHumidit;
  int? currentPressure;
  String? Corrrectweather;
  List<WhetherDetails> CurrentWeatherElement = [];
  String? weatherDescription;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  void getDetails() async {
    weatherDetailsList = (await Remoteservices().getWhetherDetails())!;
    final now = DateTime.now();
    final today =
        DateTime(now.year, now.month, now.day); //current date in today
    for (var detail in weatherDetailsList) {
      print(detail); // This will use the overridden toString method
      print("+++++");
    }
    var currentDayData = weatherDetailsList.where((details) {
      final date = details.dtTxt;

      if (date != null) {
        final dataDate = DateTime(date.year, date.month,
            date.day); //data um data de date um oronn ayi verum ivede
        return dataDate == today;
      }
      return false;
    }).toList();

    if (currentDayData.isNotEmpty) {
      setState(() {
        currentTemperature = (currentDayData[0].main?.temp ?? 0.0) - 273.15;
        currentwind = currentDayData[0].wind?.speed;
        currentHumidit = currentDayData[0].main?.humidity;
        currentPressure = currentDayData[0].main?.pressure;
        Corrrectweather = currentDayData[0].weather?.first.main;
        weatherDescription = currentDayData[0].weather?.first.description;
      });
    }
  }

  Widget getWeatherImage(String weatherCondition) {
    switch (weatherCondition) {
      case "Rain":
        return Image.network(
          "https://mir-s3-cdn-cf.behance.net/project_modules/disp/bee3d654827733.596dc6164dec2.gif",
          fit: BoxFit.cover,
        );
      case "Clouds":
        return Image.network(
            "https://www.icegif.com/wp-content/uploads/2023/08/icegif-886.gif");
      case "Clear":
        return Image.network(
            "https://cdn.dribbble.com/users/261567/screenshots/1099769/media/dc312e3c221f0d241ba081535d826eb3.gif");
      default:
        return Image.network(
            "https://cdn.dribbble.com/users/887568/screenshots/20566567/media/f5145a47dd78e5c259741a4e2c7d3124.gif"); // Fallback image
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(208, 46, 46, 46),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.compass_calibration,
                    color: Colors.white,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.compare_arrows_sharp,
                    color: Colors.white,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.compress_sharp,
                    color: Colors.white,
                  ),
                  label: "")
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.60,
                    child: getWeatherImage(Corrrectweather!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 30),
                  child: Row(
                    children: [
                      Text(
                        "${currentDate.day}, ${DateFormat('MMMM').format(currentDate)},",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        " ${DateFormat('EEEE').format(currentDate)}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Text(
                            "${currentTemperature?.toStringAsFixed(1) ?? 'N/A'}°C",
                            style: TextStyle(
                                fontSize: 65,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          weatherDescription!.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: screenWidth * 0.15,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: screenWidth * 0.15,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Wind"), Text("${currentwind} Km/h")],
                    ),
                    height: screenHeight * 0.16,
                    width: screenWidth * 0.30,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                              Color.fromARGB(255, 122, 188, 241),
                              Color.fromARGB(255, 239, 201, 241)
                            ]),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Humidity"), Text("${currentHumidit}")],
                    ),
                    height: screenHeight * 0.16,
                    width: screenWidth * 0.30,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                              Color.fromARGB(255, 122, 188, 241),
                              Color.fromARGB(255, 239, 201, 241)
                            ]),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pressure"),
                        Text("${currentPressure}MB")
                      ],
                    ),
                    height: screenHeight * 0.16,
                    width: screenWidth * 0.30,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                              Color.fromARGB(255, 122, 188, 241),
                              Color.fromARGB(255, 239, 201, 241)
                            ]),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromARGB(208, 46, 46, 46),
                  ),
                  width: screenWidth,
                  height: screenHeight * 0.135,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              double temp =
                                  (weatherDetailsList[index].main!.temp!) -
                                      273.15;
                              DateTime? dateTime1 =
                                  weatherDetailsList[index].dtTxt;
                                  

                        
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: screenWidth * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                           dateTime1!.hour.toString(),
                                            style: TextStyle(color: Colors.white),
                                          ),Text(" : 00",style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Text(
                                          "${temp?.toStringAsFixed(1) ?? 'N/A'} °C",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
