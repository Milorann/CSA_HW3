### Листеренко Ольга Руслановна ###
### БПИ 217 ###
  
### Вариант 12 ###
### Задача ###
Разработать программы на языках программирования C и Ассемблер, выполняющие вычисления над числами с плавающей точкой. Разработанные программы должны принимать числа в допустимом диапазоне. Например, нужно учитывать области определения и допустимых значений, если это связано с условием задачи.  

Разработать программу, вычисляющую с помощью степенного ряда
с точностью не хуже 0,05% значение функции tan(x) для заданного
параметра x.   
    
### Тесты ###
Все программы выдают одинаковый результат и были протестированы на следующих примерах:  

#### 1 тест ####
Указано неверное количество аргументов коммандной строки.  

##### Результат (одинаковый во всех программах) #####
Wrong number of command line arguments. Termination.  

#### 2 тест ####
Файл для чтения не существует и пользователь выбрал чтение из файла.  

##### Результат (одинаковый во всех программах) #####
Cannot open file.  

#### 3 тест ####
В файле число не из интервала (-pi/2; pi/2). Например, файл Tests/test3.  

##### Результат (одинаковый во всех программах) #####
Wrong number for tg. Termination.  

#### 4 тест ####
Ввод из файла. Файл в папке Tests/test4.txt.  
1  

##### Результат (одинаковый во всех программах) #####
Number: 1.000000  
Power series answer: 1.557245  
Precise answer: 1.557408  
Time spent: 0  

#### 5 тест ####
Генерация числа. Такой же результат для сгенерированного числа получен через ввод из файла Tests/test5.txt.  

##### Результат (одинаковый во всех программах) #####
Number: -0.569134  
Power series answer: -0.639747  
Precise answer: -0.639747  
Time spent: 0  

#### 6 тест ####
Файл для чтения не существует и пользователь выбрал генерацию. Такой же результат для сгенерированного числа получен через ввод из файла Tests/test6.txt.  

##### Результат (одинаковый во всех программах) #####
Number: 0.890059  
Power series answer: 1.234737  
Precise answer: 1.234749  
Time spent: 0  

#### 7 тест ####
choice не 1 и не 2.  

##### Результат (одинаковый во всех программах) #####
Number: 0.000000  
Power series answer: 0.000000  
Precise answer: 0.000000  
Time spent: 0  

#### 8 тест ####
Некорректное число repeats. При choice = 2.  

##### Результат (одинаковый во всех программах) #####
Number: -0.292066  
Power series answer: 0.000000  
Precise answer: -0.300664  
Time spent: 0  

#### 9 тест ####
Некорректное число repeats. При choice = 1 и существующем файле ввода (Tests/test4.txt).  

##### Результат (одинаковый во всех программах) #####
Number: 1.000000  
Power series answer: 0.000000  
Precise answer: 1.557408  
Time spent: 0  

#### 10 тест ####
Некорректное число repeats. При choice = 1 и несуществующем файле ввода.  

##### Результат (одинаковый во всех программах) #####
Cannot open file.  

### Программа на C ###
Код находится в папке Code_in_C.  
  
### Оптимизированная программа на ассембелере с комментариями ### 
Код находится в папке Assembly_modified.  
   
### Программа на ассембелере от компилятора ### 
Код находится в файле Assembly_from_C.  
Код получен путем компиляции кода на C следующим образом:  
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./file_name.c -S -o ./file_name.s
  
### Информация, подтверждающая выполнение задания на 8 ###
В программе ищется значение тангенса для числа, модуль которого меньше pi/2.  
Числа Бернулли и факториалы описаны до n = 20, т.к. факториалы чисел больше 20 уже не помещаются в unsigned long long. Поэтому степенной ряд вычисляется до 10 члена.  
Приведен код на C на оценку 8.  
Программу следует запускать в виде "./program.exe input.txt output.txt choice repeats". choice — 1 или 2 (1 — ввод из файла, 2 — генерация). repeats — натуральное число повторений вычислений для увеличения длительности работы программы.  
Добавлены комментарии.  
Удалены из конца кода строки ниже ret, а из начала информация о файле, из которой получили код на ассемблере.  
Убраны лишние макросы, в том числе endbr64.    
Удалены cdqe и nop, добавленные компилятором для дополнения.  
Удалены промежуточные присваивания на подобии:  
![image](https://user-images.githubusercontent.com/57359954/203371590-a1805288-767c-47fa-8b19-54ffaa3db3ca.png)  
![image](https://user-images.githubusercontent.com/57359954/203373413-ff75e846-8ec8-4a3f-b45b-f199d4c03a00.png)  
или  
![image](https://user-images.githubusercontent.com/57359954/203594905-dd3ddd84-1327-4d5e-9b28-17e57f3284ce.png)  
![image](https://user-images.githubusercontent.com/57359954/203594996-5b6cd3a9-ce43-43eb-b11b-6626f2262eec.png)  
или  
![image](https://user-images.githubusercontent.com/57359954/203595748-b9d27f55-822a-49f4-8cdd-882b09e0abbd.png)  
![image](https://user-images.githubusercontent.com/57359954/203595818-74e132dd-2191-401e-b781-1920b93dcdae.png)  
или  
![image](https://user-images.githubusercontent.com/57359954/203599270-ba9b11d9-3b42-46f3-bb2b-980cff03ef33.png)  
![image](https://user-images.githubusercontent.com/57359954/203599385-76005cfe-1ba4-4fd4-89d0-6a5c651c7928.png)  

Программа протестирована на приведенных тестах. Результаты совпадают с результатами программы на C.  
В программе использованы следующие функции с аргументами: ввод из файла (на вход имя файла), вывод в файл (на вход имя файла, начальное значение, ответ, точный ответ, длительность вычислений), тангенс (на вход x).  
Использованы локальные переменные myfile, i, end, start, x, ans, choice.  
Добавлены комментарии о передаче параметров (фактических и формальных).
Программа протестирована на приведенных тестах. Результаты совпадают с результатами программы на C.  
-80[rbp] заменен на r15 (argv).  
-36[rbp] заменен на r12d (i — в основной подпрограмме).  
-8[rbp] заменен на r14 (myfile в input и output).  
-12[rbp] заменен на r13d (i в tg).   
-24[rpb] заменен на r12 (inp в input, outp в output).  
Комментарии об использовании регистров добавлены.  
Программа протестирована на приведенных тестах. Результаты совпадают с результатами программы на C.  
Необработанный файл functions.o занимает 3536 байт, обработанный — 3072 байт. Начальный main.o — 2288 байт, конечный — 1904 байта. Можно говорить о заметном сокращении кода.  
Программа реализована в виде двух единиц компиляции.  
Реализовано использование файлов. В файле для чтения находится одно число. Имена файлов являются аргументами командной строки. Первый — файл, из которого читаем, второй — в который записываем: "./program.exe input.txt output.txt choice repeats". Проверяется количество аргументов, а также существование файла для чтения.  
Подготовлены файлы для тестирования. Расположены в папке Tests.  
В программу добавлен генератор случайного числе от -1.5707 до 1.5707. Выбор способа получения числа осуществляется через аргумент командной строки.  
  
Производится замер времени выполнения 10000000 вычислений тангенса.  
#### Результаты замеров на тестах 4, 5 и 6 ####  
##### 4 тест #####
1  
36 секунд C.  
28 секунд оптимизированный ассемблер.  

##### 5 тест #####
-0.569134  
37 секунд С.  
29 секунд оптимизированный ассемблер.  

##### 6 тест #####
0.890059  
36 секунд необработанный ассемблер.  
28 секунд оптимизированный ассемблер.  
