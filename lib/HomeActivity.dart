
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/Style.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {

  List<Task> taskList = [];
  GlobalKey<FormState> taskForm = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final TextEditingController _dateTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Task Management"),
        centerTitle: true,
      ),
      body: ListView.separated(

        itemCount: taskList.length ,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onLongPress: (){
                showModalBottomSheet(context: context, builder: (context){
                  return Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(taskList[index].title,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(taskList[index].description,
                            style: const TextStyle(
                              fontSize: 20,
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text("Date: ${taskList[index].deadLine}",
                            style: const TextStyle(
                      fontSize: 20
                      ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(onPressed: (){
                              taskList.removeAt(index);
                              if(mounted){
                                setState(() {
                                });
                              }
                              Navigator.pop(context);
                            },
                                child: const Text("Delete")),
                          )
                        ],
                      ),
                    ),
                  );
                });
              },
              title: Text(taskList[index].title),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(taskList[index].description ,

                 ),
                  Text("Date: ${taskList[index].deadLine}"),
                ],
              ),
              isThreeLine: true,

            ),
          );
        },
          separatorBuilder: (context, index){
            return const Divider(height: 1,);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          showDialog(context: context, builder: (context){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AlertDialog(

                  alignment: Alignment.center,
                  shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  title: const Text("Add New Task"),
                  content: Builder(
                    builder: (context) {
                      return Form(
                        key: taskForm,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 5),
                              child: TextFormField(
                                controller: _titleTEController,
                                decoration: AppInputDecoration("title"),
                                validator: (String? value){
                                  if(value?.trim().isEmpty ?? true){
                                    return "Please Enter the title";
                                  }
                                  return null;
                                },

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5 , bottom: 5),
                              child: TextFormField(
                                controller: _descriptionTEController,
                                decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(width: 50, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(13))),
                      contentPadding: EdgeInsets.symmetric(vertical: 40),
                      labelText: "Description",

                      ),
                                validator: (String? value){
                                  if(value?.trim().isEmpty ?? true){
                                    return " Please Enter The Description";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: TextFormField(
                                controller: _dateTEController,
                                decoration:AppInputDecoration("Date Required"),
                                validator: (String? value){
                                  if(value?.trim().isEmpty ?? true){
                                    return " Please Enter The Date";
                                  }
                                  return null;
                                },
                              ),
                            ),

                          ],

                        ),

                      );

                    }
                  ),
                  actions: [
                    TextButton(
                        onPressed: (){
                          if(taskForm.currentState!.validate()){
                            taskList.add(Task(_titleTEController.text, _descriptionTEController.text, _dateTEController.text));
                            if(mounted){
                              setState(() {
                              });
                            }
                            _titleTEController.clear();
                            _descriptionTEController.clear();
                            _dateTEController.clear();
                            Navigator.pop(context);
                          }

                        },
                        child: const Text("Save"))
                  ],
                ),
              ],
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String title, description ;
  String deadLine;
  Task(this.title, this.description, this.deadLine);
}

