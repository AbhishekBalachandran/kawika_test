import 'package:flutter/material.dart';
import 'package:kawika_test/controllers/home_controllers.dart';
import 'package:kawika_test/models/data_model.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeControllers>(
        builder: (context, provider, _) {
          return SafeArea(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 100),
              itemCount: provider.dataList.length,
              itemBuilder: (context, index) {
                final DataListModel data = provider.dataList[index];
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue, width: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        data.email ?? '',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: Text(data.body ?? ''),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
          );
        },
      ),
    );
  }

  void initialApi() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      await Provider.of<HomeControllers>(context, listen: false).getDataList();
    });
  }
}
