import 'package:agenda/pages/agenda.dart';
import 'package:agenda/pages/profile.dart';
import 'package:agenda/pages/services.dart';
import 'package:agenda/src/features/service/widgets/create_dialog.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'src/features/appointment/pages/create_appointment_page.dart';
import 'utils/navigator.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  _MobileLayoutState createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  PageController controller = PageController();
  int _currentIndex = 0;
  onTap(int index) {
    //TODO: Todas as vezes que mudo de página isso da reload. (O que faz ler mais uma porrada no banco)
    if (_currentIndex == index) return;
    _currentIndex = index;

    // switch (index) {
    //   case 0:

    //     break;
    //   case 1:
    //     break;
    //   case 2:
    //     break;
    //   case 3:
    //     break;
    //   default:
    // }

    controller.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.ease);
  }

  String get fabTooltip {
    switch (_currentIndex) {
      case 0:
        return 'Adicionar atendimento';
      case 1:
        return 'Adicionar serviço';
      default:
        return '';
    }
  }

  onFabPressed() {
    switch (_currentIndex) {
      case 0:
        push(context, CreateAppointmentPage());
        //Sisteminha de popup é delicinha e rapido
        break;
      case 1:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CreateServiceDialog();
            });
        break;
      case 2:
        break;
      case 3:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: controller, children: [
        AgendaPage(),
        ServicesPage(),
        // TODO: Talvez não vale a pena oferecer o serviço de historico agora.
        // HistoryPage(),
        ProfilePage()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed,
        tooltip: fabTooltip,
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        //TODO: Adicionar indicador de qual página está
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BottomIconButton(
                icon: Icons.home,
                onTap: () => onTap(0),
                label: 'Agenda',
              ),
              BottomIconButton(
                icon: Icons.list,
                onTap: () => onTap(1),
                label: 'Serviços',
              ),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.nature, color: Colors.transparent)),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.nature, color: Colors.transparent)),
              // BottomIconButton(
              //   icon: Icons.history,
              //   onTap: () => onTap(2),
              //   label: 'Histórico',
              // ),
              BottomIconButton(
                icon: Icons.person,
                onTap: () => onTap(2),
                label: 'Perfil',
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: kPrimaryColor,
      ),
      // bottomNavigationBar:_BottomNavBar(),
    );
  }
}

class BottomIconButton extends StatelessWidget {
  const BottomIconButton({
    Key? key,
    required this.icon,
    this.label,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String? label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: label != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Text(
                  label!,
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          : Icon(
              icon,
              color: Colors.white,
            ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2, // shape: CircularNotchedRectangle(),
      onTap: (idx) {
        switch (idx) {
          case 0:
          // push to Calendario
          //TODO: O calendário exibe apenas quais e quantas tem no dia (Aquele antigo é melhor pra isso)
          case 1:
            // push(context, ServiceListPage());
            //TODO: Página de servicos vai listar os serviços cadastrados e suas variações
            break;
          case 2:
            push(context, CreateAppointmentPage());
            //TODO: vai para a página agendamento de um cliente
            // Criar uma hero que faz o navbar recolher e aparece apenas o botão fab no canto direito
            break;
          case 3:
          // push to Historico
          //TODO: Exibe o histórico de atendimentos.
          case 4:
            // push to Calendario
            // TODO: Vai para os dados de perfil da pessoa.
            //(Não dar muito suporte nessa função, pois a maioria dos valores so me interessa)
            // Os que serão importante para trabalhar com sistema de servico agendado pelo usuario
            break;

          default:
            print('Man???? Como tem index 5 aq?');
        }
      },

      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Calendário'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Serviços'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.transparent,
            ),
            label: 'Agendar'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Histórico'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
