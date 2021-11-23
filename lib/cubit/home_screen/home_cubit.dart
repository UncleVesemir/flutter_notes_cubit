import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_helper.dart';
import '../../models/note_model.dart';
import '../events/event_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final List<String> titles = ['Home', 'Daily', 'Timeline', 'Explore'];

  final List<PageCategoryInfo> _initPages = <PageCategoryInfo>[
    PageCategoryInfo(
      title: 'Journal',
      icon: 2,
    ),
    PageCategoryInfo(
      title: 'Notes',
      icon: 1,
    ),
    PageCategoryInfo(
      title: 'Text',
      icon: 0,
    ),
  ];

  HomeCubit() : super(HomeState());

  final DatabaseHelper _database = DatabaseHelper();

  void init() async {
    var pages = await _database.readAllPages();

    if (await pages.isNotEmpty) {
      emit(state.copyWith(pages: pages));
    } else {
      // TODO Basic notes if list is empty
    }
  }

  void updatePage(String lastMessage) async{
    var updatedPage = state.pages[state.selectedPage];
    updatedPage.lastMessage = lastMessage;
    _database.updatePage(updatedPage);
  }

  void initSelected(BuildContext context) {
    changeSelectedPage(state.selectedPage, context);
  }

  void changeSelectedPage(int value, BuildContext context) async{
    emit(state.copyWith(selectedPage: value));
    var events = await BlocProvider.of<EventCubit>(context).initPageEvents(state.pages[value]);
    emit(state.copyWith(loadedPage: events));
  }

  void setCurrentPagesList(List<PageCategoryInfo> currentPagesList) =>
      emit(state.copyWith(pages: currentPagesList));

  void addPage(PageCategoryInfo page) async {
    final pages = List<PageCategoryInfo>.from(state.pages)..add(page);
    _database.addPage(page);
    emit(state.copyWith(pages: pages));
  }

  void deletePage(int localIndex, int dbIndex) {
    final pages = List<PageCategoryInfo>.from(state.pages)
      ..removeAt(localIndex);
    _database.deletePage(dbIndex);
    emit(state.copyWith(pages: pages));
  }

  void editPage(int index, PageCategoryInfo page) {
    final pages = List<PageCategoryInfo>.from(state.pages)
      ..[index] = PageCategoryInfo.from(page);
    _database.updatePage(page);
    emit(state.copyWith(pages: pages));
  }

  void pinPage(int index) {
    final pages = List<PageCategoryInfo>.from(state.pages);
    if (pages[index].isPinned) {
      var i = 0;
      while (i < pages.length && pages[i].isPinned) {
        i++;
      }
      pages[index].isPinned = pages[index].isPinned ? false : true;
      pages.insert(i - 1, PageCategoryInfo.from(pages.removeAt(index)));
    } else {
      pages.insert(0, PageCategoryInfo.from(pages.removeAt(index)));
      pages[0].isPinned = true;
    }
    emit(state.copyWith(pages: pages));
  }

  void setNavBarItem(int? index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
