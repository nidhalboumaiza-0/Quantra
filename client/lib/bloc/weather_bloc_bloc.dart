import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/my_data.dart';

import '../main.dart';

part 'weather_bloc_event.dart';

part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.FRENCH);
        Weather weather =
            await wf.currentWeatherByLocation(37.275727, 9.864101);
        emit(WeatherBlocSuccess(weather));
        // print(weather);
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
