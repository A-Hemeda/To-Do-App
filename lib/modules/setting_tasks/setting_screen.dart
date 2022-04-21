import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // change Language variable
    var lan = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          lan.getTexts('setting').toString(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),

                    ///Choose Lang
                    /*  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        alignment: lan.isEn
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        padding: const EdgeInsets.only(top: 5, right: 5),
                        child: Text(
                          lan.getTexts('choose_lan').toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ), */
                    Padding(
                      padding: EdgeInsets.only(
                          right: (lan.isEn ? 0 : 20),
                          left: (lan.isEn ? 20 : 0),
                          bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(lan.getTexts('ar').toString(),
                              style: Theme.of(context).textTheme.bodyText1),
                          Switch(
                            value: lan.isEn,
                            onChanged: (newValue) {
                              lan.changeLan();
                              /* Navigator.of(context).pop(); */
                            },
                          ),
                          Text(lan.getTexts('en').toString(),
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),
                    Divider(
                      height: 25,
                      indent: 50,
                      endIndent: 50,
                    ),
                    /////Change Theme
                    /*  Padding(
                      padding: EdgeInsets.only(
                          right: (lan.isEn ? 0 : 20),
                          left: (lan.isEn ? 20 : 0),
                          bottom: 10),
                      child: Text(
                        lan.getTexts('choose_theme').toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ), */
                    Padding(
                      padding: EdgeInsets.only(
                          right: (lan.isEn ? 0 : 20),
                          left: (lan.isEn ? 20 : 0),
                          bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(lan.getTexts('dark').toString(),
                              style: Theme.of(context).textTheme.bodyText1),
                          Switch(
                            value: AppCubit.get(context).isDark,
                            onChanged: (newValue) {
                              AppCubit.get(context).changeAppMode();
                              /* Navigator.of(context).pop(); */
                            },
                          ),
                          Text(lan.getTexts('bright').toString(),
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
