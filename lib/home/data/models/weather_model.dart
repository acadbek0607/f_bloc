// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final String cSky;
  final double cTemp;
  final double cPressure;
  final double cWindSpeed;
  final int cHumidity;

  WeatherModel({
    required this.cSky,
    required this.cTemp,
    required this.cPressure,
    required this.cWindSpeed,
    required this.cHumidity,
  });

  WeatherModel copyWith({
    String? cSky,
    double? cTemp,
    double? cPressure,
    double? cWindSpeed,
    int? cHumidity,
  }) {
    return WeatherModel(
      cSky: cSky ?? this.cSky,
      cTemp: cTemp ?? this.cTemp,
      cPressure: cPressure ?? this.cPressure,
      cWindSpeed: cWindSpeed ?? this.cWindSpeed,
      cHumidity: cHumidity ?? this.cHumidity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cSky': cSky,
      'cTemp': cTemp,
      'cPressure': cPressure,
      'cWindSpeed': cWindSpeed,
      'cHumidity': cHumidity,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];

    return WeatherModel(
      cSky: currentWeatherData['weather'][0]['main'],
      cTemp: currentWeatherData['main']['temp'] - 273.15,
      cPressure: currentWeatherData['main']['pressure'],
      cWindSpeed: currentWeatherData['wind']['speed'],
      cHumidity: currentWeatherData['main']['humidity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(cSky: $cSky, cTemp: $cTemp, cPressure: $cPressure, cWindSpeed: $cWindSpeed, cHumidity: $cHumidity)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.cSky == cSky &&
        other.cTemp == cTemp &&
        other.cPressure == cPressure &&
        other.cWindSpeed == cWindSpeed &&
        other.cHumidity == cHumidity;
  }

  @override
  int get hashCode {
    return cSky.hashCode ^
        cTemp.hashCode ^
        cPressure.hashCode ^
        cWindSpeed.hashCode ^
        cHumidity.hashCode;
  }
}
