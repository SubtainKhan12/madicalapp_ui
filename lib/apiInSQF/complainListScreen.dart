import 'package:flutter/material.dart';
import 'ComplainList.dart';
import 'databaseService.dart';

class ComplaintListScreen extends StatefulWidget {
  @override
  _ComplaintListScreenState createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  Future<List<Complaint>>? _complaints;

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }

  void _loadComplaints() async {
    // Fetch complaints from the database
    final localComplaints = await DatabaseHelper().getComplaints();

    // Update the UI with local complaints first
    setState(() {
      _complaints = Future.value(localComplaints);
    });

    // Fetch and store complaints from the network if available
    try {
      await DatabaseHelper().storeComplaints();
      final updatedComplaints = await DatabaseHelper().getComplaints();
      setState(() {
        _complaints = Future.value(updatedComplaints);
      });
    } catch (e) {
      print('Failed to fetch and store complaints: $e');
      // Optionally, show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Complaint>>(
        future: _complaints,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No complaints found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final complaint = snapshot.data![index];
                return ListTile(
                  title: Text(complaint.fullname),
                  subtitle: Text(complaint.description),
                );
              },
            );
          }
        },
      ),
    );
  }
}
