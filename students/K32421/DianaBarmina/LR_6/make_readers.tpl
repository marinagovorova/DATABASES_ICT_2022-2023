%#template to generate a HTML table from a list of tuples (or list of lists, or tuple of tuples or ...)
<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>

<body>
<h2><center>Readers:</center></h2>
<div class="ui container" style="padding-top: 10px;">
<table class="ui celled table">
<thead>
    <th>ID</th>
    <th>Name</th>
    <th>Surname</th>
    <th>Birthday</th>
    <th>Change</th>
    <th>Delete</th>

</thead>

<tbody>
%for i in range (len(rows)):
  <tr>
  %#<td>{{i+1}}</td>
  %for col in rows[i]:
    <td>{{col}}</td>
  %end
  <td><a href="/updatereader/{{rows[i][0]}}" class="ui button">Update</a></td>
  <td><a href="/deletereader/{{rows[i][0]}}" class="ui button">Delete</a></td>
  </tr>
%end
</tbody>
<tfoot class="full-width">
    <tr>
        <th colspan="7">
            <a href="/newreader" class="ui right floated small button">Add a new reader to the ToDo list</a>
        </th>
    </tr>
</tfoot>

</table>
<a href="/books" class="ui button">Go to Books</a>
<a href="/take" class="ui button">Go to Taking</a>
</body>
