#использовать gui
#использовать WinExt

Перем УправляемыйИнтерфейс;
Перем ЭтаФорма;
Перем РезультатВыбора Экспорт;

Перем ПолеПоиска;
Перем ПолеСписка;
Перем ДанныеСписка;
Перем ФильтрПоПредставлению;
Перем ЗаголовокОкнаВыбора;

Перем ДополнительныеПараметры;

Процедура ПриСозданииОбъекта()
	РезультатВыбора = Неопределено;
КонецПроцедуры

Процедура Предупреждение(ТекстПредупреждения)
	УправляемыйИнтерфейс.СтандартныеДиалоги.Предупреждение(ТекстПредупреждения);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработка событий
//
Процедура ПриВыбореСкрипта() Экспорт
	РезультатВыбора = ПолеСписка.Значение;
	ЭтаФорма.Закрыть();

	Если ДополнительныеПараметры <> Неопределено Тогда
		Если ДополнительныеПараметры.Свойство("РаботаСОкнами") Тогда
			ДополнительныеПараметры.РаботаСОкнами.АктивироватьЗапомненноеОкно();
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриИзменииПолеПоиска() Экспорт
	
	Попытка
		
		СтрПоиска = СтрЗаменить(ПолеПоиска.Значение, " ", "(.*)");
		
		РегВыражениеПоиск = Новый РегулярноеВыражение("(.*)(" + СтрПоиска + ")(.*)");
		РегВыражениеПоиск.ИгнорироватьРегистр = Истина;
		
		НовыеДанные = Новый Соответствие();
		
		Для Каждого СтрСписка Из ДанныеСписка Цикл
			
			Попытка
				Если ФильтрПоПредставлению Тогда
					Совпадения = РегВыражениеПоиск.НайтиСовпадения(СтрСписка.Значение);	
				Иначе
					Совпадения = РегВыражениеПоиск.НайтиСовпадения(СтрСписка.Ключ);	
				КонецЕсли;
			Исключение
				Совпадения = Новый Массив();
			КонецПопытки;
			
			Если Совпадения.Количество() > 0 Тогда
				НовыеДанные.Вставить(СтрСписка.Ключ, СтрСписка.Значение);
			КонецЕсли;
			
		КонецЦикла;
		
		Если НовыеДанные.Количество() = 0 Тогда
			Обмен = ЗагрузитьСценарий("core/Взаимодействие.os");
			Обмен.УведомитьЧерезТрей("Нет данных для выбора. Отображаем пустой список!", "Выбор из списка");
			// НовыеДанные = ДанныеСписка;
		КонецЕсли;

		ПолеСписка.СписокВыбора = НовыеДанные;
		
		Если ЗаголовокОкнаВыбора = "" Тогда
			ЭтаФорма.Заголовок = "Количество элементов: " + НовыеДанные.Количество();
		Иначе
			ЭтаФорма.Заголовок = ЗаголовокОкнаВыбора;
		КонецЕсли;
		
	Исключение
		
		Сообщить(ОписаниеОшибки());

	КонецПопытки;
	
КонецПроцедуры

Процедура ПолеСпискаПриНажатииНаКлавишу() Экспорт

	Если ПолеСписка.НажатШифт Тогда
		
		Если ПолеСписка.КодНажатойКлавиши = 40 Тогда
			ПолеПоиска.Значение = ПолучитьКлючПоЗначению(ПолеСписка.СписокВыбора, ПолеСписка.Значение);
		КонецЕсли;
		
		Если ПолеСписка.КодНажатойКлавиши = 38 Тогда
			ПолеПоиска.Значение = ПолучитьКлючПоЗначению(ПолеСписка.СписокВыбора, ПолеСписка.Значение);
		КонецЕсли;
		
	КонецЕсли;
	
	Если (ПолеСписка.КодНажатойКлавиши = 37) или (ПолеСписка.КодНажатойКлавиши = 39) Тогда
		ЭтаФорма.ТекущийЭлемент = ПолеПоиска;
	КонецЕсли;
	
	Если ПолеСписка.КодНажатойКлавиши = 27 Тогда
		ПолеПоиска.Значение = "";
		ЭтаФорма.Закрыть();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПолеПоискаПриНажатииНаКлавишу() Экспорт
	
	Если ПолеПоиска.КодНажатойКлавиши = 27 Тогда
		ПолеПоиска.Значение = "";
		ЭтаФорма.Закрыть();
	КонецЕсли;
	
	Если (ПолеПоиска.КодНажатойКлавиши = 38) ИЛИ (ПолеПоиска.КодНажатойКлавиши = 40) Тогда
		ЭтаФорма.ТекущийЭлемент = ПолеСписка;
	КонецЕсли;

	Если ПолеПоиска.КодНажатойКлавиши = 13 Тогда

		Если (ПолеПоиска.Значение = "") и (ПолеСписка.СписокВыбора.Количество() > 0) Тогда
			РезультатВыбора = ПолеСписка.Значение;
			ЭтаФорма.Закрыть();
		КонецЕсли;

		Если ПолеСписка.СписокВыбора.Количество() = 1 Тогда
			РезультатВыбора = ПолеСписка.Значение;
			ЭтаФорма.Закрыть();
		КонецЕсли;

	КонецЕсли;

КонецПроцедуры

///////////////////////////////////////////////////////////////////////////////
// Вспомогательные методы
Функция ПолучитьКлючПоЗначению(Список, Значение)
	
	Для Каждого ЭлСписка Из Список Цикл
		Если ЭлСписка.Значение = Значение Тогда
			Возврат ЭлСписка.Ключ;
		КонецЕсли;
	КонецЦикла;
	
	Возврат "";
	
КонецФункции
///////////////////////////////////////////////////////////////////////////////

Функция ВыбратьИзСписка(Данные, ФильтроватьПоПредставлению = Ложь, ЗаголовокОкна = "", Параметры = Неопределено) Экспорт
	
	Попытка

		ДополнительныеПараметры = Параметры;
		
		ФильтрПоПредставлению = ФильтроватьПоПредставлению;
		ЗаголовокОкнаВыбора = ЗаголовокОкна;
		
		ДанныеСписка = Данные;
		
		УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
		ЭтаФорма = УправляемыйИнтерфейс.СоздатьФорму();
		
		ПолеПоиска                              = ЭтаФорма.Элементы.Добавить("ПолеПоиска", "ПолеФормы", Неопределено);
		ПолеПоиска.Вид                          = ЭтаФорма.ВидПоляФормы.ПолеВвода;
		ПолеПоиска.ПоложениеЗаголовка           = ЭтаФорма.ПоложениеЗаголовка.Нет;
		
		ПолеПоиска.УстановитьДействие(ЭтотОбъект, "ПриИзменении", "ПриИзменииПолеПоиска");
		ПолеПоиска.УстановитьДействие(ЭтотОбъект, "ПриНажатииНаКлавишу", "ПолеПоискаПриНажатииНаКлавишу");
		
		ПолеСписка                    = ЭтаФорма.Элементы.Добавить("ПолеСписка", "ПолеФормы", Неопределено);
		ПолеСписка.Вид                = ЭтаФорма.ВидПоляФормы.ПолеСписка;
		ПолеСписка.ПоложениеЗаголовка = ЭтаФорма.ПоложениеЗаголовка.Нет;
		ПолеСписка.СписокВыбора       = ДанныеСписка;
		ПолеСписка.Закрепление        = УправляемыйИнтерфейс.СтильЗакрепления.Заполнение;
		
		ПолеСписка.УстановитьДействие(ЭтотОбъект, "ПриВыборе", "ПриВыбореСкрипта");
		ПолеСписка.УстановитьДействие(ЭтотОбъект, "ПриДвойномКлике", "ПриВыбореСкрипта");
		ПолеСписка.УстановитьДействие(ЭтотОбъект, "ПриНажатииНаКлавишу", "ПолеСпискаПриНажатииНаКлавишу");
		
		Если ЗаголовокОкнаВыбора = "" Тогда
			ЭтаФорма.Заголовок = "Количество элементов: " + ДанныеСписка.Количество();
		Иначе
			ЭтаФорма.Заголовок = ЗаголовокОкнаВыбора;
		КонецЕсли;
		
		ЭтаФорма.ПоверхОкон = Истина;
		ЭтаФорма.СостояниеОкна = "Обычное";
		ЭтаФорма.СтартоваяПозиция = "ЦентрЭкрана";
		ЭтаФорма.Показать();
		
	Исключение
		Обмен = ЗагрузитьСценарий("core/Взаимодействие.os");
		Обмен.УведомитьЧерезТрей(ОписаниеОшибки(), "Выбор из списка");
	КонецПопытки;
	
	Возврат РезультатВыбора;

КонецФункции
