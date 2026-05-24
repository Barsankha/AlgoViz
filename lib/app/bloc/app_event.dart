part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();

  List<Object?> get props => [];
}

class ToggleDrawer extends AppEvent {
  const ToggleDrawer();
}

class TogggleList extends AppEvent {
  const TogggleList();
}

class ListA extends AppEvent {
  const ListA();
}

class ListD extends AppEvent {
  const ListD();
}

class StartGradientText extends AppEvent {
  final String text;
  StartGradientText(this.text);
}

class ToggleBookmark extends AppEvent {
  final String id;
  ToggleBookmark(this.id);
}

class SearchQueryChanged extends AppEvent {
  final String query;
  const SearchQueryChanged(this.query);
}

class ExpandedPsuedo extends AppEvent {
  const ExpandedPsuedo();
}

class ThemeChanged extends AppEvent {
  final AppTheme theme;
  ThemeChanged(this.theme);
}

class SettingChanged extends AppEvent {
  final SettingMode mode;
  SettingChanged(this.mode);
}

class IsImage extends AppEvent {
  const IsImage();
}

class ReducedMotion extends AppEvent {
  const ReducedMotion();
}
