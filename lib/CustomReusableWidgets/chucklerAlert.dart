/*showDialog(
context: context,
builder: (BuildContext context) {
return Center(
child: AlertDialog(
shape:
const RoundedRectangleBorder(
borderRadius:
BorderRadius.all(
Radius.circular(
20))),
backgroundColor:
const Color.fromARGB(
255, 20, 20, 20),
title:
const Text('Confirmation'),
titleTextStyle: const TextStyle(
fontWeight: FontWeight.bold,
color: Color(0xFFffd230),
fontSize: 22),
content: const Text(
'Are you sure you want to report this post?'),
contentTextStyle:
const TextStyle(
fontSize: 14,
color: Colors.white),
actions: [
ElevatedButton(
style: ElevatedButton
    .styleFrom(
foregroundColor:
Colors.black,
backgroundColor:
const Color(
0xFFffd230)),
child: const Text('Cancel'),
onPressed: () {
Navigator.of(context)
    .pop();
},
),
ElevatedButton(
style: ElevatedButton
    .styleFrom(
foregroundColor:
Colors.black,
backgroundColor:
Colors.white,
),
child: const Text('Yes'),
onPressed: () async {
//TODO ADD REPORTED FUNCTIONALLITY
print("Reported");
Navigator.of(context)
    .pop();
},
),
],
),
);
},
);*/