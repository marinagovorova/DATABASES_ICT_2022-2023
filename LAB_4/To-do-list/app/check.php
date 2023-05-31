<?php

if(isset($_POST['id'])){
    require '../db_conn.php';

    $id = $_POST['id'];

    if(empty($id)){
        echo 'error';
    } else {
        // Check the current value of checked column for the task
        $stmt = $conn->prepare("SELECT checked FROM todo WHERE id=?");
        $stmt->execute([$id]);
        $todo = $stmt->fetch();
        $checked = $todo['checked'] ? 0 : 1;

        // Update the checked column for the task
        $stmt = $conn->prepare("UPDATE todo SET checked=? WHERE id=?");
        $stmt->execute([$checked, $id]);

        if($stmt){
            echo $checked;
        } else {
            echo 'error:' . mysqli_error($conn);
        }

        $conn = null;
        exit();
    }
} else {
    header("Location: ../index.php?mess=error");
}