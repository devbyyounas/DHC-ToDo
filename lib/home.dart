import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_3/Model/model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> tasks = [];
  final TextEditingController controller = TextEditingController();

  final Color primaryColor = const Color(0xFF4F46E5);

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // 🔹 Load Tasks
  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('tasks');

    if (data != null) {
      List decoded = jsonDecode(data);
      setState(() {
        tasks = decoded.map((e) => Todo.fromJson(e)).toList();
      });
    }
  }

  // 🔹 Save Tasks
  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List encoded = tasks.map((e) => e.toJson()).toList();
    prefs.setString('tasks', jsonEncode(encoded));
  }

  // 🔹 Add Task
  void addTask() {
    String text = controller.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        tasks.add(Todo(title: text));
      });
      controller.clear();
      saveTasks();
    }
  }

  // 🔹 Toggle Task
  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
    saveTasks();
  }

  // 🔹 Delete Task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  // 🔹 Edit Task
  void editTask(int index) {
    TextEditingController editController =
        TextEditingController(text: tasks[index].title);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Edit Task"),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(
            hintText: "Update task",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            child: const Text("Save"),
            onPressed: () {
              setState(() {
                tasks[index].title = editController.text;
              });
              saveTasks();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
      ),
      body: Column(
        children: [
          // 🔹 INPUT SECTION
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Add a new task...",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: addTask,
                  child: const Text("Add"),
                ),
              ],
            ),
          ),

          // 🔹 EMPTY STATE
          if (tasks.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  "No tasks yet 📝",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          else
            // 🔹 TASK LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(tasks[index].title + index.toString()),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => deleteTask(index),
                    child: Card(
                      color: Color.fromARGB(192, 248, 248, 248),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 MAIN TASK TILE
                            ListTile(
                              leading: Checkbox(
                                value: tasks[index].isDone,
                                activeColor: primaryColor,
                                onChanged: (_) => toggleTask(index),
                              ),
                              title: Text(
                                tasks[index].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: tasks[index].isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: tasks[index].isDone
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit, color: primaryColor),
                                onPressed: () => editTask(index),
                              ),
                            ),

                            // 🔹 SWIPE HINT TEXT
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, bottom: 6),
                              child: Text(
                                "Swipe to delete the task",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
