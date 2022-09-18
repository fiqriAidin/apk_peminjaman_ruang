import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:peminjaman_ruang/pages/login.dart';
import 'package:peminjaman_ruang/components/button_widget.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Kemudahan mengakses',
              body: 'Dapat di akses dimana saja dan kapan saja',
              image: buildImage('img/ebook.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Kemudahan pengelolahan',
              body: 'Mempermudah dalam mengelola data yang tersimpan',
              image: buildImage('img/readingbook.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Simple UI',
              body: 'UI yang mudah untuk di pahami bagi semua orang',
              image: buildImage('img/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Informasi adalah kunci penting menangkan pertarungan',
              body: 'Mulai pengalamanmu',
              footer: ButtonWidget(
                text: 'Start Login',
                onClicked: () => goToLogin(context),
              ),
              image: buildImage('img/learn.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: const Text('Login', style: TextStyle(color: Colors.black)),
          onDone: () => goToLogin(context),
          showSkipButton: true,
          skip: const Text('Skip', style: TextStyle(color: Colors.black)),
          onSkip: () => goToLogin(context),
          next: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          dotsDecorator: getDotDecoration(),
          // onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Colors.white,
          skipOrBackFlex: 0,
          nextFlex: 0,
        ),
      );

  void goToLogin(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Login()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color(0xFFBDBDBD),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle:
            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 20),
        bodyPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
