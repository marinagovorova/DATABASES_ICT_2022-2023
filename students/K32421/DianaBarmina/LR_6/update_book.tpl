<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>
<h1>UPDATE book with ID = {{no}}</h1>
<form action="/updatebook/{{no}}" method="get">
  <input type="text" name="name" value="{{old[0]}}" size="100" maxlength="100">
  <input type="text" name="author_name" value="{{old[1]}}" size="100" maxlength="100">
  <br>
  <input type="submit" name="save" value="save">
</form>
<th colspan="7">
    <a href="/books" class="ui small button">Return to the Books</a>
</th>
