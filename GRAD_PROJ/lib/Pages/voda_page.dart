import 'package:flutter/material.dart';
import 'package:gradproject/Pages/Pay_done.dart';

class VodaPage extends StatefulWidget {
  const VodaPage({super.key});

  @override
  _VodaPageState createState() => _VodaPageState();
}

class _VodaPageState extends State<VodaPage> {
  double _dragPosition = 0.0;
  final double _maxDragPosition = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            border: Border.all(width: 0),
            color: const Color.fromARGB(255, 197, 19, 6),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 5),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 60),
                    const Text(
                      'Vodafone Cash',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 110.0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "- You can also pay with any other Digital Wallets ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "- Make sure to save the image for the conversion ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 200.0, left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Doctor`s phone : 01012351266',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 280.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 234, 234, 234),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter price',
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: const OutlineInputBorder(),
                                ),
                                items: ['USD', 'EUR', 'EGP']
                                    .map((currency) => DropdownMenuItem(
                                          value: currency,
                                          child: Text(currency),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                                hint: const Text("Currency"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 55),
                        const Text(
                          "Your phone number",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: const OutlineInputBorder(),
                            hintText: 'Enter your phone number',
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 620.0, left: 50),
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _dragPosition += details.delta.dx;
                      if (_dragPosition < 0) {
                        _dragPosition = 0;
                      } else if (_dragPosition > _maxDragPosition) {
                        _dragPosition = _maxDragPosition;
                      }
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_dragPosition >= _maxDragPosition) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PayDone()),
                      );
                    }
                    setState(() {
                      _dragPosition = 0;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: _maxDragPosition +
                            50, // Add extra space for the button size
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 0),
                                width: _dragPosition >= _maxDragPosition
                                    ? double.infinity
                                    : _dragPosition,
                                height: double.infinity,
                                color: Colors.red,
                              ),
                              const Center(
                                child: Text(
                                  'Slide to Proceed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: _dragPosition,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.red,
                                size: 30, // Increase the size to make it bolder
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
