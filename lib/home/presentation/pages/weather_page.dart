import 'dart:ui';
import 'package:f_bloc/home/presentation/bloc/weather_bloc.dart';
import 'package:f_bloc/home/presentation/widgets/additional_info_widget.dart';
import 'package:f_bloc/home/presentation/widgets/hourly_forecast_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              setState(() {
                context.read<WeatherBloc>().add(WeatherFetched());
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is! WeatherSuccess) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final data = state.weatherModel;
            final cTemp = (data.cTemp - 273.15).toInt();
            final now = DateTime.now();
            // Filter forecasts for today, including midnight (00:00)
            final List<dynamic> todayForecasts = data.forecasts.where((item) {
              final dt = DateTime.parse(item['dt_txt'] as String);
              final isToday =
                  dt.year == now.year &&
                  dt.month == now.month &&
                  dt.day == now.day;
              final isMidnightNext = dt.hour == 0 && dt.day == now.day + 1;
              return isToday || isMidnightNext;
            }).toList();

            final cSky = data.cSky;
            final cPressure = data.cPressure;
            final cWindSpeed = data.cWindSpeed;
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
                                Text(
                                  cSky,
                                  style: const TextStyle(fontSize: 20),
                                ),
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
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount:
                          todayForecasts.length, // Exclude current weather
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = todayForecasts[index];
                        final dt = DateTime.parse(item['dt_txt'] as String);
                        final hourLabel = DateFormat(
                          'H:mm',
                        ).format(dt); // show hour
                        final tempC = (item['main']['temp'] - 273.15)
                            .toInt()
                            .toString();
                        final sky = item['weather'][0]['main'] as String;
                        return HourlyForecastWidget(
                          time: hourLabel,
                          temperature: tempC,
                          icon: (sky == 'Clouds' || sky == 'Rain')
                              ? Icons.cloud
                              : Icons.wb_sunny,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Spacer(),
                      AdditionalInfoWidget(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: "${cHumidity.toString()}%",
                      ),
                      Spacer(),
                      AdditionalInfoWidget(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: '${cWindSpeed.toString()} km/h',
                      ),
                      Spacer(),
                      AdditionalInfoWidget(
                        icon: Icons.compress,
                        label: 'Pressure',
                        value: '${cPressure.toString()} hPa',
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            );
          }
          ;
        },
      ),
    );
  }
}
