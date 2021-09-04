import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';
import 'package:messenger_app_flutter/shared/components/constants.dart';
import 'package:messenger_app_flutter/shared/cubit/cubit.dart';
import 'package:messenger_app_flutter/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  initState() {
    //super.initState();
    //createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentindex]),
          ),
          // body: ConditionalBuilder(
          //     condition: tasks.length > 0,
          //     builder: (context) => screens[currentindex],
          //     fallback: (context) => Center(child: CircularProgressIndicator())),
          //body: tasks.length > 0
          // ? screens[currentindex]
          // : Center(child: CircularProgressIndicator()),
          body: state is! AppGetDatabaseLoadingState
              ? cubit.screens[cubit.currentindex]
              : Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(cubit.fabIcon),
            onPressed: () {
              if (cubit.isBottomSheetOpen) {
                print('yes isBottomSheetOpen !!!');
                if (formKey.currentState!.validate()) {
                  cubit.insertIntoDatabase(titleController.text,
                      dateController.text, timeController.text);
                  // insertIntoDatabase(titleController.text,
                  //         dateController.text, timeController.text)
                  //     .then((value) {
                  //   Navigator.pop(context);

                  // setState(() {
                  //   isBottomSheetOpen = false;
                  //   fabIcon = Icons.edit;
                  //   tasks = value;
                  //   print(value);
                  // });
                  //});
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextFormField(
                                  titleController,
                                  'Task title',
                                  Icons.title,
                                  null,
                                  false,
                                  TextInputType.text,
                                  true, (value) {
                                if (value!.isEmpty) {
                                  return 'title must not be empty';
                                }
                                return null;
                              }, () {}, (value) {}, () {}, () {}),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultTextFormField(
                                  timeController,
                                  'Task Time',
                                  Icons.watch_later_outlined,
                                  null,
                                  false,
                                  TextInputType.datetime,
                                  true,
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  () {},
                                  (value) {},
                                  () {
                                    // showTimePicker(
                                    //         context: context,
                                    //         initialTime: TimeOfDay.now())
                                    //     .then((value) => {
                                    //           print(value!.format(context).toString())
                                    //         });
                                  },
                                  () {}),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultTextFormField(
                                  dateController,
                                  'Task Date',
                                  Icons.calendar_today,
                                  null,
                                  false,
                                  TextInputType.datetime,
                                  true,
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  () {},
                                  (value) {},
                                  () {
                                    // showDatePicker(
                                    //   context: context,
                                    //   initialDate: DateTime.now(),
                                    //   firstDate: DateTime.now(),
                                    //   lastDate: DateTime.parse('2021-05-03'),
                                    // ).then((value) {
                                    //   print(DateFormat.yMMMd().format(value!));
                                    //   dateController.text =
                                    //       DateFormat.yMMMd().format(value);
                                    // });
                                  },
                                  () {}),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(false, Icons.edit);
                  //isBottomSheetOpen = false;
                  // setState(() {
                  //   fabIcon = Icons.edit;
                  // });
                });
                cubit.changeBottomSheetState(true, Icons.add);

                // setState(() {
                //   fabIcon = Icons.add;
                // });
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeIndex(index);
              // setState(() {
              //   currentindex = index;
              // });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.new_label),
                label: 'New Task',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), label: 'Done Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'Archived Tasks'),
            ],
          ),
        );
      },
    );
  }
}
