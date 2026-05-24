import 'dart:async';
import 'dart:math';
import 'package:algov/core/enums/algorithm_type.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<ToggleDrawer>(_onToggleDrawer);
    on<TogggleList>(_onToggleList);
    on<StartGradientText>(_onStart);
    on<ToggleBookmark>(_onToggleBookmark);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ExpandedPsuedo>(_onExpadedpsuedo);
    on<ThemeChanged>(_onThemeChanged);
    on<SettingChanged>(_onSettingChanged);
    on<IsImage>(_onToggleTheme);
    on<ReducedMotion>(_onReducedMotion);
  }
  void _onReducedMotion(ReducedMotion event, Emitter<AppState> emit) {
    emit(
      state.copyWith(reduceMotion: !state.reduceMotion, theme: AppTheme.dark),
    );
  }

  void _onToggleTheme(IsImage event, Emitter<AppState> emit) {
    emit(state.copyWith(isImage: !state.isImage));
  }

  void _onSettingChanged(SettingChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(mode: event.mode));
  }

  void _onThemeChanged(ThemeChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(theme: event.theme, reduceMotion: false));
  }

  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(searchquery: event.query));
  }

  void _onExpadedpsuedo(ExpandedPsuedo event, Emitter<AppState> emit) {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  void _onToggleDrawer(ToggleDrawer event, Emitter<AppState> emit) {
    emit(state.copyWith(isDrawerOpen: !state.isDrawerOpen));
  }

  void _onToggleList(TogggleList event, Emitter<AppState> emit) {
    emit(state.copyWith(isList: !state.isList));
  }

  Future<void> _onStart(StartGradientText event, Emitter<AppState> emit) async {
    final text = event.text;
    final chars = '01#%&@*?10';
    final random = Random();

    int iteration = 0;

    String displayText = "";

    while (iteration <= text.length) {
      if (iteration < text.length) {
        displayText =
            text.substring(0, iteration) + chars[random.nextInt(chars.length)];
      } else {
        displayText = text;
      }

      emit(state.copyWith(displayText: displayText));

      iteration++;
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void _onToggleBookmark(ToggleBookmark event, Emitter<AppState> emit) {
    final updateBook = Set<String>.from(state.bookmarkIds);

    if (updateBook.contains(event.id)) {
      updateBook.remove(event.id);
    } else {
      updateBook.add(event.id);
    }
    emit(state.copyWith(bookmarkIds: updateBook));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    final list = (json['bookmarkIds'] as List).cast<String>().toSet();
    // final themeName = json['theme'] as String?;
    //final theme = themeName != null ? AppTheme.values.byName(themeName) : AppTheme.dark;
    try {
      return AppState(
        bookmarkIds: list,
        //theme: theme
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return {
      'bookmarkIds': state.bookmarkIds.toList(),
      // 'theme': state.theme.name,
      'reduceMotion': state.reduceMotion,
    };
  }
}
