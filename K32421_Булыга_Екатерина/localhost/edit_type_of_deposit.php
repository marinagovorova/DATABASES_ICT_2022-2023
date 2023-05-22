<?php
    session_start();
    include("connection.php");
?>

<html>
    <head>
        <title>Панель администратора</title>
        <link rel="stylesheet" href="assets/styles/styles.css"/>
    </head>
    <body>
        <div class="content">
            <div class="title_table">
                <h1>Изменение записи</h1>
                <div class="btn_add">
                    <a href="index.php">Вернуться</a>
                </div>
            </div>

            <?php
                if (isset($_GET['idA'])) {
                    $type_of_deposit_id = $_GET['idA'];
                }

                $qInfoTypeOfDeposit = "SELECT * FROM types_of_deposits WHERE type_of_deposit_id='$type_of_deposit_id'";
                $InfoTypeOfDeposit = $pdo->query($qInfoTypeOfDeposit)->fetch();
            ?>

            <form action="<?php echo "php-handler/edit_type_of_deposit.php?idA=$type_of_deposit_id" ?>" class="table_add" method="post">
            <div class="table_add_row">
                    <label>Название</label><br>
                    <input type="text" name="type_of_deposit_name" maxlength="100" required value=<?php echo "\"".$InfoTypeOfDeposit['name']."\"" ?>>
                </div>

                <div class="table_add_row">
                    <label>Описание</label><br>
                    <input type="text" name="type_of_deposit_descr" maxlength="500" required value=<?php echo "\"".$InfoTypeOfDeposit['description']."\"" ?>>
                </div>

                <div class="table_add_row">
                    <label>Процент</label><br>
                    <input type="number" name="type_of_deposit_percent" min="0" max="100" required value=<?php echo "\"".$InfoTypeOfDeposit['percent']."\"" ?>>
                </div>

                <div class="table_add_row">
                    <label>Снятие</label><br>
                    <input type="radio" name="type_of_deposit_removable" value="1" required <?php if ($InfoTypeOfDeposit['removable'] == '1') {echo "checked";} ?>>ДА<br>
                    <input type="radio" name="type_of_deposit_removable" value="0" required <?php if ($InfoTypeOfDeposit['removable'] == '0') {echo "checked";} ?>>НЕТ<br>
                </div>

                <div class="table_add_row">
                    <label>Пополнение</label><br>
                    <input type="radio" name="type_of_deposit_refillable" value="1" required <?php if ($InfoTypeOfDeposit['refillable'] == '1') {echo "checked";} ?>>ДА<br>
                    <input type="radio" name="type_of_deposit_refillable" value="0" required <?php if ($InfoTypeOfDeposit['refillable'] == '0') {echo "checked";} ?>>НЕТ<br>
                </div>

                <div class="table_add_row">
                    <label>Минимальный период</label><br>
                    <input type="number" name="type_of_deposit_period_num" min="0" max="100" required value=<?php if ($InfoTypeOfDeposit['minimal_period'] == '00:00:00') { echo "\"0\""; } else { list($num, $unit) = explode(' ', $InfoTypeOfDeposit['minimal_period']); echo "\"".$num."\""; } ?>>
                    <select name="type_of_deposit_period_unit">
                    <option name="type_of_deposit_period_unit_days" value="days" required <?php if (str_contains($InfoTypeOfDeposit['minimal_period'], 'days') || $InfoTypeOfDeposit['minimal_period'] == '00:00:00') {echo "selected";} ?>>День</option>
                    <option name="type_of_deposit_period_unit_mons" value="mons" required <?php if (str_contains($InfoTypeOfDeposit['minimal_period'], 'mons')) {echo "selected";} ?>>Месяц</option>
                    <option name="type_of_deposit_period_unit_years" value="years" required <?php if (str_contains($InfoTypeOfDeposit['minimal_period'], 'year')) {echo "selected";} ?>>Год</option>
                    </select>
                </div>

                <div class="table_add_row">
                    <label>Минимальная сумма</label><br>
                    <input type="number" name="type_of_deposit_balance" min="0" max="1000000000" required value=<?php echo "\"".$InfoTypeOfDeposit['initial_balance']."\"" ?>>
                </div>
                <div class="btn_add_one">
                    <button type="submit">Изменить</button>
                </div>
            </form>
        </div>
    </body>
</html>