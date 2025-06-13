import 'dart:convert';
import 'dart:ui';
import 'package:f_bloc/home/presentation/bloc/weather_bloc.dart';
import 'package:f_bloc/home/presentation/widgets/additional_info_widget.dart';
import 'package:f_bloc/home/presentation/widgets/hourly_forecast_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:f_bloc/core/api/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Forecast',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              /*setState(() {
                weather = getCurrentWeather();
              });*/
            },
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          /*if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (!state.hasData || state.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }*/
          if (state is WeatherFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is! WeatherSuccess) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = state.weatherModel;

          final cTemp = data.cTemp - 273.15; // Convert from Kelvin to Celsius
          final cSky = data.cSky;
          final cPressure = data;
          final cWindSpeed = data;
          final cHumidity = data.cHumidity;

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$cTemp °C',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                cSky == 'Clouds' || cSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.wb_sunny,
                                size: 64,
                              ),
                              const SizedBox(height: 16),
                              Text(cSky, style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                /*SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hForecast = data['list'][index + 1];
                      final hSky = hForecast['weather'][0]['main'];
                      final hTemp = (hForecast['main']['temp'] - 273.15)
                          .toString();
                      final hTime = DateTime.parse(hForecast['dt_txt']);
                      return HourlyForecastWidget(
                        time: DateFormat('h:mm a').format(hTime),
                        temperature: hTemp,
                        icon: hSky == 'Clouds' || hSky == 'Rain'
                            ? Icons.cloud
                            : Icons.wb_sunny,
                      );
                    },
                  ),
                ),*/
                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoWidget(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: cHumidity.toString(),
                    ),
                    AdditionalInfoWidget(
                      icon: Icons.water_drop,
                      label: 'Wind Speed',
                      value: cWindSpeed.toString(),
                    ),
                    AdditionalInfoWidget(
                      icon: Icons.water_drop,
                      label: 'Pressure',
                      value: cPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
