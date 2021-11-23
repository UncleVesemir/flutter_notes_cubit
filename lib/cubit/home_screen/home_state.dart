part of 'home_cubit.dart';

class HomeState{
  final List<PageCategoryInfo> pages;
  final int selectedIndex;
  final int selectedPage;
  final EventState? loadedPage;

  HomeState({
    this.selectedPage = 0,
    this.pages = const [],
    this.selectedIndex = 0,
    this.loadedPage,
  });

  HomeState copyWith({
    EventState? loadedPage,
    int? selectedPage,
    List<PageCategoryInfo>? pages,
    int? selectedIndex,
  }) {
    return HomeState(
      loadedPage: loadedPage ?? this.loadedPage,
      selectedPage: selectedPage ?? this.selectedPage,
      pages: pages ?? this.pages,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

}
