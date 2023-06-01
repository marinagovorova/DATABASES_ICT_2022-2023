<?php
require("db.php");
$products = $db->query("SELECT*FROM products")->fetchAll(PDO::FETCH_ASSOC);
?>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com"> 
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500&family=Nunito:wght@700&family=Poppins&family=Raleway&family=Work+Sans&display=swap" rel="stylesheet">
    <title>Document</title>
</head>
<body>
    <header class ="Header">
        <div class = "bax"> </div>
        <div id="ooo" class="img" style="background-image: url('https://phonoteka.org/uploads/posts/2021-03/1616369696_1-p-fon-s-tsvetami-1.jpg') ;"> </div>
        <div class ="Header-item">
            <div class ="Header-items">
                 <div><img src = "https://img.freepik.com/premium-vector/3d-realistic-magnifying-glass-loupe-isolated-vector-illustration-on-white-background_108855-3263.jpg" style="width:20px;height:20px;"></div>
                <div ><img src = "https://cdn-icons-png.flaticon.com/512/3770/3770807.png" style="width:20px;height:20px;margin-left:20px;"></div>
                <button class="button" > Войти </button>
                <button class="button"> Зарегистрироваться </button>
            </div>
            <h1>Flower</h1>
            <p class="text1">Цветочный магазин, расположенный в самом центре города. Только у нас самые свежие цветы и большой выбор.<p>
        </div>
    </header>

    <main1 class ="Main Container">
        <div class ="Main-item">

            <div class ="Main-items">
                <div class="img1" style="background-image: url('https://cdn.cardone.org/pages/delivery/tracking.png');"> </div>
                <h2>Быстрая доставка</h2>
            </div>
            <p class="text2">1 рабочий день </p>
         </div>

        <div class ="Main-item">
            <div class ="Main-items">
                <div class="img1" style="background-image: url('https://filearchive.cnews.ru/img/book/2022/06/17/call-center-woman.png'); max-width: 48px;"></div>
                <h2>Отличное обслуживание клиентов</h2>
            </div>
            <p class="text2"> В нашей службе поддержки только профессионалы </p>
        </div>

        <div class ="Main-item">
            <div class ="Main-items">
                <div class="img1" style="background-image: url('https://media.istockphoto.com/id/136754725/ru/%D1%84%D0%BE%D1%82%D0%BE/%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D1%8B%D0%B9-%D0%B3%D0%B5%D1%80%D0%B1%D0%B5%D1%80%D0%B0-%D0%BD%D0%B0-%D1%81%D0%BE%D0%B3%D0%BD%D1%83%D1%82%D1%8B%D0%B9-%D1%81%D1%82%D0%B5%D0%B1%D0%B5%D0%BB%D1%8C.jpg?s=612x612&w=0&k=20&c=jjhOA00-qX4_X8VK5PXBR5f373LuO0OX6qJZ-gWhz80='); max-width: 48px;"></div>
                <h2>Необычные растения</h2>
            </div>
            <p class="text2">Единственные в своем роде </p>
        </div>

        <div class ="Main-item">
            <div class ="Main-items">
                <div class="img1" style="background-image: url('https://png.pngtree.com/png-vector/20191021/ourlarge/pngtree-dollars-and-coins-icon-cartoon-style-png-image_1837404.jpg'); max-width: 48px;"></div>
                <h2>Доступная цена</h2>
            </div>
            <p class="text2">100 рублей - 10000 рублей </p>
        </div>
    </main1>

    <div class= "line">
        <p id="FP">Избранные растения</p>
    </div>


<a style = "display: block; text-align: center;  padding: 5px; border-radius: 10px; margin: 10px 0;  cursor: pointer; text-decoration: none; " href="create.php" >Создать новый товар</a>

<section class= "featured plants" style=" box-sizing: border-box;  display: flex; flex-wrap: wrap; align-items: center; justify-content: space-around;  margin: 0px 26px 80px 56px;    text-align: center;  padding: 0px;">

    <div class="products" style ="display: flex; flex-wrap: wrap; align-items: center; ">


        <?php foreach($products as $product) { ?>

        <div class ="product" style="width: 217px; margin-right: 20px;">
            <img class="product_img"  style="height: 217px;" src=" <?php echo $product["photo"] ?> " alt="">
            <p class="product_name"style="color: #2C1500; font-weight: 400; font-size: 20px; line-height: 20px; margin: 8px; text-align: center;"> <?php echo $product["name"] ?> </p>
            <p class="product_cost" style="color: #2C1500;font-weight: 600;font-size: 20px;line-height: 32px;margin: 8px;">  <?php echo $product["cost"] ?> </p>

            <a style=" display: block; background-color: #156963 ; color: white; padding: 5px; border-radius: 10px; margin: 10px 0px;  cursor: pointer; text-decoration: none; text-align: center;width: 210px;" href="update.php?id=<?php echo $product['id'] ?>">Изменить</a>
            <a style=" display: block; background-color: #156963 ; color: white; padding: 5px; border-radius: 10px; margin: 10px 0px;  cursor: pointer; text-decoration: none; text-align: center;width: 210px;" href="delete.php?id=<?php echo $product['id'] ?>">Удалить</a>
        </div>

<?php } ?>
 </section>

    <main3 class="Main3 Container">
        <div class ="Main3-item">
            <div class ="Main3-items">
                <h3> Купите больше растений, это поможет вам расслабиться </h3>
                <p class ="text5"> Американское научное общество садоводов провело ряд исследований, которые показали, что цветы помогают человеку выздороветь в самых разных ситуациях.</p>
                <div class="img" style="background-image: url('img1/зеркало.png'); height: 250px;max-width: 568px;"> </div>
            </div>
            <div id="polka" class="img" style="background-image: url('https://amiel.club/uploads/posts/2022-10/1664993786_4-amiel-club-p-navesnie-polki-dlya-tsvetov-dizain-instagr-4.jpg');height: 609.9px;"> </div>
        </div>
    </main3>


    <main4 class="Main4 Container ">
        <div class ="Main4-items">
            <h3 class ="text6" > Купите свое любимое растение в нашем магазине прямо сейчас </h3>
            <button class="button" id = "bth1"> Перейти в магазин </button>
        </div>
        <div class="img" style="background-image: url('https://99px.ru/sstorage/53/2019/10/tmb_274957_516692.jpg'); height:300px; width: 300px;"></div>
    </main4>

    <footer class="Footer">
    <div class="footer">
        <div class="footer1">
            <h4>Адрес</h4>
            <h5 id="t6">Адрес дома</h5>
            <p class="text8" id="t7"></p>
        </div>
        <div class="footer2">
            <h5></h5>
            <p class="text8"></p>
            <p class="text8"></p>
        </div>
        <div class="footer2">
            <h5></h5>
            <p class="text8"></p>
            <p class="text8"></p>
        </div>
        <div class="footer3">
            <h5 id="t9">Почтовая рассылка</h5>
            <div id="MAE">
                <p id="t8" class="text8"></p>
            </div>
            <button class="button"  id="bthf">Подписаться</button>
        </div>
    </div>
    </footer>