import 'package:flutter/material.dart';

class BuyingScreen extends StatelessWidget {
  const BuyingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buying'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'In-progress'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BuyingProgressTab(),
            BuyingCompletedTab(),
          ],
        ),
      ),
    );
  }
}

class BuyingProgressTab extends StatelessWidget {
  const BuyingProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch and display the "In-progress" data from the server here
    return ListView.builder(
      itemCount: 10, // This is just a placeholder. Replace with actual data count.
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('In-progress Item $index'),
          // Add more details for each item as needed
        );
      },
    );
  }
}

class BuyingCompletedTab extends StatelessWidget {

  const BuyingCompletedTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch and display the "Completed" data from the server here
    return ListView.builder(
      itemCount: 10, // This is just a placeholder. Replace with actual data count.
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Completed Item $index'),
          // Add more details for each item as needed
        );
      },
    );
  }
}
