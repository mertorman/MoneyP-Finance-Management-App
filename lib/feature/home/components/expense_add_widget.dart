import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/home/components/deneme.dart';
import 'package:moneyp/feature/home/components/expense_widget.dart';
import 'package:moneyp/feature/home/controller/expense_controller.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:moneyp/product/constant/color_settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ExpenseBottomSheet extends StatefulWidget {
  const ExpenseBottomSheet({super.key});

  @override
  State<ExpenseBottomSheet> createState() => _ExpenseBottomSheetState();
}

class _ExpenseBottomSheetState extends State<ExpenseBottomSheet> {
  ExpenseController controller = Get.find();
  TextEditingController title = TextEditingController();
  TextEditingController expenseDesc = TextEditingController();
  TextEditingController expenseTotal = TextEditingController();
  ExpenseModel? _selectedExpense = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.25,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.8)),
              child: TabBar(
                controller: controller.tabController,
                indicator: RectangularIndicator(
                  color: Colors.blue.shade300,
                  topLeftRadius: 15,
                  topRightRadius: 15,
                  bottomLeftRadius: 15,
                  bottomRightRadius: 15,
                ),
                indicatorColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: controller.tabs,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Divider(),
            ),
            Expanded(
              child: TabBarView(controller: controller.tabController,children: [
                ExpenseWidget(controller: controller, expenseTotal: expenseTotal, title: title, expenseDesc: expenseDesc),
              ExpenseWidget(controller: controller, expenseTotal: expenseTotal, title: title, expenseDesc: expenseDesc),
              ]),
            ),
           
            /*
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Container(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: ExpenseModel.expenseItems.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.expenseSec(index);

                            if (controller.selectedExpense.value != null) {
                              controller.selectedExpense.value!.isSelected =
                                  false;
                            }
                            ExpenseModel.expenseItems[index].isSelected =
                                !ExpenseModel.expenseItems[index].isSelected!;
                            controller.selectedExpense.value =
                                ExpenseModel.expenseItems[index];
                            ExpenseModel.expenseItems.refresh();
                          },
                          child: category_widget(
                            isSelected:
                               ExpenseModel.expenseItems[index].isSelected!,
                            title:
                                ExpenseModel.expenseItems[index].expenseType!,
                            imageUrl:
                                ExpenseModel.expenseItems[index].imagePath!,
                            containerColor: Color(int.parse(
                                ExpenseModel.expenseItems[index].color!)),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 18, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.euro, color: Colors.grey),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: expenseTotal,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(),
                      decoration: const InputDecoration.collapsed(
                        hintText: "Enter total budget",
                        border: InputBorder.none,
                      ),
                    )),
                    const VerticalDivider(color: Colors.blue),
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
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Color.fromARGB(228, 245, 245, 245),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 18, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.title, color: Colors.grey),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: title,
                      style: GoogleFonts.poppins(),
                      decoration: const InputDecoration.collapsed(
                        hintText: "Enter expense title",
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                  color: Color.fromARGB(228, 245, 245, 245),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: expenseDesc,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.poppins(),
                      decoration: const InputDecoration.collapsed(
                        hintText: "Enter expense description",
                        border: InputBorder.none,
                      ),
                    )
                  ],
                ),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Reset',
                        style: GoogleFonts.poppins(fontSize: 18)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (title.text.length > 1) {
                        await controller.addExpense(
                            title.text, expenseDesc.text, expenseTotal.text);
                        await homeController.grafikYuzdeHesaplama();
                      }

                      Get.back();
                    },
                    child: Text('Save',
                        style: GoogleFonts.poppins(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class category_widget extends StatelessWidget {
  category_widget(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.containerColor,
      required this.isSelected})
      : super(key: key);

  final String imageUrl;
  final String title;
  final Color containerColor;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: isSelected
              ? MediaQuery.of(context).size.width * 0.20
              : MediaQuery.of(context).size.width * 0.18,
          height: isSelected
              ? MediaQuery.of(context).size.height * 0.15
              : MediaQuery.of(context).size.height * 0.095,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: containerColor.withOpacity(0.33),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imageUrl,
                width: 25,
                height: 25,
              ),
              Text(
                title,
                style: TextStyle(
                    color: containerColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 30,
        )
      ],
    );
  }
}
