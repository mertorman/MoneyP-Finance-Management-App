import 'dart:ui';
import 'package:moneyp/feature/home/components/card_widget.dart';

import '/product/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:moneyp/feature/home/view/model/list_item_model.dart';

import 'package:moneyp/feature/home/model/card_widget_model.dart';

import 'package:moneyp/product/constant/color_settings.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_outlined,
                color: Colors.grey,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ColorSettings.themeColor.shade200,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/pp3.jpg'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            TopCardWidget(),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Cards",
                    style: GoogleFonts.daysOne(
                      textStyle: const TextStyle(
                          color: Color(0xFF40565a),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 165,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const CardWidget();
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expenses",
                    style: GoogleFonts.daysOne(
                      textStyle: const TextStyle(
                          color: Color(0xFF40565a),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
       Container(
         child: ListView.builder(shrinkWrap: true,itemCount: ListItemModel.models.length,itemBuilder: (context, index) {
           return ListItem(expenseTitle: ListItemModel.models[index].expenseTitle, expenseDescription: ListItemModel.models[index].expenseDescription, expenseIcon: ListItemModel.models[index].expenseIcon);
         },),
       )

            
           
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,required this.expenseTitle , required this.expenseDescription , required this.expenseIcon
  }) : super(key: key);

final expenseTitle;
final expenseDescription;
final Icon expenseIcon;
  @override
  Widget build(BuildContext context) {
    return Container( padding: EdgeInsets.all(4),
      height: 74,
      child: Card(
        color: Colors.indigoAccent.shade200,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28)),
        child: RoundedExpansionTile(
          enabled: false,
          trailing: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: Icon(Icons.edit , color: Colors.white,),
            onPressed: () {},
          ),
          leading:
              expenseIcon,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              expenseTitle,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                expenseDescription,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  color: Colors.grey.shade200,
                ),
                child: Center(
                  child: Text(
                    'Widget',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            )

        

          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.indigoAccent.shade200,
      child: Container(
        width: 140,
        height: 165,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VISA',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('₺',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text('600',
                        style: GoogleFonts.daysOne(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
