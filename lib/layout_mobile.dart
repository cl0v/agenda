import 'package:agenda/src/features/service/pages/service_list.dart';
import 'package:agenda/src/features/appointment/pages/appointment_page.dart';
import 'package:flutter/material.dart';

import 'src/features/appointment/pages/create_appointment_page.dart';
import 'utils/navigator.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({ Key? key }) : super(key: key);

  @override
  _MobileLayoutState createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TodayAppointmentListPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => push(context, CreateAppointmentPage()),
        tooltip: 'Adicionar atendimento',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // shape: CircularNotchedRectangle(),
        onTap: (idx) {
          switch (idx) {
            case 0:
            // push to Calendario
            //TODO: O calendário exibe apenas quais e quantas tem no dia (Aquele antigo é melhor pra isso)
            case 1:
              push(context, ServiceListPage());
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
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Histórico'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}