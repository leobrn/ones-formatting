#Использовать "../Классы"

Функция ФорматироватьOneStyle(Знач ТекстФорматирования, Знач Настройки, Взаимодействие) Экспорт
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент();
	ТекстовыйДокумент.УстановитьТекст(ТекстФорматирования);
	//ТекстовыйДокумент.Записать("tmp\in.txt");

	Попытка
		APK.Форматировать( ТекстовыйДокумент, Настройки );
		Выравниватель.ВыровнитьКод( ТекстовыйДокумент, Настройки );

		//ТекстовыйДокумент.Записать("tmp\out.txt");
	Исключение
		Взаимодействие.Предупреждение(ОписаниеОшибки());
	КонецПопытки;


	Возврат ТекстовыйДокумент.ПолучитьТекст();
	
КонецФункции
