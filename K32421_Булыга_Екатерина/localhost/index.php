<?php 
    include('connection.php');
    if (isset($_GET['idD'])) {
        $typeOfDepositD = $_GET['idD'];
        $qDeleteTypeOfDeposit = "DELETE FROM types_of_deposits WHERE type_of_deposit_id='$typeOfDepositD'";
        $pdo->query($qDeleteTypeOfDeposit);
    }
?>

<html>
    <head>
        <title>Панель администратора</title>
        <link rel="stylesheet" href="assets/styles/styles.css"/>
    </head>
    <body link="white" vlink="white" alink="white">
        <div class="title_table">
            <h1>Виды вкладов</h1>
            <div class="btn_add">
                <a href="create_type_of_deposit.php">Добавить запись</a>
            </div>
        </div>
        <div class="table">
            <form class="table_row title" method="post">
                <div class="table_cell id">
                    <p>№</p>
                </div>
                <div class="table_cell">
                    <p>Название</p>
                    <select name="name">
                        <option name="name_all" value="(SELECT name FROM types_of_deposits)" <?php if (!isset($_POST["name"]) || $_POST["name"] == "(SELECT name FROM types_of_deposits)") { echo "selected"; } ?>>ВСЕ</option>
                        <?php 
                            $qNamesOfTypes = "SELECT name FROM types_of_deposits ORDER BY type_of_deposit_id";
                            $namesOfTypes = $pdo->query($qNamesOfTypes);
                            while ($NameOfType = $namesOfTypes->fetch())
                            {
                                if (isset($_POST["name"]) && $_POST["name"] == "('" . $NameOfType['name'] . "')") {
                                    echo "<option name=\"".$NameOfType['name']."\" value=\"('".$NameOfType['name']."')\" selected>".$NameOfType['name']."</option>";
                                } else {
                                    echo "<option name=\"".$NameOfType['name']."\" value=\"('".$NameOfType['name']."')\">".$NameOfType['name']."</option>";
                                }
                                
                            }
                        ?>
                    </select>
                </div>
                <div class="table_cell descr">
                    <p>Описание</p>
                </div>
                <div class="table_cell">
                    <p>Процент</p>
                    <p>
                        <label>От</label>
                        <input name="min_percent" type="number" min="0" max="100" value=<?php if (isset($_POST['min_percent'])) {echo "\"".$_POST['min_percent']."\"";} else {echo "0";} ?>>
                    </p>
                    <p>
                        <label>До</label>
                        <input name="max_percent" type="number" min="0" max="100" value=<?php if (isset($_POST['max_percent'])) {echo "\"".$_POST['max_percent']."\"";} else {echo "100";} ?>>
                    </p>
                </div>
                <div class="table_cell">
                    <p>Снятие</p>
                    <select name="removable">
                        <option name="rem_all" value="('0', '1')" <?php if (!isset($_POST['removable']) || $_POST['removable'] == "('0', '1')") { echo "selected"; } ?>>ВСЕ</option>
                        <option name="rem_yes" value="('1')" <?php if (isset($_POST['removable']) && $_POST['removable'] == "('1')") { echo "selected"; } ?>>ДА</option>
                        <option name="rem_no" value="('0')" <?php if (isset($_POST['removable']) && $_POST['removable'] == "('0')") { echo "selected"; } ?>>НЕТ</option>
                    </select>
                </div>
                <div class="table_cell">
                    <p>Пополнение</p>
                    <select name="refillable">
                        <option name="ref_all" value="('0', '1')" <?php if (!isset($_POST['refillable']) || $_POST['refillable'] == "('0', '1')") { echo "selected"; } ?>>ВСЕ</option>
                        <option name="ref_yes" value="('1')" <?php if (isset($_POST['refillable']) && $_POST['refillable'] == "('1')") { echo "selected"; } ?>>ДА</option>
                        <option name="ref_no" value="('0')" <?php if (isset($_POST['refillable']) && $_POST['refillable'] == "('0')") { echo "selected"; } ?>>НЕТ</option>
                    </select>
                </div>
                <div class="table_cell">
                    <p>Минимальный период</p>
                    <p>
                        <label>От</label>
                        <input name="min_period_num" type="number" min="0" max="100" value=<?php if (isset($_POST['min_period_num'])) {echo "\"".$_POST['min_period_num']."\"";} else {echo "0";} ?>>
                        <select name="min_period_unit">
                        <option name="min_period_unit_days" value="days" required <?php if (!isset($_POST['min_period_unit']) || $_POST['min_period_unit'] == 'days') {echo "selected";} ?>>День</option>
                        <option name="min_period_unit_mons" value="mons" required <?php if (isset($_POST['min_period_unit']) && $_POST['min_period_unit'] == 'mons') {echo "selected";} ?>>Месяц</option>
                        <option name="min_period_unit_years" value="years" required <?php if (isset($_POST['min_period_unit']) && $_POST['min_period_unit'] == 'years') {echo "selected";} ?>>Год</option>
                        </select>
                    </p>
                    <p>
                        <label>До</label>
                        <input name="max_period_num" type="number" min="0" max="100" value=<?php if (isset($_POST['max_period_num'])) {echo "\"".$_POST['max_period_num']."\"";} else {echo "100";} ?>>
                        <select name="max_period_unit">
                        <option name="max_period_unit_days" value="days" required <?php if (isset($_POST['max_period_unit']) && $_POST['max_period_unit'] == 'days') {echo "selected";} ?>>День</option>
                        <option name="max_period_unit_mons" value="mons" required <?php if (isset($_POST['max_period_unit']) && $_POST['max_period_unit'] == 'mons') {echo "selected";} ?>>Месяц</option>
                        <option name="max_period_unit_years" value="years" required <?php if (!isset($_POST['max_period_unit']) || $_POST['max_period_unit'] == 'years') {echo "selected";} ?>>Год</option>
                        </select>
                    </p>
                </div>
                <div class="table_cell">
                    <p>Минимальная сумма</p>
                    <p>
                        <label>От</label>
                        <input name="min_balance" type="number" min="0" max="1000000000" value=<?php if (isset($_POST['min_balance'])) {echo "\"".$_POST['min_balance']."\"";} else {echo "0";} ?>>
                    </p>
                    <p>
                        <label>До</label>
                        <input name="max_balance" type="number" min="0" max="1000000000" value=<?php if (isset($_POST['max_balance'])) {echo "\"".$_POST['max_balance']."\"";} else {echo "1000000000";} ?>>
                    </p>
                </div>
                <div class="table_cell act">
                    <p>Действие</p>
                    <button type="submit">Выбрать</button>
                </div>
            </form>
            <?php
                if (isset($_POST['removable']) && isset($_POST['refillable']) && isset($_POST['name']) && isset($_POST['min_percent']) && isset($_POST['max_percent']) && isset($_POST['min_balance']) && isset($_POST['max_balance']) && isset($_POST['min_period_num']) && isset($_POST['max_period_num'])  && isset($_POST['min_period_unit']) && isset($_POST['max_period_unit'])) {
                    $qTypesOfDeposits = "SELECT * FROM types_of_deposits WHERE name IN ".$_POST['name']." AND removable IN ".$_POST['removable']." AND refillable IN ".$_POST['refillable']." AND percent >= '".$_POST['min_percent']."' AND percent <= '".$_POST['max_percent']."' AND initial_balance >= '".$_POST['min_balance']."' AND initial_balance <= '".$_POST['max_balance']."' AND minimal_period >= '".$_POST['min_period_num']." ".$_POST['min_period_unit']."' AND minimal_period <= '".$_POST['max_period_num']." ".$_POST['max_period_unit']."' ORDER BY type_of_deposit_id";
                    $resTypesOfDeposits = $pdo->query($qTypesOfDeposits);
                    while ($TypeOfDeposit = $resTypesOfDeposits->fetch())
                    {
                        if ($TypeOfDeposit['removable'] == '1') {
                            $removable = 'ДА';
                        } else {
                            $removable = 'НЕТ';
                        }
                        if ($TypeOfDeposit['refillable'] == '1') {
                            $refillable = 'ДА';
                        } else {
                            $refillable = 'НЕТ';
                        }
                        echo "
                        <div class=\"table_row\">
                            <div class=\"table_cell id\">
                                <p>".$TypeOfDeposit['type_of_deposit_id']."</p>
                            </div>
                            <div class=\"table_cell\">
                                <p>".$TypeOfDeposit['name']."</p>
                            </div>
                            <div class=\"table_cell descr\">
                                <p>".$TypeOfDeposit['description']."</p>
                            </div>
                            <div class=\"table_cell\">
                                <p>".$TypeOfDeposit['percent']."</p>
                            </div>
                            <div class=\"table_cell\">
                                <p>".$removable."</p>
                            </div>
                            <div class=\"table_cell\">
                                <p>".$refillable."</p>
                            </div>
                            <div class=\"table_cell\">
                                <p>".$TypeOfDeposit['minimal_period']."</p>
                            </div>
                            <div class=\"table_cell\">
                                <p>".$TypeOfDeposit['initial_balance']."</p>
                            </div>
                            <div class=\"table_cell act\">
                                <a href=\"edit_type_of_deposit.php?idA=".$TypeOfDeposit['type_of_deposit_id']."\"><img src=\"assets/images/edit.png\" width=\"20px\" height=\"20px\"></a>
                                <a href=\"?idD=".$TypeOfDeposit['type_of_deposit_id']."\"><img src=\"assets/images/delete.png\" width=\"20px\" height=\"20px\"></a>
                            </div>
                        </div>
                        ";
                    }
                }
            ?>
        </div>
    </body>
</html>