#Использовать gui

Перем Клавиши;
Перем УправляемыйИнтерфейс;
Перем ЭтаФорма;
Перем РезультатВыбора Экспорт;

Перем ПолеВвода;
Перем Данные;

Процедура Предупреждение(ТекстПредупреждения)
	УправляемыйИнтерфейс.СтандартныеДиалоги.Предупреждение(ТекстПредупреждения);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработка событий
Процедура ПриВыбореСкрипта() Экспорт
	РезультатВыбора = ПолеВвода.Значение;
	ЭтаФорма.Закрыть();
КонецПроцедуры

Процедура ПолеВводаПриНажатииНаКлавишу() Экспорт
	
	Если (ПолеВвода.КодНажатойКлавиши = Клавиши.Enter) Тогда
		РезультатВыбора = ПолеВвода.Значение;
		ЭтаФорма.Закрыть();
	ИначеЕсли (ПолеВвода.КодНажатойКлавиши = Клавиши.Esc) Тогда
		РезультатВыбора = "";
		ЭтаФорма.Закрыть();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриНажатииНаКнопкуОк() Экспорт
	РезультатВыбора = ПолеВвода.Значение;
	ЭтаФорма.Закрыть();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
Функция ВвестиЗначение(ВходящиеДанные = "", Заголовок = "") Экспорт
	
	Попытка
		
		ПутьКСкрипту = "core/KeyCodes.os";
		КодыКлавиш = ЗагрузитьСценарий(ПутьКСкрипту);
		Клавиши = КодыКлавиш.КодыКлавиш();
		
		Данные = ВходящиеДанные;
		
		УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
		ЭтаФорма = УправляемыйИнтерфейс.СоздатьФорму();
		
		ПолеВвода                              = ЭтаФорма.Элементы.Добавить("ПолеВвода", "ПолеФормы", Неопределено);
		ПолеВвода.Вид                          = ЭтаФорма.ВидПоляФормы.ПолеВвода;
		ПолеВвода.ПоложениеЗаголовка           = ЭтаФорма.ПоложениеЗаголовка.Нет;
		ПолеВвода.Значение           			= Данные;
		
		ПолеВвода.УстановитьДействие(ЭтотОбъект, "ПриНажатииНаКнопку", "ПолеВводаПриНажатииНаКлавишу");
		
		КнопкаОк = ЭтаФорма.Элементы.Добавить("КнопкаОк", "КнопкаФормы", Неопределено);
		КнопкаОк.Заголовок = "Ок";
		КнопкаОк.УстановитьДействие(ЭтотОбъект, "Нажатие", "ПриНажатииНаКнопкуОк");
		
		ЭтаФорма.Заголовок = Заголовок;
		ЭтаФорма.Высота = 90;
		ЭтаФорма.Показать();
		
	Исключение

		Предупреждение(ОписаниеОшибки());

	КонецПопытки;
	
	Возврат РезультатВыбора;

КонецФункции
