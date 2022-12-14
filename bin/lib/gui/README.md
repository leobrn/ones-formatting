# Компонент по созданию форм для 1script

Внешняя компонента позволяет создавать формы на языке [1script](http://oscript.io/). API работы с формами максимально приближен к синтаксису 1С.

Основная задача компоненты - простая работа с формами. Позволяет создать большое количество разных элементов форм. Поддерижвается обработка событий элементов. Управление свойствами видимости, доступности и другими. Создан единый интерфейс для работы со значениями элементов (через свойство Значение).

Доступны основные элементы формы и события:

## Установка

`opm install gui` либо скачать с github https://github.com/ret-Phoenix/oscript-simple-gui

### Виды полей:

- ПолеВвода - Однострочное текстовое поле;
- ПолеИндикатора - Прогрессбар.
- ПолеКалендаря - Поле для ввода даты
- ПолеНадписи - Надпись (декорация в терминалогии 1С)
- ПолеФлажка - Флажок, имеет статусы: Включен/Выключен
- ПолеТекстовогоДокумента - Многострочный текст
- ПолеСоСписком - Поле со списком (ComboBox)
- ПолеСписка - Поле списка (ListBox)
- ОбычнаяГруппа - Контейнер для группы элементов
- Страница -  Страницы
- Кнопка
- ТаблицаФормы - Компонент для отображения объекта ТаблицаЗначений
- ДеревоФормы - Компонент для отображения объекта ДеревоЗначений


### Обрабатываемые события

- Форма: ПриОткрытии
- Кнопка: ПриНажатии
- ПолеФормы: ПриИзменении, ПриВыборе (нажат Enter), ПриНажатииНаКнопку (KeyDown)
  - ПолеСписка: ПриДвойномКлике

## Примеры

### Создание формы и вывод надписи

<img src="https://raw.githubusercontent.com/ret-Phoenix/oscript-simple-gui/master/docs/example-decoration.png" alt="Декорация">

<pre>
#Использовать gui
Перем Форма;

Процедура ПриСозданииОбъекта()

    УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
    Форма = УправляемыйИнтерфейс.СоздатьФорму();

    //# Устанавливаем обработку события ПриОткрытии
    Форма.УстановитьДействие(ЭтотОбъект, "ПриОткрытии", "ПриОткрытииФормы");
    Форма.Показать();

КонецПроцедуры

//# Обработка события первого открытия формы
Процедура ПриОткрытииФормы() Экспорт
    
    Декорация1 = Форма.Элементы.Добавить("Декорация1", "ПолеФормы", Неопределено);
    Декорация1.Вид = Форма.ВидПоляФормы.ПолеНадписи;
    Декорация1.Заголовок = "Это действительно работает!";
    
    Форма.Высота = 100;

КонецПроцедуры
</pre>

### Создание формы с кнопкой и обработка события нажатия на кнопку

<img src="https://raw.githubusercontent.com/ret-Phoenix/oscript-simple-gui/master/docs/example-button-n-edit.gif" alt="Кнопка + обработка события нажатия на кнопку">

<pre>
#Использовать gui

Перем Форма;

Процедура ПриСозданииОбъекта()

    УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
    Форма = УправляемыйИнтерфейс.СоздатьФорму();

    //# Устанавливаем обработку события ПриОткрытии
    Форма.УстановитьДействие(ЭтотОбъект, "ПриОткрытии", "ПриОткрытииФормы");
    Форма.Показать();

КонецПроцедуры

//# Обработка события первого открытия формы
Процедура ПриОткрытииФормы() Экспорт
    
    ПолеВвода1 = Форма.Элементы.Добавить("ПолеВвода1", "ПолеФормы", Неопределено);
    ПолеВвода1.Вид = Форма.ВидПоляФормы.ПолеВвода;
    ПолеВвода1.Заголовок = "Поле ввода";
    ПолеВвода1.Значение = "Значение задано из скрипта";

    Кнопка1 = Форма.Элементы.Добавить("Кнопка1", "КнопкаФормы", Неопределено);
    Кнопка1.Заголовок = "Нажми меня";
    Кнопка1.УстановитьДействие(ЭтотОбъект, "Нажатие", "ПриНажатииНаКнопку1");

КонецПроцедуры

Процедура ПриНажатииНаКнопку1() Экспорт
    Форма.Элементы.Найти("ПолеВвода1").Значение = "Значение после нажатия на кнопку";
КонецПроцедуры
</pre>

### Пример работы с выпадающим списком

<img src="https://raw.githubusercontent.com/ret-Phoenix/oscript-simple-gui/master/docs/example-combobox-change-event.png" alt="Поле со списком">

<pre>
#Использовать gui

Перем Форма;

Процедура ПриСозданииОбъекта()

    УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
    Форма = УправляемыйИнтерфейс.СоздатьФорму();

    //# Устанавливаем обработку события ПриОткрытии
    Форма.УстановитьДействие(ЭтотОбъект, "ПриОткрытии", "ПриОткрытииФормы");
    Форма.Показать();

КонецПроцедуры

//# Обработка события первого открытия формы
Процедура ПриОткрытииФормы() Экспорт
    
    Данные = Новый Соответствие;
    Данные.Вставить("1", "Один");
    Данные.Вставить("2", "Два");
    Данные.Вставить("3", "Три");

    ПолеСоСписком1 = Форма.Элементы.Добавить("ПолеСоСписком1", "ПолеФормы", Неопределено);
    ПолеСоСписком1.Заголовок = "Поле со списком";
    ПолеСоСписком1.Вид = Форма.ВидПоляФормы.ПолеСоСписком;
    ПолеСоСписком1.СписокВыбора = Данные;
    ПолеСоСписком1.Значение = "3";
    ПолеСоСписком1.УстановитьДействие(ЭтотОбъект, "ПриИзменении", "ПриИзменииЗначения");

    Форма.Высота = 80;

КонецПроцедуры

Процедура ПриИзменииЗначения() Экспорт
    Сообщить("Новое значение: " +  Форма.Элементы.Найти("ПолеСоСписком1").Значение);
КонецПроцедуры
</pre>

## ТаблицаФормы

<img src="https://raw.githubusercontent.com/ret-Phoenix/oscript-simple-gui/master/docs/example-form-table.png" alt="ТаблицаФормы">


    ПровайдерТЗ = Новый Провайдер;
    ПровайдерТЗ.Источник = ПолучитьТЗ();
    
    Поле1 = Форма.Элементы.Добавить("ТаблицаФормы1", "ТаблицаФормы", Неопределено);
    Поле1.ПутьКДанным = ПровайдерТЗ;
    Поле1.Заголовок = "Провайдер - ТЗ";
    Поле1.ПоложениеЗаголовка = УправляемыйИнтерфейс.ПоложениеЗаголовка.Верх;
    Поле1.Закрепление = 5;

## ДеревоФормы

<img src="https://raw.githubusercontent.com/ret-Phoenix/oscript-simple-gui/master/docs/example-form-tree.png" alt="ДеревоФормы">


    ПровайдерТЗ = Новый Провайдер;
    ПровайдерТЗ.ИсточникДерево = Данные;
    
    Поле1 = Форма.Элементы.Добавить("ДеревоФормы1", "ДеревоФормы", Неопределено);
    Поле1.ПутьКДанным = ПровайдерТЗ;
    Поле1.Заголовок = "Провайдер - Дерево значений";
    Поле1.ПоложениеЗаголовка = УправляемыйИнтерфейс.ПоложениеЗаголовка.Верх;
    Поле1.Закрепление = 5;
    Поле1.ТекущаяСтрока = 1;

## Процедуры и функции интерактивной работы      
### Предупреждение (DoMessageBox)   

<img src="https://github.com/alexkmbk/oscript-simple-gui/blob/master/docs/MessageBox.png" alt="Предупреждение">   

Выводит на экран окно предупреждения.   
Порядок вызова аналогичен реализованному в платформе 1С:Предприятие, но вызов осуществляется через промежуточный объект - СтандартныеДиалоги\StandardDialogs:

<pre>
#Использовать gui

УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
Диалоги = УправляемыйИнтерфейс.СтандартныеДиалоги;

Диалоги.Предупреждение("ТекстПредупреждения", 5, "Заголовок");

</pre>   

### Вопрос (DoQueryBox)    

<img src="https://github.com/alexkmbk/oscript-simple-gui/blob/master/docs/QueryBox.png" alt="Вопрос">   

Выводит на экран окно вопроса.     
Порядок вызова аналогичен реализованному в платформе 1С:Предприятие, но вызов осуществляется через объект СтандартныеДиалоги\StandardDialogs:  

<pre>
#Использовать gui

УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
Диалоги = УправляемыйИнтерфейс.СтандартныеДиалоги;

Ответ = Диалоги.Вопрос("Тест",РежимДиалогаВопрос.ДаНет, 1, КодВозвратаДиалога.Нет , "Заголовок", КодВозвратаДиалога.Нет);
</pre>   

### ВвестиСтроку (InputString)    

<img src="https://github.com/alexkmbk/oscript-simple-gui/blob/InputValuesDialogs/docs/InputString.png" alt="ВвестиСтроку">   

Открывает диалог ввода строкового значения.     
Порядок вызова аналогичен реализованному в платформе 1С:Предприятие, но вызов осуществляется через объект СтандартныеДиалоги\StandardDialogs:  

<pre>
#Использовать gui

УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
Диалоги = УправляемыйИнтерфейс.СтандартныеДиалоги;

Строка = "Значение";

Диалоги.ВвестиСтроку(Строка);

</pre>   

### ВвестиЧисло (InputNumber)    

<img src="https://github.com/alexkmbk/oscript-simple-gui/blob/InputValuesDialogs/docs/InputNumber.png" alt="ВвестиЧисло">   

Открывает диалог ввода числового значения.     
Порядок вызова аналогичен реализованному в платформе 1С:Предприятие, но вызов осуществляется через объект СтандартныеДиалоги\StandardDialogs:  

<pre>
#Использовать gui

УправляемыйИнтерфейс = Новый УправляемыйИнтерфейс();
Диалоги = УправляемыйИнтерфейс.СтандартныеДиалоги;

Число = 1;

Диалоги.ВвестиЧисло(Число);

</pre>  

В текущей версии игнорируются значения параметров <Длина> и <Точность>


## Диалог выбора файла   

<img src="https://github.com/alexkmbk/oscript-simple-gui/blob/master/docs/FileDialog.png" alt="Диалог выбора файла">  

Компонента реализует объект **ДиалогВыбораФайла (FileDialog)**, предназначенный для работы с диалогом специального вида для открытия файла или нескольких файлов, сохранения файла или выбора каталога.   
Порядок работы с объектом аналогичен реализованному в платформе 1С: Предприятие:

<pre>
#Использовать gui

Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);

Если Диалог.Выбрать() Тогда
     ИмяКаталога = Диалог.Каталог;
КонецЕсли;

Сообщить(ИмяКаталога);

</pre>  

В текущей версии не реализован метод **Показать**.   

# Примеры использования
- https://github.com/ret-Phoenix/oscript-simple-gui/tree/master/examples
- https://github.com/ret-Phoenix/oscript-simple-gui/tree/master/bin/src
- https://github.com/ret-Phoenix/oscript-simple-gui/tree/master/tests
- http://infostart.ru/public/540284/
