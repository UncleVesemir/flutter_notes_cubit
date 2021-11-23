import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/settings/settings_cubit.dart';
import 'package:notes/routes/routes.dart';
import 'package:notes/utils/utils.dart';

import '../../cubit/home_screen/home_cubit.dart';
import '../../cubit/themes/theme_cubit.dart';
import '../../main.dart';
import '../../models/note_model.dart';
import '../../routes/routes.dart' as route;
import 'drawer_build.dart';
import 'list_view_build.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).initSelected(context);
    BlocProvider.of<SettingsCubit>(context)
        .changeOrientation(MediaQuery.of(context).orientation);
    final textState =
        BlocProvider.of<SettingsCubit>(context).state.textSize.toDouble();
    final themeCubit = context.read<ThemeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (cubitContext, state) {
        var index = BlocProvider.of<HomeCubit>(context).state.selectedIndex;
        return Scaffold(
          drawer: BuildDrawer(),
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              index == 0
                  ? 'Home'
                  : index == 1
                      ? 'Daily'
                      : index == 2
                          ? 'Timeline'
                          : index == 3
                              ? 'Explore'
                              : 'IndexOutOfRange',
              style: TextStyle(
                fontSize: textState + 5,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  onPressed: themeCubit.changeTheme,
                  icon: const Icon(Icons.invert_colors)),
            ],
          ),
          body: buildPages(context, state),
          floatingActionButton: buildFloatingActionButton(context),
          bottomNavigationBar: buildBottomNavigationBar(cubitContext, state),
        );
      },
    );
  }

  Widget buildBottomNavigationBar(BuildContext context, HomeState state) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      currentIndex: state.selectedIndex,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.class_),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Daily',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Timeline',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
      ],
      onTap: (index) {
        context.read<HomeCubit>().setNavBarItem(index);
      },
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
      ),
      onPressed: () async {
        final page = await Navigator.of(context).pushNamed(route.addNotePage);
        if (page is PageCategoryInfo) {
          context.read<HomeCubit>().addPage(page);
        }
      },
    );
  }

  Widget buildPages(BuildContext context, HomeState state) {
    switch (state.selectedIndex) {
      case 0:
        return homePage(context);
      case 1:
        return daily();
      case 2:
        return timeline();
      case 3:
        return explore();
      default:
        return Container();
    }
  }

  Widget homePage(BuildContext context) {
    final orientation =
        BlocProvider.of<SettingsCubit>(context).state.orientation;
    return Column(
      children: <Widget>[
        // buildSearchContainer(),
        Flexible(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: BuildListView(),
              ),
              orientation == Orientation.landscape
                  ? buildEvents(context)
                  : Container(),
            ],
          ),
        )
      ],
    );
  }

  Widget buildEvents(BuildContext context) {
    final state = BlocProvider.of<HomeCubit>(context).state;
    return state.loadedPage!.allNotes.isNotEmpty
        ? Expanded(
            flex: 6,
            child: ListView.builder(
              reverse: true,
              itemCount: state.loadedPage!.allNotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    Navigator.of(context).pushNamed(
                      noteInfoPage,
                      arguments: state.pages[state.selectedPage],
                    );
                  },
                  leading: Icon(listOfEventsIcons[
                      state.loadedPage!.allNotes[index].category]),
                  title: Text(state.loadedPage!.allNotes[index].description!),
                  subtitle:
                      Text(getFullDate(state.loadedPage!.allNotes[index].time)),
                );
              },
            ),
          )
        : Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: ListTile(
                  onTap: () async {
                    Navigator.of(context).pushNamed(
                      noteInfoPage,
                      arguments: state.pages[state.selectedPage],
                    );
                  },
                  title:
                      const Text('This page is empty, tap to add new events'),
                  trailing: const Icon(Icons.add),
                ),
              ),
            ),
          );
  }

  Widget buildSearchContainer() {
    return Container(
      height: 65,
      child: Center(
        child: Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            height: 60,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Search',
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget daily() => Container();

  Widget timeline() => Container();

  Widget explore() => Container();
}
