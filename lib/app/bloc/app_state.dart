part of 'app_bloc.dart';

class AppState {
  final bool isDrawerOpen;

  final bool isList;

  final String displayText;

  final bool isSave;

  final Set<String> bookmarkIds;

  final String searchquery;

  final bool isExpanded;

  final AppTheme theme;
  final SettingMode mode;
  final bool isImage;
  final bool reduceMotion;

  const AppState({
    this.isList = false,
    this.isDrawerOpen = false,
    this.displayText = 'AlgoViz',
    this.isSave = false,

    this.bookmarkIds = const {},
    this.searchquery = '',

    this.isExpanded = false,
    this.theme = AppTheme.dark,
    this.mode = SettingMode.visuals,
    this.isImage = true,
    this.reduceMotion = true,
  });

  AppState copyWith({
    bool? isDrawerOpen,
    bool? isList,
    String? displayText,
    bool? isSave,

    String? searchquery,

    bool? isExpanded,
    AppTheme? theme,
    SettingMode? mode,
    bool? isImage,
    bool? reduceMotion,
    Set<String>? bookmarkIds,
  }) {
    return AppState(
      bookmarkIds: bookmarkIds ?? this.bookmarkIds,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
      isList: isList ?? this.isList,
      displayText: displayText ?? this.displayText,
      isSave: isSave ?? this.isSave,
      searchquery: searchquery ?? this.searchquery,
      isExpanded: isExpanded ?? this.isExpanded,
      theme: theme ?? this.theme,
      mode: mode ?? this.mode,
      isImage: isImage ?? this.isImage,
      reduceMotion: reduceMotion ?? this.reduceMotion,
    );
  }

  List<Object?> get props => [
    bookmarkIds,
    isDrawerOpen,
    isExpanded,
    isList,
    searchquery,
    displayText,
    isSave,
  ];
}
