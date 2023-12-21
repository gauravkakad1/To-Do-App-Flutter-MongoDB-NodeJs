import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/config/config.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({Key? key, @required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  late String userId;
  List itemsList=[];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getTodoList(userId);
  }

  void addToDo() async  {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "title": titleController.text,
        "desc": descController.text,
      };

      var response = await http.post(
        Uri.parse(addToDoUrl),
        body: jsonEncode(regBody),
        headers: {"Content-Type": "application/json"},
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        titleController.clear();
        descController.clear();
        Navigator.pop(context);
        getTodoList(userId);
      } else {
        print("Something went wrong");
      }
    } else {
      print("Enter title and description");
    }
  }
  void getTodoList(userId)async{
    var reqBody = {
      'userId' : userId
    };
    var response = await http.post(Uri.parse(getToDoUrl),headers: {"Content-Type":"application/json"},body: jsonEncode(reqBody));
    print(response);
    var jsonResponse = jsonDecode(response.body);

    itemsList = jsonResponse('success');
    setState(() {

    });
  }
  void delTodo(id)async{
    var reqBody =
        {
          "id" : id
        };
    var response = await http.post(Uri.parse(delToDoUrl),headers: {"Content-Type":"application/json"},body: jsonEncode(reqBody));
    var delResponse = jsonDecode(response.body);
     if(delResponse['status']){
       getTodoList(userId);
     }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _displayTextInputDialog(context),
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.logout)],
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "To Do App",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          ),
          backgroundColor: Colors.lightGreen,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
          decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(top: 40.0,left: 30.0,right: 30.0,bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ToDo with NodeJS + Mongodb',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w700),),
              SizedBox(height: 10.0),
              Text(itemsList.length.toString()+" Tasks",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ],
          ),
      ),
        ),

      Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: (){}),
                        children: [
                          SlidableAction(
                            backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: "delete",
                              onPressed :(BuildContext context) {
                                delTodo(itemsList[index]['_id']);
                              },
                          )
                        ],
                      ),
                      child: Card(
                       child: ListTile(
                         title: Text(itemsList[index]['title'].toString()),
                         subtitle: Text(itemsList[index]['desc'].toString()),
                         leading: Icon(Icons.task),
                         trailing: Icon(Icons.arrow_back),
                       ),
                      )
                  );
                },
            ),
          )
      )
            ]
        ),
    ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add ToDo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => addToDo(),
                child: Center(child: Text("Add")),
              )
            ],
          ),
        );
      },
    );
  }
}
