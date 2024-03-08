// ignore_for_file: file_namess, sized_box_for_whitespace, non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:to_do/Constants/Colors.dart';
import 'package:to_do/Models/Todo.dart';
import 'package:to_do/Widgets/ToDoItem.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ToDoList = Todo.ToDoList();
  final _ToDoController = TextEditingController();
  List<Todo> _FoundToDo = [];

  @override
  void initState() {
    _FoundToDo = ToDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: _AppBar(),
      body: _Body(),
    );
  }

  Stack _Body() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _SearchBox(),
                    _ToDoText(),
                    for (Todo todoo in _FoundToDo.reversed)
                      ToDoItem(
                        todo: todoo,
                        onTodoChange: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [_AddNewToDoTextField(), _AddNewToDoButton()],
          ),
        ),
      ],
    );
  }

  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      ToDoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String todo) {
    setState(() {
      ToDoList.add(Todo(
        id: DateTime.now().microsecond.toString(),
        ToDotext: todo,
      ));
    });
    _ToDoController.clear();
  }

  void _runFilter(String enteredKeyWord) {
    List<Todo> results = [];
    if (enteredKeyWord.isEmpty) {
      results = ToDoList;
    } else {
      results = ToDoList.where((item) => item.ToDotext!
          .toLowerCase()
          .contains(enteredKeyWord.toLowerCase())).toList();
    }
    setState(() {
      _FoundToDo = results;
    });
  }

  Container _AddNewToDoButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Blue,
        ),
        onPressed: () {
          _addToDoItem(_ToDoController.text);
        },
        child: const Text(
          '+',
          style: TextStyle(fontSize: 38, color: White),
        ),
      ),
    );
  }

  Expanded _AddNewToDoTextField() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: White,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 0),
                  blurRadius: 15,
                  spreadRadius: 3),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: _ToDoController,
          decoration: const InputDecoration(
              hintStyle: TextStyle(fontSize: 20),
              hintText: 'Add a new ToDo item !',
              border: InputBorder.none),
        ),
      ),
    );
  }

  Container _ToDoText() {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: const Text(
        'All ToDos',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding _SearchBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: White),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 22,
                color: Black,
              ),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, maxWidth: 20),
              border: InputBorder.none,
              hintText: 'Search',
            ),
          ),
        ),
      ),
    );
  }

  AppBar _AppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Grey,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu_rounded,
            color: Black,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: const Image(image: AssetImage('assets/IMG_1912.jpg')),
            ),
          )
        ],
      ),
    );
  }
}
