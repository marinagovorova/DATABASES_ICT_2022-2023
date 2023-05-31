<?php
require 'db_conn.php';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>To do list</title>
    <link rel="stylesheet" href="css/style.css">

</head>

<body>

    <div class="container">
        <h2>TODO LIST</h2>
        <h3>Add Item</h3>
        <p>
            <input id="new-task" type="text"><button>Add</button>
        </p>

        <?php
        $todos = $conn->query("SELECT * FROM todo ORDER BY date_time DESC");
        ?>
        <h3>Todo</h3>
        <ul id="incomplete-tasks">
            <?php while ($todo = $todos->fetch(PDO::FETCH_ASSOC)) { ?>
                <?php if ($todo['checked'] == 0) { ?>
                    <li id="<?php echo $todo['id'] ?>"><input type="checkbox"><label>
                            <?php echo $todo['title'] ?>
                        </label><input type="text" value="<?php echo $todo['title'] ?>"><button class="delete">Delete</button>
                    </li>
                <?php } ?>
            <?php } ?>
        </ul>

        <?php
        $todos = $conn->query("SELECT * FROM todo ORDER BY date_time DESC");
        ?>
        <h3>Completed</h3>
        <ul id="completed-tasks">
            <?php while ($todo = $todos->fetch(PDO::FETCH_ASSOC)) { ?>
                <?php if ($todo['checked'] == 1) { ?>
                    <li id="<?php echo $todo['id'] ?>"><input type="checkbox" checked><label>
                            <?php echo $todo['title'] ?>
                        </label><input type="text" value="<?php echo $todo['title'] ?>"><button class="delete">Delete</button>
                    </li>
                <?php } ?>
            <?php } ?>
        </ul>
    </div>
    <script src="js/Home.js"></script>
</body>

</html>