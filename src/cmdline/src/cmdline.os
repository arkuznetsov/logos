﻿#Использовать logos

Перем Лог;
Перем мПараметры;
Перем мПозиционныеПараметры;

Перем мКоманды;

Перем мПозицияВСпискеТокенов;
Перем мПозицияПозиционныхПараметров;
Перем мМассивВходныхПараметров;

Функция ДобавитьПараметр(Знач ИмяПараметра, Знач Пояснение = "") Экспорт
	
	Лог.Отладка("ДобавитьПараметр: ИмяПараметра <"+ИмяПараметра+">");		
	
	ДобавитьПараметрВТаблицу(мПозиционныеПараметры, ИмяПараметра, Пояснение, Ложь, Ложь);
	
КонецФункции

Функция ДобавитьИменованныйПараметр(Знач ИмяПараметра, Знач Пояснение = "", Знач Глобальный = Ложь) Экспорт
	
	Лог.Отладка("ДобавитьИменованныйПараметр: ИмяПараметра <"+ИмяПараметра+">");		
	
	ДобавитьПараметрВТаблицу(мПараметры, ИмяПараметра, Пояснение, Ложь, Глобальный);
	
КонецФункции

Функция ДобавитьПараметрФлаг(Знач ИмяПараметра, Знач Пояснение = "", Знач Глобальный = Ложь) Экспорт
	
	Лог.Отладка("ДобавитьПараметрФлаг: ИмяПараметра <"+ИмяПараметра+">");		
	
	ДобавитьПараметрВТаблицу(мПараметры, ИмяПараметра, Пояснение, Истина, Глобальный);
	
КонецФункции

Функция ДобавитьПараметрКоллекция(Знач ИмяПараметра, Знач Пояснение = "") Экспорт
	
	Лог.Отладка("ДобавитьПараметрКоллекция: ИмяПараметра <"+ИмяПараметра+">");		
	
	ДобавитьПараметрКоллекцияВТаблицу(мПозиционныеПараметры, ИмяПараметра, Пояснение);
	
КонецФункции

Функция ОписаниеКоманды(Знач ИмяКоманды, Знач Пояснение = "") Экспорт
	
	НовоеОписание = Новый Структура;
	НовоеОписание.Вставить("Команда", ИмяКоманды);
	НовоеОписание.Вставить("Пояснение", Пояснение);
	НовоеОписание.Вставить("ПозиционныеПараметры", НоваяТаблицаПараметров());
	НовоеОписание.Вставить("ИменованныеПараметры", НоваяТаблицаПараметров());
	
	Возврат НовоеОписание;
	
КонецФункции

Процедура ДобавитьКоманду(Знач ОписаниеКоманды) Экспорт
	
	мКоманды.Вставить(ОписаниеКоманды.Команда, ОписаниеКоманды);
	
КонецПроцедуры

Функция ДобавитьПозиционныйПараметрКоманды(Знач ОписаниеКоманды, Знач ИмяПараметра, Знач Пояснение = "") Экспорт
	Лог.Отладка("Добавляю позиционный параметр "+ИмяПараметра);
	Возврат ДобавитьПараметрВТаблицу(ОписаниеКоманды.ПозиционныеПараметры, ИмяПараметра, Пояснение, Ложь);
КонецФункции

Функция ДобавитьИменованныйПараметрКоманды(Знач ОписаниеКоманды, Знач ИмяПараметра, Знач Пояснение = "") Экспорт
	Лог.Отладка("Добавляю именованный параметр "+ИмяПараметра);
	Возврат ДобавитьПараметрВТаблицу(ОписаниеКоманды.ИменованныеПараметры, ИмяПараметра, Пояснение, Ложь);
КонецФункции

Функция ДобавитьПараметрФлагКоманды(Знач ОписаниеКоманды, Знач ИмяПараметра, Знач Пояснение = "") Экспорт
	Лог.Отладка("Добавляю параметр-флаг "+ИмяПараметра);
	Возврат ДобавитьПараметрВТаблицу(ОписаниеКоманды.ИменованныеПараметры, ИмяПараметра, Пояснение, Истина);
КонецФункции

Функция ДобавитьПараметрКоллекцияКоманды(Знач ОписаниеКоманды, Знач ИмяПараметра, Знач Пояснение = "") Экспорт
	Лог.Отладка("Добавляю параметр-коллекция "+ИмяПараметра);
	Возврат ДобавитьПараметрКоллекцияВТаблицу(ОписаниеКоманды.ПозиционныеПараметры, ИмяПараметра, Пояснение);
КонецФункции

Функция РазобратьКоманду(Знач МассивПараметров) Экспорт
	
	Если МассивПараметров.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ОписаниеКоманды = мКоманды[МассивПараметров[0]];
	Если ОписаниеКоманды = Неопределено Тогда
		ВызватьИсключение "Неизвестная команда: " + МассивПараметров[0];
	КонецЕсли;
	Лог.Отладка("Разбор команды: " + ОписаниеКоманды.Команда);
	
	ГлобальныеПараметры = мПараметры.НайтиСтроки(Новый Структура("ЭтоГлобальныйПараметр", Истина));
	Для Каждого СтрГлобальныйПараметр Из ГлобальныеПараметры Цикл
		СтрСуществующий = ОписаниеКоманды.ИменованныеПараметры.Найти(СтрГлобальныйПараметр.Имя,"Имя");
		Если СтрСуществующий = Неопределено Тогда
			Лог.Отладка("Добавляю глобальный параметр: " + СтрГлобальныйПараметр.Имя);
			ЗаполнитьЗначенияСвойств(ОписаниеКоманды.ИменованныеПараметры.Добавить(), СтрГлобальныйПараметр,, "ЭтоГлобальныйПараметр");
		КонецЕсли;
	КонецЦикла;
	
	РезультатКоманды = Новый Структура;
	РезультатКоманды.Вставить("Команда", ОписаниеКоманды.Команда);
	РезультатКоманды.Вставить("ЗначенияПараметров", Новый Соответствие);
	
	мМассивВходныхПараметров = МассивПараметров;
	мПозицияВСпискеТокенов = 1;
	мПозицияПозиционныхПараметров = 0;
	
	РезультатКоманды.ЗначенияПараметров = РазобратьАргументы(ОписаниеКоманды.ИменованныеПараметры, ОписаниеКоманды.ПозиционныеПараметры);
	
	Лог.Отладка("Трассировка РезультатКоманды.ЗначенияПараметров:");
	ВывестиРезультатРазбора(РезультатКоманды.ЗначенияПараметров);
	
	Возврат РезультатКоманды;
	
КонецФункции

Функция Разобрать(Знач ВходнойМассивПараметров) Экспорт
	
	Если Лог.Уровень() = УровниЛога.Отладка Тогда
		Строка = "";
		Для Каждого Параметр Из ВходнойМассивПараметров Цикл
			Строка = Строка + Параметр + " ";
		КонецЦикла;
		Лог.Отладка("ВходнойМассивПараметров <"+СокрЛП(Строка)+">");
	КонецЕсли;
	
	ОписаниеКоманды = Неопределено;
	Если ВходнойМассивПараметров.Количество() > 0 Тогда 
		ОписаниеКоманды = мКоманды[ВходнойМассивПараметров[0]];
	КонецЕсли;
	Если ОписаниеКоманды <> Неопределено Тогда
		Лог.Отладка("Первый параметр совпадает с именем команды. Переход в режим обработки команд");
		Возврат РазобратьКоманду(ВходнойМассивПараметров);
	Иначе
		мМассивВходныхПараметров = Новый Массив;
		Для Каждого Элемент Из ВходнойМассивПараметров Цикл
			мМассивВходныхПараметров.Добавить(Элемент);
		КонецЦикла;
		
		мПозицияПозиционныхПараметров = 0;
		мПозицияВСпискеТокенов        = 0;
		
		РезультатРазбора = РазобратьАргументы(мПараметры, мПозиционныеПараметры);
		
		Лог.Отладка("Трассировка РезультатКоманды.ЗначенияПараметров:");
		ВывестиРезультатРазбора(РезультатРазбора);
		
		Возврат РезультатРазбора;
	КонецЕсли;
	
КонецФункции

Функция СправкаПоПараметрам() Экспорт
	Возврат ТаблицаСправкаПоПараметрам(мПараметры, мПозиционныеПараметры);
КонецФункции

Функция СправкаПоКоманде(Знач ИмяКоманды) Экспорт
	
	ТаблицаСправкаПоКомандам = СправкаВозможныеКоманды();
	Возврат ТаблицаСправкаПоКомандам.Найти(ИмяКоманды, "Команда");
	
КонецФункции

Функция СправкаВозможныеКоманды() Экспорт
	
	ТаблицаСправка = Новый ТаблицаЗначений;
	ТаблицаСправка.Колонки.Добавить("Команда");
	ТаблицаСправка.Колонки.Добавить("Пояснение");
	ТаблицаСправка.Колонки.Добавить("Параметры");
	
	Для Каждого КлючИЗначение Из мКоманды Цикл
		СтрСправка      = ТаблицаСправка.Добавить();
		ОписаниеКоманды = КлючИЗначение.Значение;
		
		СтрСправка.Команда   = ОписаниеКоманды.Команда;
		СтрСправка.Пояснение = ОписаниеКоманды.Пояснение;
		СправкаПоПараметрам  = ТаблицаСправкаПоПараметрам(ОписаниеКоманды.ИменованныеПараметры, ОписаниеКоманды.ПозиционныеПараметры);
		СтрСправка.Параметры = СправкаПоПараметрам;
		
	КонецЦикла;
	
	Возврат ТаблицаСправка;
	
КонецФункции

Функция ТаблицаСправкаПоПараметрам(Знач ИменованныеПараметры, Знач ПозиционныеПараметры)
	
	ТабРезультат = НоваяТаблицаПараметров();
	ТабРезультат.Колонки.Добавить("ЭтоИменованныйПараметр");
	
	Для Каждого Стр Из ПозиционныеПараметры Цикл
		СтрРезультат = ТабРезультат.Добавить();
		ЗаполнитьЗначенияСвойств(СтрРезультат, Стр);
		СтрРезультат.ЭтоИменованныйПараметр = Ложь;
	КонецЦикла;
	
	Для Каждого Стр Из ИменованныеПараметры Цикл
		СтрРезультат = ТабРезультат.Добавить();
		ЗаполнитьЗначенияСвойств(СтрРезультат, Стр);
		СтрРезультат.ЭтоИменованныйПараметр = Истина;
	КонецЦикла;
	
	Возврат ТабРезультат;
	
КонецФункции

Функция РазобратьАргументы(Знач ИменованныеПараметры, Знач ПозиционныеПараметры)
	Лог.Отладка("Попадаю в РазобратьАргументы");
	
	РезультатРазбора = Новый Соответствие;

	Если мМассивВходныхПараметров.Количество() = 0 Тогда 
		Лог.Отладка("Параметров не передали.");
		Возврат РезультатРазбора;
	КонецЕсли;
	
	Для Каждого СтрПараметр Из ИменованныеПараметры.НайтиСтроки(Новый Структура("ЭтоФлаг",Истина)) Цикл
		Лог.Отладка("Сбрасываю параметр-флаг: " + СтрПараметр.Имя);
		РезультатРазбора[СтрПараметр.Имя] = Ложь;
	КонецЦикла;

	ТекущийПараметрКоллекция = Неопределено;
	Пока Истина Цикл
		
		Токен = СледующийТокен();
		Лог.Отладка("Выбран токен: " + Токен);
		Если Токен = Неопределено Тогда
			Лог.Отладка("Закончились токены");
			
			Лог.Отладка("Трассировка РезультатРазбора:");
			ВывестиРезультатРазбора(РезультатРазбора);
			
			Прервать;
		КонецЕсли;
		
		Если ТекущийПараметрКоллекция <> Неопределено Тогда
			ТекущийПараметрКоллекция.Добавить(Токен);
			Продолжить;
		КонецЕсли;
		
		Если ЭтоИменованныйПараметр(Токен, ИменованныеПараметры) Тогда
			Лог.Отладка("Это именованный параметр: " + Токен + " ?");
			РезультатРазбора[Токен] = СледующийОбязательныйТокен(Токен);
			Лог.Отладка("Нашли значение именованного параметра: " + РезультатРазбора[Токен]);
		ИначеЕсли ЭтоПараметрФлаг(Токен, ИменованныеПараметры) Тогда
			Лог.Отладка("Это параметр-флаг: " + Токен + " ?");
			РезультатРазбора[Токен] = Истина;
			Лог.Отладка("Нашли параметр-флаг: " + РезультатРазбора[Токен]);
		Иначе
			ОписаниеПараметра = СледующийПозиционныйПараметр(ПозиционныеПараметры);
			Если ОписаниеПараметра.ЭтоКоллекция Тогда
				Лог.Отладка("Перехожу к чтению параметра-коллекции <"+ОписаниеПараметра.Имя+">");
				ТекущийПараметрКоллекция = Новый Массив;
				РезультатРазбора[ОписаниеПараметра.Имя] = ТекущийПараметрКоллекция;
				ТекущийПараметрКоллекция.Добавить(Токен);
			Иначе
				Лог.Отладка("Установлено значение позиционного параметра <" + ОписаниеПараметра.Имя + " = " + Токен + ">");
				РезультатРазбора[ОписаниеПараметра.Имя] = Токен;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат РезультатРазбора;
	
КонецФункции

Процедура ВывестиРезультатРазбора(РезультатРазбора)
	Если Лог.Уровень() = УровниЛога.Отладка Тогда
		Для Каждого КлючЗначение Из РезультатРазбора Цикл
			Лог.Отладка("		"+КлючЗначение.Ключ+":"+КлючЗначение.Значение);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Функция СледующийТокен()
	Если мПозицияВСпискеТокенов = мМассивВходныхПараметров.Количество() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Токен = мМассивВходныхПараметров[мПозицияВСпискеТокенов];
	мПозицияВСпискеТокенов = мПозицияВСпискеТокенов + 1;
	
	Возврат Токен;
КонецФункции

Функция СледующийОбязательныйТокен(Знач ИскомыйПараметр)
	Токен = СледующийТокен();
	Если Токен = Неопределено Тогда
		ВызватьИсключение "Ожидается значение параметра " + ИскомыйПараметр;
	КонецЕсли;
	Возврат Токен;
КонецФункции

Функция ЭтоИменованныйПараметр(Знач Токен, Знач ИменованныеПараметры)
	Лог.Отладка("Ищу именованный параметр "+Токен);
	СтрПараметр = ИменованныеПараметры.Найти(Токен, "Имя");
	Возврат СтрПараметр <> Неопределено и Не СтрПараметр.ЭтоФлаг;
КонецФункции

Функция ЭтоПараметрФлаг(Знач Токен, Знач ИменованныеПараметры)
	Лог.Отладка("Ищу параметр-флаг "+Токен);
	СтрПараметр = ИменованныеПараметры.Найти(Токен, "Имя");
	Возврат СтрПараметр <> Неопределено и СтрПараметр.ЭтоФлаг;
КонецФункции

Функция ЗакончилисьПозиционныеПараметры(ПозиционныеПараметры)
	Возврат мПозицияПозиционныхПараметров = ПозиционныеПараметры.Количество();
КонецФункции

Функция СледующийПозиционныйПараметр(Знач ПозиционныеПараметры)
	Если мПозицияПозиционныхПараметров = ПозиционныеПараметры.Количество() Тогда
		ВызватьИсключение "Неизвестный параметр в позиции " + мПозицияВСпискеТокенов;
	КонецЕсли;
	
	СтрПараметр = ПозиционныеПараметры[мПозицияПозиционныхПараметров];
	мПозицияПозиционныхПараметров = мПозицияПозиционныхПараметров + 1;
	Возврат СтрПараметр;
КонецФункции

Процедура Инит()
	Лог = Логирование.ПолучитьЛог("oscript.lib.cmdline");
	
	мПараметры = НоваяТаблицаПараметров();
	мПозиционныеПараметры = НоваяТаблицаПараметров();
	мКоманды   = Новый Соответствие;
КонецПроцедуры

Функция НоваяТаблицаПараметров()
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Имя");
	Таблица.Колонки.Добавить("ЭтоФлаг");
	Таблица.Колонки.Добавить("Пояснение");
	Таблица.Колонки.Добавить("ЭтоГлобальныйПараметр");
	Таблица.Колонки.Добавить("ЭтоКоллекция");
	
	Возврат Таблица;
	
КонецФункции

Функция ДобавитьПараметрВТаблицу(Знач Таблица, Знач Имя, Знач Пояснение, Знач Флаг, Знач Глобальный = Ложь)
	СтрПараметр = Таблица.Добавить();
	СтрПараметр.Имя       = Строка(Имя);
	СтрПараметр.ЭтоФлаг   = Флаг;
	СтрПараметр.Пояснение = Пояснение;
	СтрПараметр.ЭтоГлобальныйПараметр = Глобальный;
	СтрПараметр.ЭтоКоллекция = Ложь;

	Возврат СтрПараметр;
	
КонецФункции

Функция ДобавитьПараметрКоллекцияВТаблицу(Знач Таблица, Знач Имя, Знач Пояснение)

	СтрПараметр = ДобавитьПараметрВТаблицу(Таблица, Имя, Пояснение, Ложь);
	СтрПараметр.ЭтоКоллекция = Истина;

КонецФункции

Инит();
