import 'package:portfolio_flutter/features/models/certification_model.dart';
import 'package:portfolio_flutter/features/models/skills_model.dart';
import '../features/models/project_model.dart';
import '../features/models/blog_post_model.dart';

class PortfolioData {
  // Personal Information
  static const String name = "Omnya Ashraf Abdelmonem";
  static const String nameAr = "أمنية أشرف عبد المنعم";
  static const String title = "Flutter Developer";
  static const String titleAr = "مطورة تطبيقات Flutter";
  static const String bio =
      "Flutter Developer with hands-on experience building scalable cross-platform applications. I focus on clean architecture, smooth user experience, and production-ready code.\n\n• 7+ cross-platform applications (Android, iOS, Web)\n• State management using BLoC, Provider, and Riverpod\n• Experience with Firebase, REST APIs, and third-party integrations\n• Clean, responsive UI with smooth performance\n\nFocused on delivering reliable, maintainable, and scalable applications.";
  static const String bioAr =
      "مطورة Flutter بخبرة عملية في بناء تطبيقات عابرة للمنصات قابلة للتوسع. أركز على الهندسة النظيفة (Clean Architecture)، تجربة مستخدم سلسة، وكود جاهز للإنتاج.\n\n• 7+ تطبيقات عابرة للمنصات (Android, iOS, Web)\n• إدارة الحالة باستخدام BLoC و Provider و Riverpod\n• خبرة في التعامل مع Firebase، واجهات برمجة التطبيقات (REST APIs)، وتكاملات جهات خارجية\n• واجهة مستخدم نظيفة ومتجاوبة مع أداء سلس\n\nأركز على تقديم تطبيقات موثوقة، قابلة للصيانة، وقابلة للتوسع.";
  static const String emailUrl = "mailto:omniaashraf8088@gmail.com";
  static const String location = "Giza, 6th of October (Remote Friendly)";
  static const String locationAr = "الجيزة، 6 أكتوبر (متاح للعمل عن بعد)";
  static const String profileImagePath = "assets/images/profile1.jpg";
  static const String logoImagePath = "assets/images/logo.jpg";
  static const String bioImagePath = "assets/images/bio.jpg";
  static const String cvUrl =
      "https://drive.google.com/file/d/1htyHY669h6oFGSZrXNatwWmdWpunmySF/view?usp=sharing";

  // Social Links
  static const String githubUrl = "https://github.com/omniaashraf8088";
  static const String linkedinUrl = "https://www.linkedin.com/in/omnia-ashraff";
  static const String twitterUrl = "https://x.com/omnia52481019";
  static const String facebookUrl =
      "https://www.facebook.com/share/16drFPjB7G/?mibextid=wwXIfr";
  static const String whatsappUrl = "https://wa.me/message/KBKG2WZ5ZQNRO1";
  static const String instagramUrl = "https://www.instagram.com/omnia_flutter/";
  static const String portfolioUrl =
      "https://yourportfolio.com"; // Will be updated after deployment

  // Skills
  static List<SkillModel> get skills => [
        // Mobile
        SkillModel(name: "Flutter", proficiency: 0.95, category: "Mobile Development"),
        SkillModel(name: "Dart", proficiency: 0.92, category: "Mobile Development"),
        SkillModel(name: "Android (Native)", proficiency: 0.75, category: "Mobile Development"),
        SkillModel(name: "iOS (Swift)", proficiency: 0.70, category: "Mobile Development"),
        // State Management
        SkillModel(name: "BLoC / Cubit", proficiency: 0.90, category: "State Management"),
        SkillModel(name: "Provider", proficiency: 0.92, category: "State Management"),
        SkillModel(name: "Riverpod", proficiency: 0.85, category: "State Management"),
        SkillModel(name: "GetX", proficiency: 0.80, category: "State Management"),
        // Backend & APIs
        SkillModel(name: "Firebase", proficiency: 0.90, category: "Backend & APIs"),
        SkillModel(name: "RESTful APIs", proficiency: 0.88, category: "Backend & APIs"),
        SkillModel(name: "Node.js", proficiency: 0.72, category: "Backend & APIs"),
        SkillModel(name: "MongoDB", proficiency: 0.70, category: "Backend & APIs"),
        // Frontend
        SkillModel(name: "Angular", proficiency: 0.78, category: "Frontend & Web"),
        SkillModel(name: "TypeScript", proficiency: 0.75, category: "Frontend & Web"),
        SkillModel(name: "HTML / CSS", proficiency: 0.82, category: "Frontend & Web"),
        // Design & Tools
        SkillModel(name: "Figma", proficiency: 0.85, category: "Design & Tools"),
        SkillModel(name: "Adobe XD", proficiency: 0.80, category: "Design & Tools"),
        SkillModel(name: "Git & GitHub", proficiency: 0.90, category: "Design & Tools"),
        SkillModel(name: "Clean Architecture", proficiency: 0.88, category: "Design & Tools"),
      ];

  // Projects
  static List<ProjectModel> get projects => [
        ProjectModel(
          id: 1,
          title: "Railway Admin Dashboard",
          titleAr: "لوحة إدارة حجز القطارات",
          description:
              "Problem: Railway reservation staff relied on disconnected tools, causing delays and data inconsistencies.\n\nSolution: Built a unified admin dashboard that centralises all reservation data in one responsive interface.\n\nKey Features:\n• Real-time data tables with filtering, sorting, and pagination\n• Full CRUD operations with input validation\n• Automated CI/CD pipeline for continuous deployment\n\nResult: Reduced admin task time and eliminated data duplication across departments.",
          descriptionAr:
              "تم حل مشكلات سير العمل الإداري المتشتت من خلال تقديم لوحة تحكم موحدة لحجز السكك الحديدية.\n\n• تصميم لوحة تحكم متجاوبة لإدارة البيانات في الوقت الفعلي.\n• تنفيذ عمليات CRUD معقدة وأتمتة خطوط بناء البرمجيات.\n• تحسين أداء التطبيق لمجموعات البيانات الكبيرة باستخدام أفضل ممارسات Angular.",
          imageUrl:
              "https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=800&q=80",
          techStack: ["Angular", "TypeScript", "HTML", "CSS"],
          githubUrl: "https://github.com/omniaashraf8088/Angular_Admin_Panel",
          demoUrl: "https://laffa-dashboard.vercel.app/",
          featured: true,
        ),
        ProjectModel(
          id: 3,
          title: "E-Care — Clinic Management",
          titleAr: "E-Care — إدارة العيادات",
          description:
              "Problem: Clinic staff managed patient records and appointments manually, leading to scheduling conflicts and slow workflows.\n\nSolution: Developed a cross-platform patient management app with real-time tracking and hardware integration.\n\nKey Features:\n• Live patient status tracking with smart care alerts\n• Native bridges (C++, Swift) for medical device connectivity\n• Streamlined appointment booking with calendar integration\n\nResult: Reduced appointment scheduling time by 30% and improved data accuracy.",
          descriptionAr:
              "تبسيط عمليات العيادات من خلال بناء نظام شامل لإدارة المرضى.\n\n• دمج ميزات الرعاية الذكية لتتبع المرضى في الوقت الفعلي.\n• تطوير جسور برمجية عالية الأداء باستخدام C++ و Swift لربط الأجهزة المتخصصة.\n• تحسين كفاءة جدولة المواعيد بنسبة 30% من خلال تصميم واجهة مستخدم بديهية.",
          imageUrl:
              "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&q=80",
          techStack: ["Flutter", "Dart", "C++", "Swift"],
          githubUrl:
              "https://github.com/omniaashraf8088/e_care-Clinic-Patient-Smart-Care",
          featured: true,
        ),
        ProjectModel(
          id: 4,
          title: "Fruits HUB — E-Commerce App",
          titleAr: "Fruits HUB — تطبيق تسوق",
          description:
              "Problem: Users needed a fast, reliable mobile shopping experience for fresh groceries with personalised preferences.\n\nSolution: Built a full-featured e-commerce app with real-time inventory sync and dual-theme support.\n\nKey Features:\n• Live data sync via Firebase Cloud Firestore\n• Custom Light/Dark theme with fluid transitions\n• Smart search with filters and saved favourites\n\nResult: Delivered a smooth shopping experience with strong user retention through personalisation.",
          descriptionAr:
              "تقديم تجربة تسوق بقالة غنية بالميزات تركز على التفاعل العالي للمستخدم.\n\n• تنفيذ مزامنة البيانات في الوقت الفعلي باستخدام Firebase Cloud Firestore.\n• تصميم نظام ثنائي للسمات (فاتح/داكن) مع رسوم متحركة انسيابية.\n• دمج منطق بحث متقدم ونظام تفضيلات لتحسين استبقاء المستخدمين.",
          imageUrl:
              "https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=800&q=80",
          techStack: ["Flutter", "Dart", "Firebase", "Provider"],
          githubUrl: "https://github.com/omniaashraf8088/Fruits_HUB",
          featured: true,
        ),
        ProjectModel(
          id: 9,
          title: "Dalel — Local Services Guide",
          titleAr: "دليل — دليل الخدمات المحلية",
          description:
              "Problem: Users had no centralised way to discover and compare local services in their area.\n\nSolution: Created a guide app with location-based search, categories, and a clean browsing experience.\n\nKey Features:\n• Scalable Firebase backend with real-time data updates\n• GPS-based service discovery with map integration\n• Category filtering and intuitive navigation flow\n\nResult: Enabled users to find relevant local services quickly with a polished, professional interface.",
          descriptionAr:
              "بناء تطبيق دليل قوي متعدد الميزات لمساعدة المستخدمين على اكتشاف الخدمات المحلية بسهولة.\n\n• بناء بنية كود قابلة للتوسع باستخدام Firebase كخلفية برمجية فورية.\n• تنفيذ خدمات معقدة تعتمد على الموقع وتدفقات تنقل سهلة الاستخدام.\n• تحقيق رضا عالٍ للمستخدم من خلال تصميم واجهة مستخدم مصقول واحترافي.",
          imageUrl:
              "https://images.unsplash.com/photo-1553877522-43269d4ea984?w=800&q=80",
          techStack: ["Flutter", "Dart", "Firebase"],
          githubUrl: "https://github.com/omniaashraf8088/Dalel-App",
          featured: true,
        ),
        ProjectModel(
          id: 10,
          title: "Dalel — Backend API",
          titleAr: "Dalel — واجهة برمجية خلفية",
          description:
              "Problem: The Dalel mobile app needed a performant backend capable of handling concurrent requests without latency.\n\nSolution: Engineered a RESTful API with optimised database queries and structured error handling.\n\nKey Features:\n• Secure CRUD endpoints with authentication middleware\n• MongoDB query optimisation for sub-100ms response times\n• Structured logging and centralised error handling\n\nResult: Achieved consistent sub-100ms API responses under load, ensuring a smooth mobile experience.",
          descriptionAr:
              "هندسة واجهة برمجة تطبيقات (RESTful API) قابلة للتوسع لدعم تطبيقات الجوال ذات الكثافة العالية.\n\n• تطوير نقاط نهاية آمنة لمعالجة البيانات وإدارة قواعد البيانات.\n• تحسين استعلامات قاعدة البيانات في MongoDB لضمان وقت استجابة أقل من 100 مللي ثانية.\n• تنفيذ معالجة قوية للأخطاء وتسجيل النظام لضمان الموثوقية.",
          imageUrl:
              "https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&q=80",
          techStack: ["Node.js", "Express", "MongoDB"],
          githubUrl: "https://github.com/omniaashraf8088/BackEnd-Dalel-App",
          featured: false,
        ),
        ProjectModel(
          id: 6,
          title: "Threads — Social Discussion App",
          titleAr: "Threads — تطبيق نقاشات",
          description:
              "Problem: Users wanted a lightweight social platform for focused, threaded discussions without the noise of mainstream apps.\n\nSolution: Built a real-time discussion app with threading, reactions, and profile management.\n\nKey Features:\n• Firebase Realtime Database for instant message delivery\n• Threaded conversations with likes and replies\n• Optimised image loading with in-memory caching\n\nResult: Delivered a fast, distraction-free social experience with real-time interaction.",
          descriptionAr:
              "إنشاء منصة اجتماعية عالية التفاعل للنقاشات في الوقت الفعلي.\n\n• استخدام قاعدة بيانات Firebase الفورية للتفاعلات اللحظية بين المستخدمين.\n• تنفيذ ميزات اجتماعية مثل سلاسل الرسائل، الإعجابات، وملفات تعريف المستخدمين.\n• تحسين تحميل الصور والتخزين المؤقت لتجربة تصفح سلسة.",
          imageUrl:
              "https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?w=800&q=80",
          techStack: ["Flutter", "Firebase", "Dart"],
          githubUrl: "https://github.com/omniaashraf8088/thread_app",
          featured: false,
        ),
        ProjectModel(
          id: 7,
          title: "Smart Notes — Offline Organizer",
          titleAr: "Smart Notes — منظم ملاحظات",
          description:
              "Problem: Existing note apps were either too complex or required an internet connection, slowing down daily workflows.\n\nSolution: Built a minimalist, offline-first note organiser with instant search and categories.\n\nKey Features:\n• SQLite storage for full offline functionality\n• Clean, distraction-free interface optimised for focus\n• Instant search with tag-based categorisation\n\nResult: Enabled fast, reliable note-taking without requiring connectivity.",
          descriptionAr:
              "تطوير أداة بسيطة وفعالة لتنظيم الأفكار اليومية والإنتاجية.\n\n• تنفيذ التخزين المحلي باستخدام SQLite لإمكانيات العمل دون اتصال.\n• تصميم واجهة مستخدم أنيقة وخالية من المشتتات لتعزيز التركيز.\n• بناء ميزات بحث وتصنيف قوية لاسترجاع المعلومات بسرعة.",
          imageUrl:
              "https://images.unsplash.com/photo-1517842645767-c639042777db?w=800&q=80",
          techStack: ["Flutter", "Dart", "SQLite"],
          githubUrl: "https://github.com/omniaashraf8088/note_app",
          featured: false,
        ),
      ];

  // Certificates
  static List<CertificateModel> get certificates => [
        CertificateModel(
          id: 1,
          title: "AI Must Certification",
          titleAr: "شهادة الذكاء الاصطناعي الأساسية",
          issuer: "Professional Training Institute",
          issuerAr: "معهد التدريب المهني",
          date: DateTime(2024, 1, 1),
          credentialUrl:
              "https://drive.google.com/file/d/1qVbweiK4xH-1FlVrUDn6NnGFYuTmZcl-/view?usp=drive_link",
        ),
        CertificateModel(
          id: 2,
          title: "Git and GitHub Certificate",
          titleAr: "شهادة Git و GitHub",
          issuer: "Technology Training Center",
          issuerAr: "مركز التدريب التقني",
          date: DateTime(2024, 1, 1),
          credentialUrl:
              "https://drive.google.com/file/d/1Xxq16xcULHxPS3HjfJFW-yl1N44EJKq5/view?usp=drive_link",
        ),
        CertificateModel(
          id: 3,
          title: "Instant Certification",
          titleAr: "شهادة التدريب الفوري",
          issuer: "Instant Learning Platform",
          issuerAr: "منصة التعلم الفوري",
          date: DateTime(2024, 1, 1),
          credentialUrl:
              "https://drive.google.com/file/d/1jYblcEcX8UHY80yNSh0aSTb2XtDcFRQ6/view?usp=drive_link",
        ),
        CertificateModel(
          id: 4,
          title: "Instant Training Certificate",
          titleAr: "شهادة التدريب السريع",
          issuer: "Instant Training Institute",
          issuerAr: "معهد التدريب السريع",
          date: DateTime(2024, 1, 1),
          credentialUrl:
              "https://drive.google.com/file/d/1SNxUCuLHwDddc7ptNp8iSZzwVnLbZi66/view?usp=drive_link",
        ),
        CertificateModel(
          id: 5,
          title: "Networking Certificate",
          titleAr: "شهادة الشبكات",
          issuer: "Network Training Academy",
          issuerAr: "أكاديمية تدريب الشبكات",
          date: DateTime(2024, 1, 1),
          credentialUrl:
              "https://drive.google.com/file/d/1w3IoWg6zNfoPdGEHDbkFupaQbOW_KYV4/view?usp=drive_link",
        ),
        CertificateModel(
          id: 6,
          title: "Al-Azhar University Certification",
          titleAr: "شهادة جامعة الأزهر",
          issuer: "Al-Azhar University",
          issuerAr: "جامعة الأزهر",
          date: DateTime(2024, 1, 1),
          credentialUrl:
              "https://drive.google.com/file/d/1rYVke_5oT04PRLdzeblrfzMImznL8z65/view?usp=drive_link",
        ),
      ];

  // Blog Posts
  static List<BlogPostModel> get blogPosts => [
        BlogPostModel(
          id: 1,
          title: "Building Scalable Flutter Apps",
          titleAr: "بناء تطبيقات Flutter قابلة للتطوير",
          summary:
              "Learn best practices for structuring large-scale Flutter applications with proper state management and clean architecture.",
          summaryAr:
              "تعلم أفضل الممارسات لهيكلة تطبيقات Flutter واسعة النطاق مع إدارة الحالة المتقدمة وتطبيق مبادئ الهندسة النظيفة.",
          date: DateTime(2024, 11, 1),
          readTime: "8 min read",
          readTimeAr: "8 دقائق قراءة",
          url:
              "https://medium.com/@omnia52481019/building-scalable-flutter-apps-architecture-best-practices-89e43d66059d",
        ),
        BlogPostModel(
          id: 2,
          title: "Flutter Performance Optimization",
          titleAr: "تحسين أداء Flutter",
          summary:
              "Discover advanced techniques to make your Flutter apps faster and more efficient.",
          summaryAr:
              "اكتشف تقنيات متقدمة لتحسين أداء تطبيقات Flutter وزيادة كفاءة استهلاك الموارد.",
          date: DateTime(2024, 10, 15),
          readTime: "6 min read",
          readTimeAr: "6 دقائق قراءة",
          url: "https://medium.com/p/5ee79489d345",
        ),
        BlogPostModel(
          id: 3,
          title: "State Management in Flutter",
          titleAr: "إدارة الحالة في Flutter",
          summary:
              "A comprehensive comparison of Provider, Bloc, Riverpod, and GetX for state management.",
          summaryAr:
              "تحليل ومقارنة شاملة لأنماط إدارة الحالة المختلفة (Provider, BLoC, Riverpod) واختيار الأنسب لمشروعك.",
          date: DateTime(2024, 9, 20),
          readTime: "10 min read",
          readTimeAr: "10 دقائق قراءة",
          url: "https://medium.com/@omnia52481019",
        ),
        BlogPostModel(
          id: 4,
          title: "Flutter Animations Masterclass",
          titleAr: "دورة الرسوم المتحركة في Flutter",
          summary:
              "Master complex animations in Flutter with practical examples and best practices.",
          summaryAr:
              "إتقان بناء الرسوم المتحركة المعقدة في Flutter باستخدام أمثلة تطبيقية وأفضل ممارسات الأداء.",
          date: DateTime(2024, 8, 10),
          readTime: "12 min read",
          readTimeAr: "12 دقيقة قراءة",
          url: "https://medium.com/@omnia52481019",
        ),
      ];
}
