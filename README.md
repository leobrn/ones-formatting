# ones-formatting
Инструмент для форматирования кода в 1С. Сочетание клавиш: `CTRL + ALT + F`. Не требует установки.

Инструмент создан путем объединения двух проектов: <a href="https://github.com/ret-Phoenix/SmartConfigurator" target="_blank">SmartConfigurator</a> и <a href="https://github.com/ret-Phoenix/SmartConfigurator2" target="_blank">SmartConfigurator2</a>.
<a href="https://infostart.ru/public/635970/" target="_blank">Статья на инфостарте с описанием возможностей</a> 

Автоматическое добавление пробелов после запятых, окружение пробелами арифметическими знаками, добавление пустых строк, выравнивание перенесенных выражений, привидение ключевых слов к каноническому виду и многое другое.
Хорошо помогает при рефакторинге старого кода.

## Перенос строки
Переносит строки свыше 130 символов. До
<img src="https://raw.githubusercontent.com/leobrn/ones-formatting/main/img/ПереносСтрокиДо.png" alt="" style="zoom:80%;" />
После
<img src="https://raw.githubusercontent.com/leobrn/ones-formatting/main/img/ПереносСтрокиПосле.png" alt="" style="zoom:80%;" />
`При стандартном форматирование все сдвигается влево до упора, данный функционал поможет это исправить.`

## Выравнивание до запятой
<img src="https://raw.githubusercontent.com/leobrn/ones-formatting/main/img/ВыравниваниеДоЗапятойДо.png" alt="" style="zoom:80%;" />
<img src="https://raw.githubusercontent.com/leobrn/ones-formatting/main/img/ВыравниваниеДоЗапятойПосле.png" alt="" style="zoom:80%;" />

## Выравнивание до равно
<img src="https://raw.githubusercontent.com/leobrn/ones-formatting/main/img/ВыравниваниеДоРавноДо.png" alt="" style="zoom:80%;" />
<img src="https://raw.githubusercontent.com/leobrn/ones-formatting/main/img/ВыравниваниеДоРавноПосле.png" alt="" style="zoom:80%;" />
`При следовании друг за другом нескольких однотипных операторов допускается их выравнивание. Выравнивание следует выполнять с помощью пробелов.`

#
Конфигурирование производится в файле `\bin\OneStyle\Классы\Выравниватель.os"`