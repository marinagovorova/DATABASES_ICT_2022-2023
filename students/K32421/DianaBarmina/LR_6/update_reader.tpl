%#template for editing a task
%#the template expects to receive a value for "no" as well a "old", the text of the selected ToDo item
<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>
<h1>UPDATE reader with ID = {{no}}</h1>
<form action="/updatereader/{{no}}" method="get">
  <input type="text" name="name" value="{{old[0]}}" size="100" maxlength="100">
  <input type="text" name="surname" value="{{old[1]}}" size="100" maxlength="100">
  <input type="text" name="birthday" value="{{old[2]}}" size="100" maxlength="100">
  <br>
  <input type="submit" name="save" value="save">
</form>
<th colspan="7">
    <a href="/readers" class="ui small button">Return to the Readers</a>
</th>
