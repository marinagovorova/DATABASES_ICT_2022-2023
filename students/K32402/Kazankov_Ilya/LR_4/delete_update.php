<?php
$username = 'root';
$password = '';
$dbname = 'train';
$conn = mysqli_connect('localhost', $username, $password, $dbname);
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $number = $_POST['number'];
    $name = $_POST['name'];
    $type_flight = $_POST['type_flight'];
    $type_train = $_POST['type_train'];
    if (isset($_POST['edit'])) {
        $sql = "UPDATE train
                SET name='$name', type_flight='$type_flight', type_train=$type_train
                WHERE number=$number";
    } elseif (isset($_POST['delete'])) {
        $sql = "DELETE FROM train WHERE number=$number";
    }
}
mysqli_close($conn);
?>