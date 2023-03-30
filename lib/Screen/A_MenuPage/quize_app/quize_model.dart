class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "What is the main purpose of a CRM system?",
    [
      Answer("To manage customer relationships", true),
      Answer("To manage employee schedules", false),
      Answer("To manage financial records", false),
      Answer("To manage inventory levels", false),
    ],
  ));

  list.add(Question(
    "Which of the following is a common feature of a CRM system?",
    [
      Answer("Inventory management", false),
      Answer("Employee payroll management", false),
      Answer("Marketing campaign management", true),
      Answer("Website design and development", false),
    ],
  ));

  list.add(Question(
    "What are some common challenges businesses may face when implementing a CRM system?",
    [
      Answer("Lack of budget and resources", false),
      Answer("Limited employee training and knowledge", false),
      Answer("Resistance to change from employees", false),
      Answer(" All of the above", true),
    ],
  ));

  list.add(Question(
    "How can a CRM system help improve customer retention?",
    [
      Answer("By providing personalized communication and engagement with customers", true),
      Answer("By reducing product prices", false),
      Answer("By reducing the number of products offered", false),
      Answer("By reducing the number of products offered", false),
    ],
  ));

  return list;
}