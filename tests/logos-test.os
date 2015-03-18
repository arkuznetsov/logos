﻿
Перем юТест;
Перем РаботаСТестами;
Перем Лог;

Перем мСообщенияЛога;

Функция ПолучитьСписокТестов(Знач ЮнитТестирование) Экспорт

	МассивТестов = Новый Массив;
	МассивТестов.Добавить("Тест_ДолженСоздатьЛоггерПоУмолчанию");
	МассивТестов.Добавить("Тест_ДолженПроверитьУровниВывода");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоЗарегистрированыАппендеры");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоУровниВыводаИзменяются");
	МассивТестов.Добавить("Тест_ДолженПроверитьЧтоАппендерУстановлен");
	
	Возврат МассивТестов;

КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	ПодключитьСценарий(РаботаСТестами.КаталогИсходников() + "/logging/log.os", "Логгер");
	Лог = Новый Логгер;
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Лог.Закрыть();
	Лог = Неопределено;
	мСообщенияЛога = Неопределено;
КонецПроцедуры

Процедура Тест_ДолженСоздатьЛоггерПоУмолчанию() Экспорт
	
	юТест.ПроверитьРавенство(Лог.Уровни().Информация, Лог.Уровень());
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьУровниВывода() Экспорт
	
	юТест.ПроверитьРавенство(Лог.Уровни().Ошибка, Лог.Уровни().Ошибка);
	юТест.ПроверитьРавенство(Лог.Уровни().Отключить, Лог.Уровни().Отключить);
	юТест.ПроверитьРавенство(Лог.Уровни().Отладка, Лог.Уровни().Отладка);
	юТест.ПроверитьРавенство(Лог.Уровни().Информация, Лог.Уровни().Информация);
	юТест.ПроверитьРавенство(Лог.Уровни().Предупреждение, Лог.Уровни().Предупреждение);
	юТест.ПроверитьРавенство(Лог.Уровни().КритичнаяОшибка, Лог.Уровни().КритичнаяОшибка);
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоЗарегистрированыАппендеры() Экспорт
	
	// данные типы регистрируются при создании логгера
	ВФайл = Новый ВыводЛогаВФайл();
	юТест.ПроверитьРавенство(Тип("ВыводЛогаВФайл"), ТипЗнч(ВФайл));
	
	Консоль = Новый ВыводЛогаВКонсоль();
	юТест.ПроверитьРавенство(Тип("ВыводЛогаВКонсоль"), ТипЗнч(Консоль));
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоУровниВыводаИзменяются() Экспорт
	
	юТест.ПроверитьРавенство(Лог.Уровни().Информация, Лог.Уровень());
	
	Лог.УстановитьУровень(Лог.Уровни().Предупреждение);
	
	юТест.ПроверитьРавенство(Лог.Уровни().Предупреждение, Лог.Уровень());
	
КонецПроцедуры

Процедура Тест_ДолженПроверитьЧтоАппендерУстановлен() Экспорт
	мСообщенияЛога = Новый Массив;
	Лог.ДобавитьСпособВывода(ЭтотОбъект);
	Лог.Информация("Привет");
	юТест.ПроверитьРавенство("Привет", мСообщенияЛога[0]);
КонецПроцедуры

////////////////////////////
// Методы аппендера

Процедура Вывести(Знач Сообщение) Экспорт
	мСообщенияЛога.Добавить(Сообщение);
КонецПроцедуры

Процедура Закрыть() Экспорт
	мСообщенияЛога = Неопределено;
КонецПроцедуры

РаботаСТестами = ЗагрузитьСценарий("test-commons.os");