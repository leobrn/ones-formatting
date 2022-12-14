Перем ОшибкиРеализации Экспорт;

Функция Реализован(СсылкаНаОбъект, Интерфейс) Экспорт

	Объект = ЗагрузитьСценарий(Интерфейс + ".os");
	
	ОшибкиРеализации = "";

	Рефлектор = Новый Рефлектор;
	КартаИнтерфейса = Рефлектор.ПолучитьТаблицуМетодов(Объект);
	КартаКласса = Рефлектор.ПолучитьТаблицуМетодов(СсылкаНаОбъект);
	
	ИнтерфейсРеализован = Истина;
	Для каждого Элемент Из КартаИнтерфейса Цикл
		
		НайденныйЭлемент = КартаКласса.Найти(Элемент.Имя, "Имя");
		Если НайденныйЭлемент = Неопределено Тогда
			ИнтерфейсРеализован = Ложь;
			ОшибкиРеализации  = ОшибкиРеализации  + Символы.ВК + Символы.ПС + "Не реализован метод интерфейса: " + Элемент.Имя;
			Продолжить;
		КонецЕсли;

		Если НайденныйЭлемент.КоличествоПараметров <> Элемент.КоличествоПараметров Тогда
			ИнтерфейсРеализован = Ложь;
			ОшибкиРеализации  = ОшибкиРеализации  + Символы.ВК + Символы.ПС + "Неверное количество параметров, есть: " 
				+ НайденныйЭлемент.КоличествоПараметров  + " должно быть: " + Элемент.КоличествоПараметров;
		КонецЕсли;
		
	КонецЦикла;

	Возврат ИнтерфейсРеализован;

КонецФункции

Процедура Реализует(СсылкаНаОбъект, Интерфейсы) Экспорт
	
	СписокИнтерфейсов = СтрРазделить(Интерфейсы, ",", Ложь);
	
	ОшибкиРеализации = "";
	Для каждого Интерфейс Из СписокИнтерфейсов Цикл
		Реализован(СсылкаНаОбъект, СокрЛП(Интерфейс));		
	КонецЦикла;
	
	Если ОшибкиРеализации <> "" Тогда
		ВызватьИсключение ОшибкиРеализации;
	КонецЕсли;
	
КонецПроцедуры