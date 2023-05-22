<?php
    include("../connection.php");

    if (isset($_GET['idA'])) {
        $type_of_deposit_id = $_GET['idA'];
        $type_of_deposit_name = $_POST['type_of_deposit_name'];
        $type_of_deposit_descr = $_POST['type_of_deposit_descr'];
        $type_of_deposit_percent = $_POST['type_of_deposit_percent'];
        $type_of_deposit_removable = $_POST['type_of_deposit_removable'];
        $type_of_deposit_refillable = $_POST['type_of_deposit_refillable'];
        $type_of_deposit_period_num = $_POST['type_of_deposit_period_num'];
        $type_of_deposit_period_unit = $_POST['type_of_deposit_period_unit'];
        $type_of_deposit_balance = $_POST['type_of_deposit_balance'];

        $qTypeOfDeposit = "UPDATE types_of_deposits" . 
        " SET name = '$type_of_deposit_name'," . 
        " description = '$type_of_deposit_descr'," . 
        " percent = '$type_of_deposit_percent'," . 
        " removable = '$type_of_deposit_removable'," .
        " refillable = '$type_of_deposit_refillable'," .
        " minimal_period = '$type_of_deposit_period_num $type_of_deposit_period_unit'," . 
        " initial_balance = '$type_of_deposit_balance'" .
        " WHERE type_of_deposit_id = '$type_of_deposit_id'";

        $pdo->query($qTypeOfDeposit);
        
        header("location: ../index.php");
    }
?>
