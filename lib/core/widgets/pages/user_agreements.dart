import 'package:flutter/material.dart';
import 'package:openbn/core/utils/constants/constants.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Agreement',
          style: textTheme.bodyMedium,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('YOHIRE USER AGREEMENT',context),
                _buildSectionContent('''Last Updated: October 27, 2024

INTRODUCTION
Welcome to Yohire, your innovative job search platform that connects talented professionals with great opportunities. Before you begin your journey with us, please take a moment to review this User Agreement ("Agreement").

This Agreement outlines the terms and conditions governing your use of Yohire's services, including our website, mobile application, job queue system, and all related features (collectively referred to as the "Service"). By using Yohire, you're joining a community that values transparency, professionalism, and meaningful connections between job seekers and employers.

What This Agreement Covers:
● Your rights and responsibilities as a Yohire user
● How you can use our platform
● How we protect your information
● What you can expect from our services
● Important legal requirements

By creating an account, accessing, or using any part of Yohire's services, you acknowledge that you have read, understood, and agree to be bound by this Agreement. If you do not agree with these terms, please do not use our Service.

For your convenience, we've written this Agreement in clear, straightforward language. However, if you have any questions, please contact our support team at [contact information].'''),
                _buildSectionTitle('ACCEPTANCE OF TERMS',context),
                _buildSectionContent('''1. Binding Agreement
This User Agreement ("Agreement") constitutes a legally binding contract between you ("User," "you," or "your") and Yohire ("Company," "we," "us," or "our"). By accessing or using the Yohire platform, including but not limited to creating an account, browsing job opportunities, joining job queues, uploading profile information, or utilizing any feature of our mobile application or website, you expressly acknowledge and agree to be bound by this Agreement. Furthermore, clicking "I Agree," "Sign Up," or similar affirmative buttons constitutes your explicit acceptance of these terms.'''),
                _buildSectionContent('''2. Age and Capacity Requirements
You hereby represent and warrant that you meet all eligibility requirements for entering into this Agreement. Specifically, you affirm that you are at least eighteen (18) years of age, possess the legal capacity to enter into binding contracts, and are not prohibited from using our services under any applicable laws, regulations, or other governmental directives.'''),
                _buildSectionContent('''3. Additional Terms
Your use of the Yohire platform is additionally governed by supplementary policies and agreements incorporated herein by reference, including but not limited to our Privacy Policy, Cookie Policy, and any service-specific terms and conditions that may be implemented from time to time. These supplementary terms, together with this Agreement, constitute the entire agreement between you and Yohire regarding your use of our services.'''),
                _buildSectionContent('''4. Updates and Modifications
Yohire reserves the right, at its sole discretion, to modify or replace this Agreement at any time. You acknowledge and agree that your continued use of the service following the posting of any modifications to this Agreement constitutes your acceptance of such modifications. We shall notify you of material changes to these terms via electronic mail to your registered email address or through in-app notifications. You agree to periodically review this Agreement to ensure your continued compliance.'''),
                _buildSectionContent('''5. Non-Acceptance
In the event that you do not agree with any portion of this Agreement or any subsequent modifications thereto, you must immediately cease all use of the Service. This includes, but is not limited to, discontinuing use of our platform, refraining from creating an account, and contacting us at hello@yohire.in to request deletion of any existing account.'''),
                _buildSectionContent('''6. Electronic Communications
By accepting this Agreement, you expressly consent to receiving electronic communications from Yohire. These communications may include, but are not limited to, email notifications regarding job opportunities, system updates, service-related messages, and marketing communications (subject to your right to opt-out of marketing messages). You acknowledge that such electronic communications shall satisfy any legal requirement that such communications be in writing.'''),
                _buildSectionContent('''7. Legal Effect
This Agreement, upon your acceptance, constitutes a legally binding contract between you and Yohire, enforceable in accordance with its terms. Should you have any questions regarding this Agreement, please contact our legal department at hello@yohire.in.

The foregoing terms and conditions are hereby agreed to and accepted by you upon your use of the Service or by clicking any affirmative button indicating acceptance.'''),
                _buildSectionTitle('ELIGIBILITY',context),
                _buildSectionContent(
                    '''1. Basic Requirements and Representations
The User hereby represents and warrants that they meet all basic eligibility requirements for utilizing the Yohire platform ("Platform"). Specifically, the User affirms that they: (i) are at least eighteen (18) years of age; (ii) have completed or are actively pursuing a recognized educational qualification from an accredited institution; (iii) possess legal authorization to work in their country of residence; (iv) maintain a valid, operational email address; and (v) can, upon request, furnish authentic identification documents that verify their identity and eligibility status.'''),
                _buildSectionContent(
                    '''2. Professional Requirements and Standards
In furtherance of maintaining the integrity and professional quality of the Yohire talent pool, Users shall be required to meet and maintain certain professional standards. These standards mandate that Users: (i) create and maintain a complete and accurate professional profile; (ii) provide verifiable work experience documentation, where applicable; (iii) submit and maintain a genuine, current resume or curriculum vitae; (iv) maintain current and accurate contact information; and (v) demonstrate genuine intent to seek employment through the Platform.'''),
                _buildSectionContent('''3. Account Integrity and Warranties
The User hereby certifies and warrants that they shall: (i) maintain only one (1) active account on the Platform; (ii) provide truthful, accurate, and current information in all Platform interactions; (iii) represent themselves solely as an individual job seeker and not as a corporate entity; (iv) affirm they have not previously been subject to account termination or platform ban; and (v) refrain from any misrepresentation of qualifications, experience, or other professional credentials.'''),
                _buildSectionContent('''4. Prohibited Users and Activities
Access to and use of the Platform is expressly prohibited for individuals who: (i) are under eighteen (18) years of age; (ii) provide false, misleading, or fraudulent information; (iii) represent recruitment agencies without explicit prior authorization from Yohire; (iv) have previously had their account terminated for violations of Platform terms; (v) attempt to create accounts for fraudulent purposes; or (vi) are legally restricted from seeking employment under applicable laws.'''),
                _buildSectionContent('''5. Verification Rights and Procedures
Yohire expressly reserves the right, at its sole discretion, to: (i) verify any and all information provided by Users; (ii) request additional documentation or verification materials; (iii) suspend accounts pending completion of verification procedures; (iv) terminate accounts that fail to meet verification requirements; and (v) conduct background checks where legally permissible, subject to applicable laws and regulations.'''),
                _buildSectionContent('''6. Special Category Requirements
Certain job categories may be subject to additional eligibility requirements, including but not limited to: (i) professional certifications; (ii) security clearances; (iii) industry-specific qualifications; (iv) language proficiency certifications; and (v) valid work permits or visas. Users applying for positions within these special categories must meet and maintain all additional eligibility requirements specific to such positions.'''),
                _buildSectionContent('''7. Changes in Eligibility Status
Users hereby acknowledge and agree to: (i) promptly notify Yohire of any changes that may affect their eligibility status; (ii) update their profile information to reflect any changes in qualifications or credentials; (iii) immediately inform Yohire if they become legally restricted from seeking employment; and (iv) voluntarily remove their profile upon becoming ineligible for Platform use.'''),
                _buildSectionContent('''8. Legal Compliance
User eligibility shall at all times comply with: (i) applicable local employment laws and regulations; (ii) immigration laws and requirements; (iii) professional licensing and certification requirements; (iv) industry-specific regulations and standards; and (v) applicable data protection and privacy laws. Users shall be solely responsible for maintaining compliance with all applicable legal requirements affecting their eligibility status.

Any violation of these eligibility requirements may result in immediate suspension or termination of the User's account, at Yohire's sole discretion. Yohire reserves the right to modify these eligibility requirements at any time, with notice to Users as specified in the Modifications section of this Agreement.

The foregoing eligibility requirements are material terms of this Agreement, and continued compliance with such requirements is necessary for continued use of the Platform.'''),
                _buildSectionTitle(
                    'ACCOUNT REGISTRATION, USER CONDUCT, AND PROFILE MANAGEMENT',context),
                _buildSectionContent('''I. ACCOUNT REGISTRATION AND MAINTENANCE

A. Registration Requirements
The User shall provide complete and accurate registration information, including without limitation: (i) legal name; (ii) valid email address; (iii) current contact information; (iv) professional designation; (v) geographic location; and (vi) intended employment categories. The User acknowledges and expressly agrees that all profile information shall be accessible to and viewable by all companies registered on the Yohire platform.

B. Profile Documentation Requirements
The User shall furnish the following mandatory documentation: (i) current professional
photograph; (ii) comprehensive curriculum vitae; (iii) educational credentials; (iv) detailed
employment history; (v) professional certifications; (vi) language competencies; and (vii)
portfolio materials, where applicable.

C. Security and Authentication
1. Password Requirements: Users shall create and maintain passwords that meet minimum
security requirements, including: (i) minimum length of eight (8) characters; (ii)
2. alphanumeric combinations; (iii) special characters; and (iv) case sensitivity. Such
passwords must not substantially replicate the User's email address or username.
Security Obligations: Users shall: (i) maintain strict confidentiality of login credentials; (ii)
prohibit unauthorized account access; (iii) ensure logout from shared devices; (iv)
promptly report security breaches; and (v) enable additional security measures as
recommended.

D. Verification Procedures
1. 2. Email Verification: Users must complete email verification within forty-eight (48) hours of
registration by: (i) accessing the verification link provided; and (ii) completing the
verification process as specified.
Phone Verification: Users shall: (i) verify their mobile number through one-time password
authentication; (ii) maintain current contact information; and (iii) manage notification
preferences as desired.'''),
                _buildSectionTitle('USER CONDUCT AND OBLIGATIONS',context),
                _buildSectionContent('''
A. Professional Standards

Users shall maintain professional conduct, including: (i) honest representation; (ii) respect for
privacy; (iii) adherence to platform guidelines; and (iv) good faith engagement in all platform
activities.
'''),
                _buildSectionContent('''
B. Prohibited Activities

1, Profile Violations: Users shall not engage in: (i) false information provision; (ii) credential
falsification; (iii) identity misrepresentation; (iv) multiple account creation; or (v)
inappropriate content posting.

2, Communication Violations: Prohibited activities include: (i) harassment; (ii)
discrimination; (iii) spam distribution; (iv) threatening behavior; (v) unauthorized
information sharing; and (vi) automated messaging

3, Platform Violations: Users shall not: (i) scrape platform data; (ii) reverse engineer
platform functionality; (iii) employ automated tools; (iv) circumvent security measures; or
(v) interfere with platform operations
'''),
                _buildSectionContent('''
C. Job Application Protocol

1, Professional Conduct: Users shall: (i) apply only to suitable positions; (ii) honor interview
commitments; (iii) maintain prompt communication; and (iv) properly manage application
statuses.

2, Company Interactions: Users must: (i) maintain professional communication; (ii) honor
scheduled commitments; (iii) preserve confidentiality; and (iv) adhere to
company-specific protocols.
'''),
                _buildSectionTitle('PROFILE AND QUEUE MANAGEMENT',context),
                _buildSectionContent('''
A. Profile Requirements

1, Mandatory Elements: Profiles must contain: (i) complete contact information; (ii) current
employment status; (iii) comprehensive work history; (iv) educational credentials; (v)
professional certifications; (vi) geographic preferences; and (vii) compensation
expectations.

2, Visibility Parameters: Users acknowledge that: (i) profiles are visible to all registered
companies; (ii) information may be downloaded and stored by companies; and (iii)
contact details are accessible to verified employers.
'''),
                _buildSectionContent('''
B. Queue System Operations

1, Entry and Positioning: Queue placement is determined by: (i) profile completeness; (ii)
update frequency; (iii) skill alignment; (iv) experience relevance; and (v) platform
engagement metrics.

2, Management Rights: Users may: (i) monitor queue positions; (ii) receive status updates;
(iii) modify queue participation; and (iv) access priority queues where applicable.
'''),
                _buildSectionContent('''
C. Profile Discovery and Promotion

1, Search Parameters: Profiles shall be: (i) included in company searches; (ii) featured in
talent pools; (iii) matched to relevant positions; and (iv) filtered by industry and location
preferences.

2, Profile Optimization: Enhanced visibility is achieved through: (i) profile completeness; (ii)
regular updates; (iii) skill verification; and (iv) active platform engagement.
'''),
                _buildSectionContent('''
D. Privacy and Data Management

1, Information Control: Users maintain rights to: (i) manage visible information; (ii) control
privacy settings; (iii) manage contact preferences; and (iv) adjust notification parameters.

2, Data Access and Retention: Users acknowledge that: (i) companies may store profile
information; (ii) usage tracking is implemented; (iii) access logs are maintained; and (iv)
data retention policies apply.
'''),
                _buildSectionContent('''
E. Enforcement and Compliance

1, Violation Consequences: The Platform may impose: (i) immediate suspension; (ii) queue
removal; (iii) visibility restrictions; (iv) account termination; and (v) legal action where
applicable.

2, Compliance Requirements: Users shall: (i) report violations; (ii) cooperate with
investigations; (iii) provide requested information; and (iv) comply with enforcement
decisions. The foregoing terms regarding account registration, user conduct, and profile management
constitute material provisions of this Agreement. Violation of any provision may result in
immediate account suspension or termination, at Yohire's sole discretion.
'''),
                _buildSectionTitle('PRIVACY AND DATA USAGE AGREEMENT',context),
                _buildSectionContent('''I. DATA COLLECTION AND PROCESSING

A. Information Collection Scope
1. Personal Information Collection: Yohire ("Platform") shall collect and process the following personal information: (i) full legal name and professional title; (ii) contact information including email address and telephone number; (iii) professional photograph; (iv) date of birth; (v) geographic location data; (vi) educational credentials; (vii) employment history; (viii) professional certifications; (ix) compensation requirements; (x) curriculum vitae; and (xi) portfolio materials.
2. Automated Data Collection: The Platform automatically collects: (i) access timestamps; (ii) usage metrics; (iii) device specifications; (iv) IP addresses; (v) geolocation data; (vi) application interactions; and (vii) response metrics.'''),
                _buildSectionTitle('II. DATA USAGE AND PROCESSING',context),
                _buildSectionContent('''A. Primary Data Processing
The Platform shall process User data for the following purposes: 1. Company Display, 2. Matching Services, 3. Queue Management, 4. Analytics, 5. Communications, and 6. Platform Enhancement.'''),
                _buildSectionTitle('III. USER RIGHTS AND LIMITATIONS',context),
                _buildSectionContent('''A. User Data Rights
Users maintain the following rights regarding their data: Modification Rights, Visibility Control, Data Access, Activity Monitoring, Communication Control, Account Termination.'''),
                _buildSectionTitle('IV. DATA SECURITY AND PROTECTION',context),
                _buildSectionContent('''A. Platform Security Measures
The Platform implements the following security measures: Data Encryption, Secure Transmission, Security Audits, Access Controls, Breach Detection, Data Recovery.'''),
                _buildSectionTitle('V. DATA SHARING AND RETENTION',context),
                _buildSectionContent('''A. Data Sharing Scope
1. Internal Sharing: Between Platform features, functions, and authorized service providers. 2. External Sharing: With registered companies, legal authorities as required, and during corporate transactions.'''),
                _buildSectionTitle(
                    'INTELLECTUAL PROPERTY RIGHTS AND OWNERSHIP',context),
                _buildSectionContent('''I. PLATFORM INTELLECTUAL PROPERTY
A. Proprietary Rights: Yohire ("Platform") retains exclusive ownership of platform software, technology, and all intellectual property related to its operations.'''),
                _buildSectionTitle(
                    'ACCOUNT TERMINATION AND POST-TERMINATION OBLIGATIONS',context),
                _buildSectionContent('''I. TERMINATION CATEGORIES AND PROCEDURES
A. Termination Types: 1. User-Initiated Termination, 2. Platform-Initiated Termination, 3. Automatic Termination based on violations.'''),
                _buildSectionTitle('DISCLAIMER AND LIMITATIONS OF LIABILITY',context),
                _buildSectionContent('''I. SERVICE DISCLAIMERS
A. Platform Operations Disclaimer: The Platform is provided "AS IS" and disclaims any warranties, including uninterrupted service and error-free operation.'''),
                _buildSectionTitle('MODIFICATIONS AND GOVERNING LAW',context),
                _buildSectionContent('''I. PLATFORM MODIFICATIONS
A. Service Modification Rights: The Platform reserves the right to modify or alter platform features, user interface elements, and platform functionality at its sole discretion.'''),
                _buildSectionTitle('VI. POST-TERMINATION RIGHTS',context),
                _buildSectionContent(
                    '''A. Immediate Consequences: Upon termination, the following actions shall occur: removal of profile from search results, cancellation of active applications, revocation of login access, and closure of communication channels.'''),
                _buildSectionContent(
                    '''B. Post-Termination Obligations: Users shall cease all platform usage, discontinue use of related services, and honor confidentiality obligations.'''),
                _buildSectionTitle('II. DATA MANAGEMENT AND RETENTION',context),
                _buildSectionContent(
                    '''A. Data Handling Procedures: Upon termination, the Platform shall remove profile information, delete applicable documents, archive messages, and maintain application history as required.'''),
                _buildSectionContent(
                    '''B. Information Retention: The Platform shall retain legal compliance records, dispute resolution data, security incident records, and usage statistics.'''),
                _buildSectionTitle('IV. ACCOUNT REACTIVATION AND APPEALS',context),
                _buildSectionContent(
                    '''A. Reactivation Rights: Users may request account recovery within thirty (30) days of termination and must complete verification procedures.'''),
                _buildSectionContent(
                    '''B. Appeals Process: Users may submit appeals within specified time limits, with supporting evidence, for conditional reinstatement or final termination confirmation.'''),
                _buildSectionTitle('V. LEGAL AND FINANCIAL IMPLICATIONS',context),
                _buildSectionContent(
                    '''A. Legal Considerations: Surviving obligations include confidentiality duties, intellectual property rights, data protection obligations, and dispute resolution terms.'''),
                _buildSectionContent(
                    '''B. Financial Matters: Users remain responsible for outstanding fees, service charges, and premium feature costs, if applicable.'''),
                _buildSectionTitle('VI. REREGISTRATION POLICIES',context),
                _buildSectionContent(
                    '''A. New Registration Requirements: Users must follow mandatory waiting periods and verification requirements if re-registering after voluntary or involuntary termination.'''),
                _buildSectionTitle('DISCLAIMERS AND LIMITATIONS OF LIABILITY',context),
                _buildSectionContent('''I. SERVICE DISCLAIMERS
A. Platform Operations Disclaimer: The Platform is provided "AS IS" and "AS AVAILABLE." Yohire disclaims all warranties regarding service continuity, error-free operation, or feature availability.'''),
                _buildSectionContent(
                    '''B. Employment-Related Disclaimers: Yohire does not guarantee job placements, interview outcomes, or salary results. Users acknowledge that job-seeking carries inherent risks.'''),
                _buildSectionTitle('II. COMPANY INTERACTIONS AND INFORMATION',context),
                _buildSectionContent(
                    '''A. Company Conduct: Yohire disclaims responsibility for company hiring decisions, workplace conditions, and communication processes.'''),
                _buildSectionContent(
                    '''B. Information Accuracy: Yohire does not guarantee the accuracy of company profiles, job postings, salary data, or company credentials.'''),
                _buildSectionTitle('III. LIABILITY LIMITATIONS',context),
                _buildSectionContent(
                    '''A. Financial and Professional Limitations: Yohire shall not be liable for lost job opportunities, career impacts, economic losses, or professional setbacks.'''),
                _buildSectionContent(
                    '''B. Maximum Liability: The Platform’s liability is limited to fees paid by the user and excludes consequential or punitive damages.'''),
                _buildSectionTitle('IV. DATA AND PRIVACY LIMITATIONS',context),
                _buildSectionContent(
                    '''A. Data Security Limitations: Yohire disclaims liability for unauthorized data access, third-party data use, or company retention of user information.'''),
                _buildSectionContent(
                    '''B. Profile Visibility Limitations: Yohire cannot control data downloads or restrict company access to user profiles.'''),
                _buildSectionTitle('V. TECHNICAL AND OPERATIONAL LIMITATIONS',context),
                _buildSectionContent(
                    '''A. Platform Performance: Yohire disclaims liability for system downtime, server issues, or mobile application problems.'''),
                _buildSectionContent(
                    '''B. User Experience Variations: Users may experience differences in interface design, feature availability, and queue positions.'''),
                _buildSectionTitle('VI. PROFESSIONAL SERVICE LIMITATIONS',context),
                _buildSectionContent(
                    '''A. Career Services Limitations: Yohire does not provide career counseling, validate skills, verify qualifications, or certify credentials.'''),
                _buildSectionContent(
                    '''B. Verification Limitations: Yohire assumes no responsibility for employment, educational, or reference verifications.'''),
                _buildSectionTitle('VII. THIRD-PARTY LIMITATIONS',context),
                _buildSectionContent(
                    '''A. External Service Limitations: Yohire is not liable for issues with third-party integrations, payment processors, or external services.'''),
                _buildSectionContent(
                    '''B. Company Service Limitations: Yohire disclaims responsibility for external applications, company-specific systems, and interview platforms.'''),
                _buildSectionTitle('VIII. LEGAL AND COMPLIANCE LIMITATIONS',context),
                _buildSectionContent(
                    '''A. Compliance Limitations: Yohire makes no guarantees regarding compliance with employment, data protection, or regional laws.'''),
                _buildSectionContent(
                    '''B. Dispute Resolution Limitations: Yohire’s involvement in user-company disputes is limited and does not include mediation or legal representation.'''),
                _buildSectionTitle('IX. WARRANTY DISCLAIMERS',context),
                _buildSectionContent(
                    '''A. Express Warranties: Yohire disclaims all warranties related to service suitability, platform reliability, feature functionality, and result effectiveness.'''),
                _buildSectionContent(
                    '''B. Implied Warranties: Yohire disclaims all implied warranties, including merchantability, fitness for a particular purpose, and non-infringement.'''),
                _buildSectionTitle('MODIFICATIONS AND GOVERNING LAW',context),
                _buildSectionContent('''I. PLATFORM MODIFICATIONS
A. Service Modification Rights: Yohire reserves the right to modify platform features, user interface elements, and queue management systems.'''),
                _buildSectionContent(
                    '''B. Notification Requirements: Yohire will provide advance notice for major changes, with immediate implementation of security updates.'''),
                _buildSectionTitle('II. TERMS AND POLICY MODIFICATIONS',context),
                _buildSectionContent(
                    '''A. Modification Scope: Yohire reserves the right to modify terms of service, privacy policy, and data usage terms.'''),
                _buildSectionContent(
                    '''B. User Notification Methods: Users will be notified of modifications through email, in-app announcements, and account dashboard alerts.'''),
                _buildSectionTitle('III. USER RIGHTS AND OBLIGATIONS',context),
                _buildSectionContent(
                    '''A. User Options: Users may review, accept, or reject modified terms and download their data before terminating service usage.'''),
                _buildSectionContent(
                    '''B. Implied Acceptance: Continued platform use implies acceptance of modifications; new terms become binding immediately.'''),
                _buildSectionTitle('IV. IMPLEMENTATION PROCEDURES',context),
                _buildSectionContent(
                    '''A. Standard Implementation: Regular updates follow scheduled maintenance and feature rollout periods; emergency changes are implemented for security issues.'''),
                _buildSectionTitle('V. EXISTING USER IMPACT',context),
                _buildSectionContent(
                    '''A. Profile Modifications: Modifications may impact data format requirements, visibility settings, and queue positions.'''),
                _buildSectionContent(
                    '''B. Active Applications: The Platform will maintain application status, communication channels, and interview schedules.'''),
                _buildSectionTitle('VI. GOVERNING LAW AND JURISDICTION',context),
                _buildSectionContent(
                    '''A. Current Governing Law: This Agreement is governed by Indian law. The governing law may transition to Australian Law in the future.'''),
                _buildSectionContent(
                    '''B. Dispute Resolution: All disputes are subject to exclusive jurisdiction of courts in [Indian City], subject to applicable laws.'''),
                _buildSectionTitle('VII. LEGAL PROCEEDINGS',context),
                _buildSectionContent(
                    '''A. Procedural Requirements: Legal actions must be filed individually, with class actions prohibited; costs are borne by each party.'''),
                _buildSectionContent(
                    '''B. Claims: Claims must follow limitation periods, include proper documentation, and adhere to prescribed procedures.'''),
                _buildSectionTitle('VIII. SEVERABILITY AND ENFORCEMENT',context),
                _buildSectionContent(
                    '''A. Severability: If any provision of this Agreement is invalid, it shall be severed, and remaining terms shall continue in force.'''),
                _buildSectionContent(
                    '''B. Enforcement: Valid portions of the Agreement are enforced according to applicable law and are binding upon all parties.'''),
                _buildSectionTitle(
                    'CONTACT INFORMATION AND COMMUNICATION PROTOCOLS',context),
                _buildSectionContent('''I. OFFICIAL CONTACT DETAILS
A. Primary Communication Channel: The official contact for all communications is hello@yohire.in.'''),
                _buildSectionTitle('II. RESPONSE TIME COMMITMENTS',context),
                _buildSectionContent(
                    '''A. Standard Response Intervals: General inquiries are responded to within 24-48 hours, with urgent matters prioritized within 24 hours.'''),
                _buildSectionTitle('III. COMMUNICATION PROTOCOLS',context),
                _buildSectionContent(
                    '''A. Official Communications: All official communications originate from the @yohire.in domain and are delivered via application notifications.'''),
                _buildSectionTitle('IV. OPERATIONAL HOURS',context),
                _buildSectionContent(
                    '''A. Standard Business Hours: Regular operations are Monday to Friday, with emergency support available for critical issues.'''),
                _buildSectionTitle('V. CONTACT INFORMATION UPDATES',context),
                _buildSectionContent(
                    '''A. Modification of Contact Details: Yohire reserves the right to modify contact information periodically; users should reference the Platform website for updates.'''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title,BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ThemeColors.primaryBlue,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        content,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ThemeColors.fontGrey,
          height: 1.5,
        ),
      ),
    );
  }
}
