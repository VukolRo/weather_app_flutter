import 'location.dart';
import 'networking.dart';

const String kApiKey = 'd3cdc09fc875b38a9717c565ee66859d';
const String urlAuthority = 'api.openweathermap.org';
const String urlUnencodedPath = '/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String? cityName) async {
    final url = Uri.https(urlAuthority, urlUnencodedPath, {
      'q': cityName,
      'appid': kApiKey,
      'units': 'metric',
    });
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    return decodedData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    final url = Uri.https(urlAuthority, urlUnencodedPath, {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'appid': kApiKey,
      'units': 'metric',
    });
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodedData = await networkHelper.getData();
    return decodedData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
