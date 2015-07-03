---
layout: post
comments: true
title: "Integrando o Remember the Milk ao Google Calendar e Gmail"
date: 2011-09-21
categories: [Gmail, Google Calendar, Remember the Milk]
---
O [Google Calendar](http://calendar.google.com) é uma excelente ferramenta para manter o controle de compromissos pendentes. Porém, tem dois problemas: é limitado a tarefas que tenham uma data específica e não dependem do usuário concluir, ou seja, uma tarefa que foi programada para ontem mas não foi realizada não aparecerá mais no meu calendário (ou melhor, aparecerá no dia em que estava prevista, e provavelmente será esquecida com o tempo). Isso acontece porque o Google Calendar não é uma ferramenta voltada para tarefas, e sim para eventos. Para realizar o controle de tarefas, o melhor é utilizar uma ferramenta específica para tal. Idealmente uma que seja integrável ao Google Calendar, pois este continua sendo uma excelente ferramenta para controle de eventos (visualizar eventos futuros, compartilhar com outras pessoas, etc).

A opção mais óbvia para controle de tarefas seria o [Google Tasks](http://mail.google.com/tasks), pois é do próprio Google, e como tal, é totalmente integrado não só ao Google Calendar, mas também ao Gmail. Apesar de ser uma boa opção, o Google Tasks é bastante limitado, e não possui (ainda) uma funcionalidade que considero básica para uma ferramenta de controle de tarefas: o cadastro de tarefas recorrentes (ex: toda segunda-feira, todo mês no dia 10).

Em função destas limitações, eu prefiro utilizar o [Remember the Milk](http://www.rememberthemilk.com), que é uma ferramenta muito mais completa que o Google Tasks. Ele também pode ser integrado tanto ao Gmail quanto ao Google Calendar.

Integração com Google Calendar
------------------------------

A integração é bem simples, através da interface iCalendar do Remember the Milk: vá até a opção "settings", aba "Info". Copie o link "iCalendar Events Service (All Lists)". Em seguida, vá ao Google Calendar, em "other calendars", à esquerda, há uma opção "Add by URL". Cole a URL que foi copiada do Remember the Milk, e será criado um novo calendário com as suas tarefas - obviamente só aparecerão as que tem data.

Apesar de funcionar bem, a integração é limitada: a hora da tarefa não aparece, não há link direto para ver a tarefa no RTM, e é somente uma visualização, ou seja, não é possível editar, excluir ou concluir a tarefa a partir do Google Calendar. Além disso, quando uma tarefa é concluída, ela demora um tempo para sumir do calendário. Mas é possível configurar reminders para este calendário específico, o que torna a integração mais útil.

O calendário criado exibe todas as tarefas do seu RTM que não estão concluídas e tem data. Outra possibilidade é criar calendários com listas específicas. Para isso, vá ao RTM, faça uma busca ou selecione uma lista ou smart list específica. No lado direito aparecerá uma opção "iCalendar (Events)". Copie esse link e repita o procedimento anterior no Google Calendar.

O RTM também disponibiliza dois [gadgets para Google Calendar](http://www.rememberthemilk.com/services/googlecalendar/):

- [Sidebar Gadget](http://www.rememberthemilk.com/services/googlecalendar/sidebar/)

  Permite visualizar, editar e adicionar tarefas diretamente no Google Calendar. Só não é possível visualizar e editar notas, mas há um link para exibir no RTM.

- [Daily Gadget](http://www.rememberthemilk.com/services/googlecalendar/)

  Adiciona um botão a cada dia do calendário; ao ser clicado, exibe a lista de tarefas do dia.

Integração com Gmail
--------------------

O RTM disponibiliza duas maneiras de exibir as tarefas no Gmail:

- Gadget do Google Calendar

  Se você configurou a integração do RTM com o Google Calendar, descrita acima, o gadget do Google Calendar exibirá as tarefas do RTM.

- [Gmail Gadget](http://www.rememberthemilk.com/services/gmail/gadget/)</li>

  Este gadget possui as mesmas funcionalidades do Sidebar Gadget para Google Calendar.

- [Add-on](http://www.rememberthemilk.com/services/gmail/addon/) (Firefox e Chrome)</li>

  Esta extensão é bem semelhante ao Gmail Gadget, mas possui algumas funcionalidades a mais: ela pode ser configurada para criar tarefas automaticamente quando um email for marcado com estrela ou com um label específico. Também é possível criar uma tarefa associada a um email específico, que será automaticamente concluída quando o email for respondido.
