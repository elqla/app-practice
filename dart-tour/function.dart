//## defining a function

void sayHello(String name) {
  print('Hello $name nice to meet you!');
  //! void dosent return anything
}

String funcRString(String name) => '$name';

num plus(num a, num b) => a + b;

// ## positional parameters
String notnamedFunc(String name, int age, String country) {
  return "Hello $name, You are $age, from $country";
// print(notnamedFunc('nico', 1, '대한민국')); // 좋은 방법이 아님.
}

// ## named parameters
// null safety: defualt value, required
String namedFunc(
    {required String name, required int age, required String country}) {
  return "Hello $name, You are $age, from $country";
  // print(namedFunc(age: 12, country: 'cuba', name: "nico"));
}

// ## optional positional parameters
String positionalFunc(String name, int age, [String? country = 'cuba']) =>
    "$name 입니다.$age입니다. from $country";
// positionalFunc('니코', 12);

// ## QQ Operator
String capitalizeName([String? name]) => name?.toUpperCase() ?? "ANON";
// name != null ? name.toUpperCase() : 'ANON';
// print(capitalizeName('nico'));
// print(capitalizeName(null));

void qqoperator() {
  String? name;
  name ??= 'nico';
  name = null;
  name ??= 'another';
  print(name);
}

// ## typedef
// List<int>라고 선언해주는 것 매우 도움됨
typedef ListOfInts = List<int>;
List<int> reverseListOfNumbers(ListOfInts list) {
  var reversed = list.reversed;
  return reversed.toList();
}

// print(reverseListOfNumbers([1, 2, 3]));
//이렇게 써도 되지만 class로 쓰는거 추천 => Structure data
typedef UserInfo = Map<String, String>;
String sayHi(UserInfo userInfo) {
  return "hi ${userInfo['name']}";
}

void main() {
  print(sayHi({'name': 'nico'}));
}
