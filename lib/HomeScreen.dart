import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_list/db_services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool personal = true, college = false, office = false, suggest = false;
  TextEditingController todoController = TextEditingController();
  Stream? todoStream;

  getOnTheLoad() async {
    DataBaseService db = DataBaseService();
    todoStream = await db.getTask(personal
        ? "PersonalTask"
        : college
            ? "CollegeTask"
            : "OfficeTask");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getWork() {
    return StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnap = snapshot.data.docs[index];
                        return CheckboxListTile(
                          activeColor: Colors.greenAccent.shade400,
                          value: docSnap["Yes"],
                          onChanged: (newValue) async {
                            DataBaseService db = DataBaseService();
                            await db.tickMethod(
                                docSnap["Id"],
                                personal
                                    ? "PersonalTask"
                                    : college
                                        ? "CollegeTask"
                                        : "OfficeTask");
                            setState(() {
                              db.removeMethod(
                                  docSnap["Id"],
                                  personal
                                      ? "PersonalTask"
                                      : college
                                          ? "CollegeTask"
                                          : "OfficeTask");
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            docSnap["Work"],
                          ),
                        );
                      }),
                )
              : const Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          openbox();
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 20),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white30,
              Colors.white60,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hii,",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Indujan",
              style: TextStyle(
                fontSize: 54,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Let's begin the work",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Check the task to mark it as completed and remove it from the list.",
              style: TextStyle(
                fontSize: 10,
                color: Colors.black45,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                personal
                    ? Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent.shade200,
                          ),
                          child: const Text(
                            "Personal",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = true;
                          college = false;
                          office = false;
                          await getOnTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "Personal",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                college
                    ? Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent.shade200,
                          ),
                          child: const Text(
                            "College",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = false;
                          college = true;
                          office = false;
                          await getOnTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "College",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                office
                    ? Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent.shade200,
                          ),
                          child: const Text(
                            "Office",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = false;
                          college = false;
                          office = true;
                          await getOnTheLoad();
                          setState(() async {});
                        },
                        child: const Text(
                          "Office",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            getWork(),
          ],
        ),
      ),
    );
  }

  Future openbox() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.cancel,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  const Text(
                    "Add ToDo Task ~",
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Add Text",
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: todoController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter the task",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> usertodo = {
                        "Work": todoController.text,
                        "Id": id,
                        "Yes": false,
                      };
                      personal
                          ? DataBaseService().addPersonalTask(usertodo, id)
                          : college
                              ? DataBaseService().addCollegeTask(usertodo, id)
                              : DataBaseService().addOfficeTask(usertodo, id);
                      todoController.clear();
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
