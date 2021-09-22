import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/shared/cubit/theme_states.dart';
import 'package:socialize/shared/network/local/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(AppIntialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? cache}) {
    if (cache != null) {
      // there's cache --> take the value and no need for caching
      isDark = cache;
      emit(AppChangemode());
    } else {
      // there's no cache --> cache the light mode (used on pressing the toggle button)
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangemode());
      });
    }
  }
}
