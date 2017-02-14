

Процедура Проба1()
	
	//Сообщить(КодСимвола("*"));
	//Перейти ~Конец;
	
	ТекстHtml = "<p>";
	
	// Есть символы которые должны вызывать 
	СпецСимволы = "";
	МассивТегов = Новый Массив();
	МассивТегов.Добавить("</p>");
	
	КолСимволов   		  = СтрДлина(ТекстИсходник);
	КонтентТекущейСтроки  = "";
	КолПробеловПодряд     = 0;
	
	ПредыдущийСимвол 	  = "";
	КолОдинаковыхСимволов = 0;
	
	Для НомерСимвола = 1 По КолСимволов Цикл
		
		Символ = Сред(ТекстИсходник, НомерСимвола, 1);
		
		Если Символ = Символ(10) Тогда 
			
			Если КонтентТекущейСтроки = "" Тогда
				
				// Закрываем параграф
				ТекстHtml = ТекстHtml + МассивТегов[0];
				МассивТегов.Удалить(0);
				
				Сообщить("Есть такая строка");	
				
				// Открываем новый параграф
				ТекстHtml = ТекстHtml + "<p>";
				МассивТегов.Добавить("</p>");
				
			ИначеЕсли КолПробеловПодряд = 2 Тогда	
				
				ТекстHtml = ТекстHtml + "</br>";
				КолПробеловПодряд = 0;
				
			КонецЕсли;
			
			// Обнуляем строку
			КонтентТекущейСтроки = "";
			
		ИначеЕсли КодСимвола(Символ) = 42 Тогда	
			
			// Если тег <em> был открыт закрываем его
			Если МассивТегов[0] = "<em>" Тогда
				
				ТекстHtml = ТекстHtml + "</em>";	
				МассивТегов.Удалить(0);
				
			Иначе
				
				ТекстHtml = ТекстHtml + "<em>";
				МассивТегов.Вставить(0, "<em>");
				
			КонецЕсли;
			
		Иначе
			
			Если КодСимвола(Символ) = 32 Тогда
				КолПробеловПодряд = КолПробеловПодряд + 1;
			Иначе
				КолПробеловПодряд = 0;
			КонецЕсли;
			
			ТекстHtml = ТекстHtml + Символ;
			КонтентТекущейСтроки = КонтентТекущейСтроки + Символ;
			
		КонецЕсли;
		
		ПредыдущийСимвол = Символ;
		
	КонецЦикла;
	
	ТекстHtml = ТекстHtml + МассивТегов[0];
	МассивТегов.Удалить(0);
	
КонецПроцедуры

Процедура ВыделитьТекстВПредложении(Текст, НачальнаяПозицияПоиска = 0)
	
	ДлинаСтроки = СтрДлина(Текст);
	
	ПозицияСимволаВыделения = Найти(Текст, "**");
	ПозицияБлизлежащегоСимвола = ?(НачальнаяПозицияПоиска = 0, ПозицияСимволаВыделения + 2,  ПозицияСимволаВыделения - 1);

	БлизЛежащийСимвол = Сред(Текст, ПозицияБлизлежащегоСимвола,  1);

	// Проверяем что после начала выделения не идет пробел
	Если Не БлизЛежащийСимвол = " " Тогда
		
		Если НачальнаяПозицияПоиска = 0 Тогда
			ВыделитьТекстВПредложении(Текст, );
		Иначе
			
		КонецЕсли;

	Иначе

	КонецЕсли;
	
КонецПроцедуры



ТекстИсходник = "**Выделение текста** не выделенный текст";
МассивТегов = Новый Массив();

// Искустенно добавляе конец строки
ТекстИсходник = ТекстИсходник + Символ(32);

// Делим текст на строки
СтрокиТекста = СтрРазделить(ТекстИсходник, Символ(32));
Для каждого СтрокаТекста Из СтрокиТекста Цикл
	ВыделитьТекстВПредложении(СтрокаТекста);
КонецЦикла;
