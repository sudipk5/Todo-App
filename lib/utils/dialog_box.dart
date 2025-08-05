import 'package:flutter/material.dart';

// ...existing code...

class DialogBox extends StatelessWidget {


  final Controller;

  final VoidCallback onSave;

  final VoidCallback onCancle;








  const DialogBox({super.key , required this.Controller , required this.onCancle , required this.onSave});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[400],
      content: SizedBox(

        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: Controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),hintText: "Add New Task"
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onCancle , child: Text('Cancel',style: TextStyle(color: Colors.white),)),
                const SizedBox(width: 8,),
                TextButton(onPressed: onSave, child: Text('Add',style: TextStyle(color: Colors.white),)),
              ],
            )



          ],
        ),

      ),
      
    );
  }
}