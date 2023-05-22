<?php
    include("connection.php");
?>

<html>
    <head>
        <title>Панель администратора</title>
        <link rel="stylesheet" href="assets/styles/styles.css"/>
    </head>
    <body link="white" vlink="white" alink="white">
        <div class="content">
            <div class="title_table">
                <h1>Создание записи</h1>
                <div class="btn_add">
                    <a href="index.php">Вернуться</a>
                </div>
            </div>
            <form action="php-handler/create_type_of_deposit.php" class="table_add" method="post">
                <div class="table_add_row">
                    <label>Название</label><br>
                    <input type="text" name="type_of_deposit_name" maxlength="100" required>
                </div>

                <div class="table_add_row">
                    <label>Описание</label><br>
                    <input type="text" name="type_of_deposit_descr" maxlength="500" required>
                </div>

                <div class="table_add_row">
                    <label>Процент</label><br>
                    <input type="number" name="type_of_deposit_percent" min="0" max="100" required>
                </div>

                <div class="table_add_row">
                    <label>Снятие</label><br>
                    <input type="radio" name="type_of_deposit_removable" value="1" required>ДА<br>
                    <input type="radio" name="type_of_deposit_removable" value="0" required>НЕТ<br>
                </div>

                <div class="table_add_row">
                    <label>Пополнение</label><br>
                    <input type="radio" name="type_of_deposit_refillable" value="1">ДА<br>
                    <input type="radio" name="type_of_deposit_refillable" value="0">НЕТ<br>
                </div>

                <div class="table_add_row">
                    <label>Минимальный период</label><br>
                    <input type="number" name="type_of_deposit_period_num" min="0" max="100">
                    <select name="type_of_deposit_period_unit" required>
                    <option name="type_of_deposit_period_unit_days" value="days" required>День</option>
                    <option name="type_of_deposit_period_unit_mons" value="mons" required>Месяц</option>
                    <option name="type_of_deposit_period_unit_years" value="years" required>Год</option>
                    </select>
                </div>

                <div class="table_add_row">
                    <label>Минимальная сумма</label><br>
                    <input type="number" name="type_of_deposit_balance" min="0" max="1000000000" required>
                </div>
                <div class="btn_add_one">
                    <button type="submit">Создать</button>
                </div>
            </form>
        </div>
    </body>
</html>