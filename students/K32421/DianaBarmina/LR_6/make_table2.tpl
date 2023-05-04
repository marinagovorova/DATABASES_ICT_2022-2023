<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.css"></link>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.12/semantic.min.js"></script>
    </head>
    <body>
        <div class="ui container" style="padding-top: 10px;">
        <table class="ui celled table">
            <thead>
                <th>Numb</th>
                <th>Comp</th>
            </thead>
            <tbody>
                %for row in rows:
                  <tr>
                  %for col in row:
                    <td>{{col}}</td>
                  %end
                  </tr>
                %end
                </table>
            </tbody>
        </table>
        </div>
    </body>
</html>