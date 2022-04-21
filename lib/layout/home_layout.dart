import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/default_form_field.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
var formKey = GlobalKey<FormState>();

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
//cubit.titles[cubit.bottomNavigtionIndex],
          return Scaffold(
            resizeToAvoidBottomInset: false,
        
            key: scaffoldKey,
            body: cubit.screens[cubit.bottomNavigtionIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.cyan[900],
              child: cubit.floatingButtonIcon,
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit
                        .inserToDatabase(
                            title: titleController.text,
                            time: timeController.text,
                            date: dateController.text)
                        .then((value) {
                      Navigator.pop(context);
                      titleController.clear();
                      timeController.clear();
                      dateController.clear();

                      cubit.changeBottomSheetState(
                          false,
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ));
                    });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        color: Colors.black26,
                                      ),
                                      height: 50,
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 25,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.cancel
                                            ),
                                          
                                          ),
                                          SizedBox(
                                            width: 105,
                                          ),
                                          Text(
                                            lan.getTexts('add_task').toString(),
                                            style: Theme.of(context).textTheme.headline4,
                                          ),
                                        ],
                                      )),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                        
                                      ),
                                      child: Form(
                                        key: formKey,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          child: Column(
                                            //mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              DefaultFormField(
                                                controller: titleController,
                                                label: lan
                                                    .getTexts('new_task')
                                                    .toString(),
                                                type: TextInputType.text,
                                                validate: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return lan
                                                        .getTexts(
                                                            'title_must_not_be_empty')
                                                        .toString();
                                                  }
                                                  return null;
                                                },
                                                prefix: Icons.title,
                                                hintText: Text(lan
                                                    .getTexts('tasks')
                                                    .toString()),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              DefaultFormField(
                                                onTap: () {
                                                  showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now())
                                                      .then((value) =>
                                                          timeController.text =
                                                              value!.format(
                                                                  context));
                                                },
                                                controller: timeController,
                                                label: lan
                                                    .getTexts('task_time')
                                                    .toString(),
                                                type: TextInputType.datetime,
                                                validate: (String? value) {

                                                },
                                                prefix:
                                                    Icons.watch_later_outlined,
                                                hintText: Text(
                                                  lan
                                                      .getTexts('task_time')
                                                      .toString(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              DefaultFormField(
                                                onTap: () {
                                                  print('Tapped');
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime.parse(
                                                                  '2050-10-03'))
                                                      .then((value) =>
                                                          dateController.text =
                                                              DateFormat.yMMMd()
                                                                  .format(
                                                                      value!));
                                                },
                                                controller: dateController,
                                                label: lan
                                                    .getTexts('task_date')
                                                    .toString(),
                                                type: TextInputType.datetime,
                                                validate: (String? value) {

                                                },
                                                prefix: Icons.calendar_today,
                                                hintText: Text(
                                                  lan
                                                      .getTexts('task_date')
                                                      .toString(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 320,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                         
                          
                          )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        false, Icon(Icons.edit, color: Colors.white));
                  });

                  cubit.changeBottomSheetState(
                      true, Icon(Icons.add, color: Colors.white));
                }
              },
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.white10, width: 1))),
              child: BottomNavigationBar(
                 
                  currentIndex: cubit.bottomNavigtionIndex,
                  onTap: (index) {
                    cubit.changeIndex(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.menu),
                      label: lan.getTexts('tasks').toString(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline),
                      label: lan.getTexts('done').toString(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined),
                      label: lan.getTexts('archived').toString(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: lan.getTexts('setting').toString(),
                    ),
                  ]),
            ),
          );
        });
  }
}
