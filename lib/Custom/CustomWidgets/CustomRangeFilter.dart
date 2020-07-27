import "package:flutter/material.dart";

/// A RangeFilter with custom decorations.
class CustomRangeFilter extends StatelessWidget {
  final String title;
  final String unit;
  final double min;
  final double max;
  final RangeValues selectedRange;
  final int divisions;
  final Function onChanged;

  CustomRangeFilter({
    @required this.title,
    @required this.unit,
    @required this.min,
    @required this.max,
    @required this.selectedRange,
    @required this.divisions,
    @required this.onChanged
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffFFE5E7),
                  ),
                  child: Center(child: Text("${selectedRange.start.round()}")),
                ),
                SizedBox(width: 5),
                Container(
                  child: Text("to"),
                ),
                SizedBox(width: 5),
                Container(
                  width: 40,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffFFE5E7),
                  ),
                  child: Center(child: Text("${selectedRange.end.round()}")),
                ),
                SizedBox(width: 5),
                Container(
                  child: Text(unit),
                ),
              ],
            ),
          ],
        ),
        RangeSlider(
          values: selectedRange,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: Colors.redAccent,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
