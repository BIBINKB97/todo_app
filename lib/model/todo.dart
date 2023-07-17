class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '0', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '1', todoText: 'Buy groceries', isDone: true),
      ToDo(id: '2', todoText: 'Check Mails'),
      ToDo(id: '3', todoText: 'Team Meeting'),
      ToDo(id: '4', todoText: 'Wash car'),
      ToDo(id: '5', todoText: 'dinner with GF'),
    ];
  }
}
