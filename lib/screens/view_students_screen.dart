import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewStudentsScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text('View Students')),
        body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('students')
            .snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> studentSnapshot) {
                if (studentSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                }

                final studentDocs = studentSnapshot.data!.docs;

                return ListView.builder(
                    itemCount: studentDocs.length,
                    itemBuilder: (ctx, index) {
                        return ListTile(
                            title: Text(studentDocs[index]['name']),
                            subtitle: Text('DOB: ${studentDocs[index]['dob']}, Gender: ${studentDocs[index]['gender']}'),
                        );
                    },
                );
            },
        ),
        );
    }
}
