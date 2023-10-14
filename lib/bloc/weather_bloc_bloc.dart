import 'package:bloc/bloc.dart';
import 'package:bloc_sample/data/my_data.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        //天気情報を取得
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);

        //位置情報を取得
        Position position = await Geolocator.getCurrentPosition();

        //位置情報の天気を取得
        Weather weather = await wf.currentWeatherByLocation(
            position.latitude, position.longitude);

            print(weather);

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
