import 'package:cinema_ticket_app/Cinema%20App%20UI/consts.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, IconData> profileSettings = {
    'Edit Profile': Icons.edit,
    'Change Password': Icons.lock,
    'Notifications': Icons.notifications,
    'Privacy': Icons.privacy_tip,
    'Logout': Icons.logout,
  };
  final _auth = AuthService();
  final supabase = Supabase.instance.client;
  String? currentUserName; // Переменная для хранения имени пользователя

  @override
  void initState() {
    super.initState();
    _fetchUserName(); // Загружаем имя пользователя при инициализации
  }

  // Функция для получения имени пользователя
  Future<void> _fetchUserName() async {
    final username = await fetchCurrentUserName();
    setState(() {
      currentUserName = username;
    });
  }

  Future<String?> fetchCurrentUserName() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        print('Пользователь не авторизован');
        return null;
      }

      final response = await supabase
          .from('user_profile')
          .select('name')
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) {
        throw Exception('Ответ от Supabase равен null');
      }

      if (response['error'] != null) {
        throw Exception(
            'Ошибка при получении имени пользователя: ${response['error']['message']}');
      }

      if (response['data'] == null) {
        print('Профиль пользователя не найден');
        return null;
      }

      return response['data']['username'] as String?;
    } catch (e) {
      print('Ошибка: $e');
      return null;
    }
  }

  // Функция выхода из аккаунта
  void logout() async {
    await _auth.signOut();
    // try {
    //   // После успешного выхода перенаправляем на экран входа
    //   if (mounted) {
    //     Navigator.pushReplacementNamed(context, '/login');
    //   }
    // } catch (e) {
    //   // Обработка ошибки выхода
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Ошибка при выходе: $e')),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Icon(
            size: 156,
            Icons.person,
            color: Colors.white,
          ),
          SizedBox(height: 25),
          Text(
            currentUserName != null
                ? currentUserName!
                : 'Guest', // Отображаем имя пользователя
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: profileSettings.length,
              itemBuilder: (context, index) {
                final setting = profileSettings.keys.elementAt(index);
                final icon = profileSettings[setting];
                // Определяем скругление углов в зависимости от индекса
                BorderRadius borderRadius;
                if (index == 0) {
                  // Первый элемент: скругляем только верхние углы
                  borderRadius = BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  );
                } else if (index == profileSettings.length - 1) {
                  // Последний элемент: скругляем только нижние углы
                  borderRadius = BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  );
                } else {
                  // Средние элементы: без скругления
                  borderRadius = BorderRadius.zero;
                }

                return GestureDetector(
                  onTap: () {
                    if (setting == 'Logout') {
                      logout();
                    } else {
                      print('Нажата настройка: $setting');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.1), // Фон для элементов списка
                      borderRadius: borderRadius, // Применяем скругление
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 15),
                          Text(
                            setting,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            color: buttonColor,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
