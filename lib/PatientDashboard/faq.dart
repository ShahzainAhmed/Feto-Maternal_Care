import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Text("FAQ'S"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Q:1 Which trimester would you say is the hardest for the mother?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "The first trimester of pregnancy can often be the hardest. Pregnancy hormones, extreme fatigue, nausea and vomiting, tender breasts, and perpetually needing to wee make life growing a human no easy feat",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Q:2 Can I exercise when pregnant?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Yes, you can! Staying active is good for you and your baby. It can help you control weight gain, improve fitness, reduce high blood pressure, improve sleep, and improve your mood. All good!",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Q:3 When will I start to feel the baby kicking?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Most mums feel the first fidgets of their wee one – known as ‘quickening’ – between weeks 14 and 26 of their pregnancy, but it does vary. After those first little flurries, you’ll get to know your own baby’s pattern of movements. Remember, you can talk to your midwife about what to expect. And you’ll probably start to feel your bond with your baby growing as you get use to their movements.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Q:4 I'm 9 months pregnant. How do I overcome fatigue and tiredness?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "It is quite a common symptom. Don't stress. Practice butterfly and Kegel's exercises. You can also do housework like squatting and mopping.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Q:5 I'm 6 months pregnant and experience shortness in breathing?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Stay hydrated and avoid physical exertion and standing for too long.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Q:6 I'm 8 weeks pregnant and experiencing abdominal pain and nausea.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Both are normal symptoms of first trimester. Consult your doctor for medication.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Q:7 Third Trimester?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "The third trimester can be the most nerve-wracking of the three trimesters. As your due date approaches, you may start to have a lot of questions for your doctor. Fortunately, you’ll be seeing your doctor more frequently during your third.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Q:8 What are the first symptoms of pregnancy?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "The third trimester can be the most nerve-wracking of the three trimesters. As your due date approaches, you may start to have a lot of questions for your doctor. Fortunately, you’ll be seeing your doctor more frequently during your third.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
