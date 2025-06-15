import 'package:flutter/material.dart';
import 'package:gradproject/Pages/filter.dart';
import 'package:gradproject/constants.dart';

class SearchField extends StatefulWidget {
  const SearchField(
      {super.key,
      this.padding = 12.0,
      this.hint = 'Serach for Doctor',
      this.radius = 5,
      this.fillcolor = const Color.fromARGB(255, 243, 241, 241),
      this.iconColor = Colors.grey,
      this.onSubmitted});
  final double padding;
  final String hint;
  final double radius;
  final Color fillcolor;
  final Color iconColor;
  final void Function(String)? onSubmitted;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String? selected;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: widget.padding),
        hintText: widget.hint,
        hintStyle: const TextStyle(fontSize: 13),
        suffixIcon: PopupMenuButton(
          onSelected: (value) {
            selected = value;
            print(selected);
            if (selected == 'specialization') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Filter(listType: kSpecialist, type: 'specialization'),
                ),
              );
            } else if (selected == 'gender') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Filter(
                      listType: ['male', 'female'], type: 'gender'),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Filter(
                      listType: ['ismailia', 'cairo'], type: 'city'),
                ),
              );
            }
          },
          icon: const Icon(Icons.tune),
          elevation: 0,
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 'specialization',
                child: Text('specialization'),
              ),
              PopupMenuItem(
                value: 'city',
                child: Text('city'),
              ),
              PopupMenuItem(
                value: 'gender',
                child: Text('gender'),
              ),
            ];
          },
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 26,
          color: Color(0xff3d8888),
        ),
        prefixIconColor: widget.iconColor,
        filled: true,
        fillColor: const Color.fromARGB(255, 243, 241, 241),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(widget.radius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.fillcolor,
            ),
            borderRadius: BorderRadius.circular(widget.radius)),
      ),
    );
  }
}
