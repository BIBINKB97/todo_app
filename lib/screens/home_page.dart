import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/screens/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 30, bottom: 15),
                      child: Text(
                        "All ToDo's",
                        style: TextStyle(
                            color: tdBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDo todoo in _foundToDo.reversed)
                      TodoItem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChanges,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: 60,
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: tdgrey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ]),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                        hintText: 'Add a new todo item',
                        hintStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                )),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10, minimumSize: Size(60, 60)),
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChanges(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          cursorColor: tdBlack,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              prefixIcon: Icon(
                Icons.search,
                size: 22,
                color: tdBlack,
              ),
              prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 5),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: tdgrey, fontSize: 20)),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.menu,
            color: tdBlack,
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
