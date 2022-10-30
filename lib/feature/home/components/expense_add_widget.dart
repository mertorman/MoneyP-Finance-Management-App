import 'package:flutter/material.dart';
import 'package:moneyp/feature/home/model/category_widget_model.dart';
import 'package:moneyp/product/constant/color_settings.dart';

class ExpenseBottomSheet extends StatefulWidget {
  const ExpenseBottomSheet({super.key});

  @override
  State<ExpenseBottomSheet> createState() => _ExpenseBottomSheetState();
}

class _ExpenseBottomSheetState extends State<ExpenseBottomSheet> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.25,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expense Add',
              style: TextStyle(
                  color: ColorSettings.themeColor.shade200,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryWidgetModel.categoryWidgetModels.length,
                  itemBuilder: (context, index) {
                    //   CategoryWidgetModel model = CategoryWidgetModels
                    //       .categoryWidgetModels
                    //      .elementAt(index);

                    //   containerSize = model.onTap ? 120 : 90;
                    return CategoryWidgetModel.categoryWidgetModels[index];
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 18, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.euro, color: Colors.grey),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter total budget",
                        border: InputBorder.none,
                      ),
                    )),
                    VerticalDivider(color: Colors.blue),
                    DropdownButton(
                      hint: Text(
                        'EUR',
                        style: TextStyle(color: Colors.blue),
                      ),
                      iconDisabledColor: Colors.blue,
                      items: [],
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 18, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.title, color: Colors.grey),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter expense title",
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                    Expanded(child: TextField()),
                    Expanded(child: TextField())
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(130, 55),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                      minimumSize: Size(
                        130,
                        55,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class category_widget extends StatefulWidget {
  category_widget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.containerColor,
  }) : super(key: key);

  String imageUrl;
  String title;
  Color containerColor;

  @override
  State<category_widget> createState() => _category_widgetState();
}

class _category_widgetState extends State<category_widget> {
  bool open = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            open = !open;
          });
          await Future.delayed(Duration(milliseconds: open ? 280 : 100), () {
            setState(() {
              visible = !visible;
            });
          });
        },
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: open ? 120 : 90,
              height: open ? 120 : 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: widget.containerColor.withOpacity(0.33),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    widget.imageUrl,
                    width: 25,
                    height: 25,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: widget.containerColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
      ),
    );
  }
}
