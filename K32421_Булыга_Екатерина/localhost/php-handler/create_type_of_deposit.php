<?php
    include("../connection.php");

    $type_of_deposit_name = $_POST['type_of_deposit_name'];
    $type_of_deposit_descr = $_POST['type_of_deposit_descr'];
    $type_of_deposit_percent = $_POST['type_of_deposit_percent'];
    $type_of_deposit_removable = $_POST['type_of_deposit_removable'];
    $type_of_deposit_refillable = $_POST['type_of_deposit_refillable'];
    $type_of_deposit_period_num = $_POST['type_of_deposit_period_num'];
    $type_of_deposit_period_unit = $_POST['type_of_deposit_period_unit'];
    $type_of_deposit_balance = $_POST['type_of_deposit_balance'];

    $new_id = ($pdo->query("SELECT MAX(type_of_deposit_id) AS id FROM types_of_deposits")->fetch())['id'] + 1;

    $qCreateTypeOfDeposit = "INSERT INTO types_of_deposits (type_of_deposit_id, name, description, percent, removable, refillable, minimal_period, initial_balance)" .
    " VALUES ('$new_id', '$type_of_deposit_name', '$type_of_deposit_descr', '$type_of_deposit_percent', '$type_of_deposit_removable', '$type_of_deposit_refillable', '$type_of_deposit_period_num $type_of_deposit_period_unit', '$type_of_deposit_balance')";
    $pdo->query($qCreateTypeOfDeposit);
    header("location: ../index.php");
?>