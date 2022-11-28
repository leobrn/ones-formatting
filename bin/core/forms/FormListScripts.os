#использовать gui

Перем УправляемыйИнтерфейс;

Перем ДеревоСкриптов;
Перем ПолеДействие;
Перем ЭтаФорма;

Перем РезультатВыбора Экспорт;

Процедура ПриСозданииОбъекта()
	
	УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
	ЭтаФорма = УправляемыйИнтерфейс.СоздатьФорму();
	СоздатьЭлементыФормы();
	
КонецПроцедуры

Процедура ПриВыбореМетодаСкрипта() Экспорт
	
	ТекСтр = ДеревоСкриптов.ТекущиеДанные;
	
	Если НЕ ТекСтр.Метод Тогда
		
		УправляемыйИнтерфейс.СтандартныеДиалоги.Предупреждение("Необходимо выбрать метод!");
		Возврат;
		
	КонецЕсли;
	
	РезультатВыбора = ТекСтр.Родитель.Скрипт + "::" + ТекСтр.Скрипт;
	ЭтаФорма.Закрыть();
	
КонецПроцедуры

Процедура СоздатьЭлементыФормы()
	
	Дерево = СписокСкриптов();
	
	ПровайдерТЗ = Новый Провайдер;
	ПровайдерТЗ.ИсточникДерево = Дерево;
	
	ДеревоСкриптов = ЭтаФорма.Элементы.Добавить("ДеревоСкриптов", "ДеревоФормы", Неопределено);
	ДеревоСкриптов.ПутьКДанным = ПровайдерТЗ;
	ДеревоСкриптов.ПоложениеЗаголовка = УправляемыйИнтерфейс.ПоложениеЗаголовка.Верх;
	ДеревоСкриптов.Закрепление = УправляемыйИнтерфейс.СтильЗакрепления.Заполнение;
	ДеревоСкриптов.ТекущаяСтрока = 1;
	ДеревоСкриптов.УстановитьДействие(ЭтотОбъект, "ПриДвойномКлике", "ПриВыбореМетодаСкрипта");
	ДеревоСкриптов.УстановитьДействие(ЭтотОбъект, "ПриВыборе", "ПриВыбореМетодаСкрипта");
	
	ДеревоСкриптов.Колонки[0].Ширина = 250;
	ДеревоСкриптов.Колонки[1].Ширина = 250;
	
	ДеревоСкриптов.Ширина = 510;
	ЭтаФорма.Ширина = 520;
	
КонецПроцедуры

Функция Получить() Экспорт
	Возврат ЭтаФорма;
КонецФункции

Функция СписокСкриптов()
	
	Скрипты = НайтиФайлы("scripts", "*.os", Истина);
	
	Дерево = Новый ДеревоЗначений;
	Дерево.Колонки.Добавить("Скрипт");
	Дерево.Колонки.Добавить("Метод");
	
	Дерево.Колонки.Метод.Ширина = 0;
	
	Для Каждого Скрипт Из Скрипты Цикл

		Анализатор = ЗагрузитьСценарий(Скрипт.ПолноеИмя);
		Рефлектор = Новый Рефлектор();
		МетодыСкрипта = Рефлектор.ПолучитьТаблицуМетодов(Анализатор);

		Путь = Скрипт.ПолноеИмя;
		Путь = СтрЗаменить(Путь, ТекущийКаталог() + "\scripts\", "");
		Путь = СтрЗаменить(Путь, Скрипт.Имя, "");
		
		СтрокаДереваСкрипт = Дерево.Строки.Добавить();
		СтрокаДереваСкрипт.Скрипт = Путь + Скрипт.ИмяБезРасширения;
		СтрокаДереваСкрипт.Метод = Ложь;
		
		Для Каждого Метод Из МетодыСкрипта Цикл

			Если Метод.КоличествоПараметров > 0 Тогда
				Продолжить;
			КонецЕсли;

			Если Метод.Экспорт = Истина Тогда

				СтрокаДереваМетод = СтрокаДереваСкрипт.Строки.Добавить();
				СтрокаДереваМетод.Скрипт = Метод.Имя;
				СтрокаДереваМетод.Метод = Истина;

			КонецЕсли;

		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Дерево;
	
КонецФункции