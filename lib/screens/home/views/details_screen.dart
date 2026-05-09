import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Đảm bảo đường dẫn import này khớp với cấu trúc thư mục của bạn
import '../../../components/marco.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Ảnh sản phẩm
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/1.png'), // Đảm bảo file ảnh tồn tại trong assets
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Nội dung chi tiết
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Tên và Giá
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Truffle Temptation Extravaganza",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$12.00",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const Text(
                                "\$15.00",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Các chỉ số Macro (Đã bỏ 'const' để tránh lỗi IconData)
                    Row(
                      children: [
                        MyMacroWidget(
                          title: 'Calories',
                          value: 267,
                          icon: FontAwesomeIcons.fire,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: 'Protein',
                          value: 36,
                          icon: FontAwesomeIcons.dumbbell,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: 'Fat',
                          value: 21,
                          icon: FontAwesomeIcons.oilWell,
                        ),
                        SizedBox(width: 10),
                        MyMacroWidget(
                          title: 'Carbs',
                          value: 38,
                          icon: FontAwesomeIcons.breadSlice,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Nút mua hàng
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () {

                        },
                        style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                        ),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}