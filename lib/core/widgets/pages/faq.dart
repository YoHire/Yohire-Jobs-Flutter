import 'package:flutter/material.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/widgets/theme_gap.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Frequently Asked Questions',
          style: textTheme.bodyMedium!.copyWith(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildQuestion(
            context,
            "1. How to register?",
            "You can register easily by clicking on the google icon and selecting your google account, after that verify your phone number with otp",
          ),
          Image.asset('assets/images/faq1.jpeg'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "2. How to create my profile?",
            "After registering, navigate to the profile menu by clicking on the rightmost icon in the bottom menu. There will be a prompt showing to update the profile. Fill in your details accordingly to complete your profile.",
          ),
          Image.asset('assets/images/faq2.png'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "3. How to re-edit my profile?",
            "In the profile page, you can edit your profile individually by clicking on the relevant icon from the group of profile sub-sections.",
          ),
          Image.asset('assets/images/faq3.jpeg'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "4. How to apply for jobs?",
            "You can seamlessly apply for jobs if your profile is completed. Click on the job card that you want to apply for and click on 'Apply Now'. You will be asked for the application method; you can either apply using coins or cash.",
          ),
          Image.asset('assets/images/faq4.png'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "5. Where can I track my applied jobs?",
            "You can track the applied jobs by clicking on the applied section icon, which is the second icon in the bottom menu.",
          ),
          Image.asset('assets/images/faq5.jpeg'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "6. How can I search for a specific job?",
            "You can search for jobs using the search bar on the home screen.",
          ),
          Image.asset('assets/images/faq6.jpeg'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "7. If I save a job, where can I see it again?",
            "You can view the saved jobs in the saved menu on the profile page.",
          ),
          Image.asset('assets/images/faq7.png'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "8. Why couldn't i apply  for the job?",
            "Either your profile is incomplete or you don't have enough coin balance. If the issue persists, please contact customer service.",
          ),
          _buildQuestion(
            context,
            "9. How can I get job advertisements according to my preference?",
            "You can edit the job preference in the profile to receive customized job advertisements.",
          ),
          Image.asset('assets/images/faq8.png'),
          // const ThemeGap(20),
          // _buildQuestion(
          //   context,
          //   "10. If YoHire is a free platform, why are there coins?",
          //   "YoHire is not completely a free platform. Job seekers can earn coins unlimited times through referrals and other sources. These coins can be used to apply for jobs within the app, enhancing the job-seeking experience.",
          // ),
          // Image.asset('assets/images/faq9.png'),
          const ThemeGap(20),
          _buildQuestion(
            context,
            "10. Why was my application unsuccessful?",
            "Recruiters can view some key criteria from your resume before downloading it. If the recruiters do not find your resume matching the job requirements, the non-download of your resume before the job expires or the deletion of the job will lead to an unsuccessful application, and the coin you used to apply will be refunded.",
          ),
          const ThemeGap(20),
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String question, String answer) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: textTheme.headlineLarge!
                .copyWith(color: ThemeColors.primaryBlue),
          ),
          const SizedBox(height: 10),
          Text(
            answer,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
