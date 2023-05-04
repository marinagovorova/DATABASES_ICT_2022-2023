%#template to generate a HTML table from a list of tuples (or list of lists, or tuple of tuples or ...)
<head>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
</head>

<body>
<h2><center>Taking:</center></h2>
<div class="ui container" style="padding-top: 10px;">
<table class="ui celled table">
<thead>
    <th>ID</th>
    <th>Reader</th>
    <th>Book</th>
    <th>Date</th>
    <th>Change</th>
    <th>Delete</th>

</thead>

<tbody>
%for i in range (len(rows)):
  <tr>
  %for col in rows[i]:
    <td>{{col}}</td>
  %end
  <td><a href="/updatetake/{{rows[i][0]}}" class="ui button">Update</a></td>
  <td><a href="/deletetake/{{rows[i][0]}}" class="ui button">Delete</a></td>
  </tr>
%end
</tbody>
<tfoot class="full-width">
    <tr>
        <th colspan="7">
            <a href="/newtake" class="ui right floated small button">Add a new take to the ToDo list</a>
        </th>
    </tr>
</tfoot>

</table>
<a href="/readers" class="ui button">Go to Readers</a>
<a href="/books" class="ui button">Go to Books</a>
</body>
