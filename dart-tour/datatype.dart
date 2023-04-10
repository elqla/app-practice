void main() {
  // !Basic data types
  String name = 'nico';
  bool alive = true;
  int age = 12;
  double money = 12.44;
  //객체지향언어
  num x = 12;
  x = 1.1;

  // !Lists
  var giveMeFive = true;
  var listnum = [
    1,
    2,
    3,
    4,
    if (giveMeFive) 5, // shortcut
  ];
  if (giveMeFive) {
    listnum.add(5);
  }

  List<int> numberss = [1, 2, 3, 4];
  numberss.add(1);
  // numberss.first //첫번째 요소

  // !String interpolation
  var niconame = 'nico';
  var nicoage = 10;
  var greeting =
      'hello, name is $niconame, i\'m nice to meet you! ${nicoage + 2}세야';
  print(greeting);

  // !Collection For
  var oldFriends = ['nico', 'lynn'];
  var newFriends = [
    'lewis',
    'ralph',
    'darren',
    for (var friend in oldFriends) "♡ $friend",
  ];
  print(newFriends);

  // !Maps - key, value를 가지는 구조로 object를 만들때 특히 API로 가져온 데이터라면 Map보단 Class를 추천함.
  var player = {
    'name': 'nico',
    'xp': 19.99,
    'superpower': false, // Object (like any)
  };
  Map<int, bool> custom = {
    1: true,
    2: false,
  };
  Map<List<int>, bool> play = {
    [1, 2, 3, 4]: true,
  };
  List<Map<String, Object>> testP = [
    {
      'name': 'nico',
      'wow': 123,
    },
    {
      'name': 'nico',
      'wow': 123,
    },
  ];

// !Sets
  Set<int> numbers = {1, 2, 3, 4};
  var numTest = {1, 2, 3, 4, 5};
  numTest.add(1);
  numTest.add(1);
  print(numTest);
}
