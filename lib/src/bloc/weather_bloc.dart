import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import './weather_event.dart';
import './weather_state.dart';
import '../data/repositories/repositories.dart';
import '../data/models/models.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
      WeatherState currentState, WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
    }

    if (event is FetchWeather) {
      try {
        Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}
