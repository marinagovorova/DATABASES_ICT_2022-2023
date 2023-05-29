db.unicorns.deleteMany({});
db.towns.deleteMany({});
db.habitats.deleteMany({});
db.numbers.deleteMany({});
// Практическое задание 8.1.1:
// Создайте базу данных learn.
use learn
// Заполните коллекцию единорогов unicorns:
db.unicorns.insertMany([
    {name: 'Horny', loves: ['carrot','papaya'], weight: 600, gender: 'm', vampires: 63},
    {name: 'Aurora', loves: ['carrot', 'grape'], weight: 450, gender: 'f', vampires: 43},
    {name: 'Unicrom', loves: ['energon', 'redbull'], weight: 984, gender: 'm', vampires: 182},
    {name: 'Roooooodles', loves: ['apple'], weight: 575, gender: 'm', vampires: 99},
    {name: 'Solnara', loves:['apple', 'carrot', 'chocolate'], weight:550, gender:'f', vampires:80},
    {name:'Ayna', loves: ['strawberry', 'lemon'], weight: 733, gender: 'f', vampires: 40},
    {name:'Kenny', loves: ['grape', 'lemon'], weight: 690,  gender: 'm', vampires: 39},
    {name: 'Raleigh', loves: ['apple', 'sugar'], weight: 421, gender: 'm', vampires: 2},
    {name: 'Leia', loves: ['apple', 'watermelon'], weight: 601, gender: 'f', vampires: 33},
    {name: 'Pilot', loves: ['apple', 'watermelon'], weight: 650, gender: 'm', vampires: 54},
    {name: 'Nimue', loves: ['grape', 'carrot'], weight: 540, gender: 'f'}
])


db.unicorns.find();

// можно и без скобок
doc = {name: 'Dunx', loves: ['grape', 'watermelon'], weight: 704, gender: 'm', vampires: 165};
db.unicorns.insertOne(doc);

db.unicorns.find();

// Практическое задание 8.1.2

// Сформируйте запросы для вывода списков самцов и самок единорогов. Ограничьте список самок первыми тремя особями. Отсортируйте списки по имени.

db.unicorns.find({gender: 'm'}).limit(3).sort({name: 1});
db.unicorns.find({gender: 'f'}).limit(3);

// Найдите всех самок, которые любят carrot. Ограничьте этот список первой особью с помощью функций findOne и limit.

db.unicorns.findOne({gender: 'f', loves: 'carrot'});


// Практическое задание 8.1.3
// Модифицируйте запрос для вывода списков самцов единорогов, исключив из результата информацию о предпотениях и поле.

db.unicorns.find({gender: 'm'}, {loves: 0, gender:0});

// 8.1.4
// Вывести список единорогов в обратном порядке добавления.
db.unicorns.find().sort({$natural: -1});

// 8.1.5
// Вывести список единорогов с названием первого любимого предпочтения, исключив идентификатор.
db.unicorns.find({}, {_id:0, loves: {$slice: 1}});


// 8.1.6
// Вывести список самок единорогов весом от полутонны до 700 кг, исключив вывод идентификатора.

db.unicorns.find({gender: 'f', weight: {$gt: 500, $lt: 700}}, {_id: 0})
// 8.1.7

// Вывести список самцов единорогов весом от полутонны и предпочитающих grape и lemon, исключив вывод идентификатора.
db.unicorns.find({
    gender: 'm',
    weight: {$gt: 500},
    loves: {$all: ['grape', 'lemon']}},
    {_id: 0});


// 8.1.8
// Найти всех единорогов, не имеющих ключ vampires.

db.unicorns.find({vampires: {$exists: false}})

// 8.1.9
// Вывести список упорядоченный список имен самцов единорогов с информацией об их первом предпочтении.
db.unicorns.find({gender: 'm'}, {_id: 0, name: 1, loves: {$slice: 1}}).sort({name: 1});


// 8.2.1
// Создайте коллекцию towns
db.towns.insertMany([
    {name: "Punxsutawney ",
    populatiuon: 6200,
    last_sensus: ISODate("2008-01-31"),
    famous_for: [""],
    mayor: {
       name: "Jim Wehrle"
    }},
    {name: "New York",
    populatiuon: 22200000,
    last_sensus: ISODate("2009-07-31"),
    famous_for: ["status of liberty", "food"],
    mayor: {
       name: "Michael Bloomberg",
    party: "I"}},
    {name: "Portland",
    populatiuon: 528000,
    last_sensus: ISODate("2009-07-20"),
    famous_for: ["beer", "food"],
    mayor: {
       name: "Sam Adams",
    party: "D"}}
    ]);

// Сформировать запрос, который возвращает список городов с независимыми мэрами (party="I"). Вывести только название города и информацию о мэре.
db.towns.find({"mayor.party": 'I'}, {mayor: 1, name: 1});
// Сформировать запрос, который возвращает список беспартийных мэров (party отсутствует). Вывести только название города и информацию о мэре.
db.towns.find({"mayor.party": {$exists: false}}, {mayor: 1, name: 1});

// 8.2.2

db.unicorns.deleteMany({});
db.unicorns.insertMany([
    {name: 'Horny', loves: ['carrot','papaya'], weight: 600, gender: 'm', vampires: 63},
    {name: 'Aurora', loves: ['carrot', 'grape'], weight: 450, gender: 'f', vampires: 43},
    {name: 'Unicrom', loves: ['energon', 'redbull'], weight: 984, gender: 'm', vampires: 182},
    {name: 'Roooooodles', loves: ['apple'], weight: 575, gender: 'm', vampires: 99},
    {name: 'Solnara', loves:['apple', 'carrot', 'chocolate'], weight:550, gender:'f', vampires:80},
    {name:'Ayna', loves: ['strawberry', 'lemon'], weight: 733, gender: 'f', vampires: 40},
    {name:'Kenny', loves: ['grape', 'lemon'], weight: 690,  gender: 'm', vampires: 39},
    {name: 'Raleigh', loves: ['apple', 'sugar'], weight: 421, gender: 'm', vampires: 2},
    {name: 'Leia', loves: ['apple', 'watermelon'], weight: 601, gender: 'f', vampires: 33},
    {name: 'Pilot', loves: ['apple', 'watermelon'], weight: 650, gender: 'm', vampires: 54},
    {name: 'Nimue', loves: ['grape', 'carrot'], weight: 540, gender: 'f'},
    {name: 'Dunx', loves: ['grape', 'watermelon'], weight: 704, gender: 'm', vampires: 165}
]);

// Сформировать функцию для вывода списка самцов единорогов.
male = function() {return this.gender == 'm'}

// Создать курсор для этого списка из первых двух особей с сортировкой в лексикографическом порядке.
var cursor = db.unicorns.find(male); null;
var cursor = db.unicorns.find({gender: 'm'}); null;
var cursor = cursor.limit(2).sort({name:1});null;
// Вывести результат, используя forEach.
cursor.forEach(function (obj){print(obj.name);});


//8.2.3
// Вывести количество самок единорогов весом от полутонны до 600 кг.
db.unicorns.find({weight: {$gt: 500, $lt: 600}}).count();
// 8.2.4
// Вывести список предпочтений.
db.unicorns.distinct("loves")
// 8.2.5
// Посчитать количество особей единорогов обоих полов.
db.unicorns.aggregate({"$group": {_id: "$gender", count:{$sum:1}}})


// 8.2.6
// save is deprecated
db.unicorns.save({name: 'Barny', loves: ['grape'], weight:340, gender: 'm'});
// I will use insertOne instead
db.unicorns.insertOne({name: 'Barny', loves: ['grape'], weight:340, gender: 'm'});
db.unicorns.find({name: 'Barny'});

// 8.2.7
// Для самки единорога Ayna внести изменения в БД: теперь ее вес 800, она убила 51 вапмира.
db.unicorns.updateOne({name: 'Ayna'}, {$set: {weight: 800, vampires: 51}}, {upsert: false});
// Проверить содержимое коллекции unicorns.
db.unicorns.find({name: 'Ayna'});

//8.2.8
// Для самца единорога Raleigh внести изменения в БД: теперь он любит рэдбул.
db.unicorns.updateOne({gender: 'm', name: 'Raleigh'}, {$set:{loves: ["redbull"]}}, {upsert: false});
// Проверить содержимое коллекции unicorns.
db.unicorns.find({gender: 'm', name: 'Raleigh'});
// 8.2.9
// Всем самцам единорогов увеличить количество убитых вапмиров на 5.
db.unicorns.updateMany({gender: 'm'}, {$inc: {vampires: 5}})
// Проверить содержимое коллекции unicorns.
db.unicorns.find({gender: 'm'});


// 8.2.10
// Изменить информацию о городе Портланд: мэр этого города теперь беспартийный.
db.towns.updateOne({name: 'Portland'}, {$unset: {"mayor.party": 1}});
// Проверить содержимое коллекции towns.
db.towns.find({name: 'Portland'}, {mayor: 1});

// 8.2.11
// Изменить информацию о самце единорога Pilot: теперь он любит и шоколад.
db.unicorns.updateOne({name: 'Pilot'}, {$push: {loves: 'chocolate'}})
// Проверить содержимое коллекции unicorns.
db.unicorns.find({name: 'Pilot'});

// 8.2.12
// Изменить информацию о самке единорога Aurora: теперь она любит еще и сахар, и лимоны.
db.unicorns.updateOne(
    {name: 'Aurora'},
    {$push: {loves: {$each: ['sugar', 'lemons']}}});
// Проверить содержимое коллекции unicorns.
db.unicorns.find({name: 'Aurora'});


// 8.2.13
db.towns.deleteMany({});
db.towns.insertMany([
    {name: "Punxsutawney ",
    populatiuon: 6200,
    last_sensus: ISODate("2008-01-31"),
    famous_for: [""],
    mayor: {
       name: "Jim Wehrle"
    }},
    {name: "New York",
    populatiuon: 22200000,
    last_sensus: ISODate("2009-07-31"),
    famous_for: ["status of liberty", "food"],
    mayor: {
       name: "Michael Bloomberg",
    party: "I"}},
    {name: "Portland",
    populatiuon: 528000,
    last_sensus: ISODate("2009-07-20"),
    famous_for: ["beer", "food"],
    mayor: {
       name: "Sam Adams",
    party: "D"}}
    ]);
// Удалите документы с беспартийными мэрами.
db.towns.deleteMany({"mayor.party": {$exists: false}});
// Проверьте содержание коллекции.
db.towns.find({}, {mayor: 1});
// Очистите коллекцию.
db.towns.deleteMany({});
// Просмотрите список доступных коллекций.
show collections

// 8.3.1
db.unicorns.deleteMany({});
db.unicorns.insertMany([
    {name: 'Horny', loves: ['carrot','papaya'], weight: 600, gender: 'm', vampires: 63},
    {name: 'Aurora', loves: ['carrot', 'grape'], weight: 450, gender: 'f', vampires: 43},
    {name: 'Unicrom', loves: ['energon', 'redbull'], weight: 984, gender: 'm', vampires: 182},
    {name: 'Roooooodles', loves: ['apple'], weight: 575, gender: 'm', vampires: 99},
    {name: 'Solnara', loves:['apple', 'carrot', 'chocolate'], weight:550, gender:'f', vampires:80},
    {name:'Ayna', loves: ['strawberry', 'lemon'], weight: 733, gender: 'f', vampires: 40},
    {name:'Kenny', loves: ['grape', 'lemon'], weight: 690,  gender: 'm', vampires: 39},
    {name: 'Raleigh', loves: ['apple', 'sugar'], weight: 421, gender: 'm', vampires: 2},
    {name: 'Leia', loves: ['apple', 'watermelon'], weight: 601, gender: 'f', vampires: 33},
    {name: 'Pilot', loves: ['apple', 'watermelon'], weight: 650, gender: 'm', vampires: 54},
    {name: 'Nimue', loves: ['grape', 'carrot'], weight: 540, gender: 'f'},
    {name: 'Dunx', loves: ['grape', 'watermelon'], weight: 704, gender: 'm', vampires: 165}
]);

// Создайте коллекцию зон обитания единорогов, указав в качестве идентификатора кратко название зоны, далее включив полное название и описание.
db.habitats.insertMany([
    {_id: 'ru', name: 'russia', desctiption: 'dangerous place'},
    {_id: 'us', name: 'USA', desctiption: 'tech advanced place'},
    {_id: 'uk', name: 'united kingdom', desctiption: 'cultural place'}
]);
// Включите для нескольких единорогов в документы ссылку на зону обитания, использую второй способ автоматического связывания.
db.unicorns.updateOne({name: 'Horny'},
    {$set: {habitat: {$ref:"habitats", $id: 'ru'}}});
db.unicorns.updateOne({name: 'Aurora'},
    {$set: {habitat: {$ref:"habitats", $id: 'us'}}});

// Проверьте содержание коллекции едиорогов.
db.unicorns.find();

// шаманим с получением $id
horny = db.unicorns.findOne({name: 'Horny'});
db.habitats.find({_id: horny.habitat.$id});
db.habitats.find({_id: 'ru'})

// 8.3.2

db.unicorns.deleteMany({});

db.unicorns.insertOne({name: 'Horny', dob: new Date(1992,2,13,7,47), loves: ['carrot','papaya'], weight: 600, gender: 'm', vampires: 63});
db.unicorns.insertOne({name: 'Aurora', dob: new Date(1991, 1, 24, 13, 0), loves: ['carrot', 'grape'], weight: 450, gender: 'f', vampires: 43});
db.unicorns.insertOne({name: 'Unicrom', dob: new Date(1973, 1, 9, 22, 10), loves: ['energon', 'redbull'], weight: 984, gender: 'm', vampires: 182});
db.unicorns.insertOne({name: 'Roooooodles', dob: new Date(1979, 7, 18, 18, 44), loves: ['apple'], weight: 575, gender: 'm', vampires: 99});
db.unicorns.insertOne({name: 'Solnara', dob: new Date(1985, 6, 4, 2, 1), loves:['apple', 'carrot', 'chocolate'], weight:550, gender:'f', vampires:80});
db.unicorns.insertOne({name:'Ayna', dob: new Date(1998, 2, 7, 8, 30), loves: ['strawberry', 'lemon'], weight: 733, gender: 'f', vampires: 40});
db.unicorns.insertOne({name:'Kenny', dob: new Date(1997, 6, 1, 10, 42), loves: ['grape', 'lemon'], weight: 690,  gender: 'm', vampires: 39});
db.unicorns.insertOne({name: 'Raleigh', dob: new Date(2005, 4, 3, 0, 57), loves: ['apple', 'sugar'], weight: 421, gender: 'm', vampires: 2});
db.unicorns.insertOne({name: 'Leia', dob: new Date(2001, 9, 8, 14, 53), loves: ['apple', 'watermelon'], weight: 601, gender: 'f', vampires: 33});
db.unicorns.insertOne({name: 'Pilot', dob: new Date(1997, 2, 1, 5, 3), loves: ['apple', 'watermelon'], weight: 650, gender: 'm', vampires: 54});
db.unicorns.insertOne ({name: 'Nimue', dob: new Date(1999, 11, 20, 16, 15), loves: ['grape', 'carrot'], weight: 540, gender: 'f'});
db.unicorns.insertOne({name: 'Dunx', dob: new Date(1976, 6, 18, 18, 18), loves: ['grape', 'watermelon'], weight: 704, gender: 'm', vampires: 165})

// Проверьте, можно ли задать для коллекции  unicorns индекс для ключа name с флагом unique.
db.unicorns.createIndex({name: 1},  {unique: true})

// 8.3.3
// Получите информацию о всех индексах коллекции unicorns .
db.unicorns.getIndexes();
// Удалите все индексы, кроме индекса для идентификатора.
db.unicorns.dropIndex('name_1');
// Попытайтесь удалить индекс для идентификатора.
db.unicorns.dropIndex('_id_');


// 8.3.4
db.numbers.deleteMany({});
// Создайте объемную коллекцию numbers
arr = [];
for (i=0; i<100000; i++)
{
    arr.push({value: i})
}
db.numbers.insertMany(arr);


function measureMeanTime(n){
    const executionTimes = [];
    for (i=0; i<n; i++){
        executionTime = db.numbers.find({}).sort({value: -1}).limit(4).explain("executionStats").executionStats.executionTimeMillis;
        executionTimes.push(executionTime);
    }
    const sm = executionTimes.reduce((acc, val) => acc + val, 0);
    return sm / n;
}
print(measureMeanTime(5));
// Создайте индекс для ключа value.
db.numbers.createIndex({"value": 1});
db.numbers.getIndexes();
// Сравните время выполнения запросов с индексом и без. Дайте ответ на вопрос: какой запрос более эффективен?
print(measureMeanTime(5));


db.version();