<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FinishTask.aspx.cs" Inherits="milestone3.FinishTask" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            // Retrieve the user ID from the query string
            var userId = '<%= Request.QueryString["userId"] %>';

        // Call the WebMethod using AJAX
        $.ajax({
            type: "POST",
            url: "UserTasks.aspx/GetUserTaskData",
            data: JSON.stringify({ userId: userId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // Update the UI with the retrieved data
                $('#lblTaskId').text(data.d.Taskid);
                $('#lblName').text(data.d.Name || ''); // Handle null values
                $('#lblCreation').text(data.d.creation || ''); // Handle null values
                $('#lblDue').text(data.d.due || ''); // Handle null values
                $('#lblCategory').text(data.d.category || ''); // Handle null values
                $('#lblCreator').text(data.d.creator || ''); // Handle null values
                $('#lblStatus').text(data.d.statuss) || '';
                $('#lblReminder').text(data.d.reminder) || '';

                console.log(data.d);
                console.log(data.d.statuss);
            },

            error: function (error) {
                console.log(error);
            }
        });
        });

        function setstat() {
            $.ajax({
                type: "POST",
                url: "FinishTask.aspx/FinishTaskById",
                data: JSON.stringify({ taskId: $('#lblTaskId').text() }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.d.Success) {
                        alert('Task finished successfully!');
                    } else {
                        alert('Error finishing task: ' + result.d.ErrorMessage);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });

        }
        
    </script>
    <style>
        .body{
             display: flex;
            flex-direction:column;
            align-items: center;
            justify-content: center;
            background-image: url('images/Presentation6.jpg');
            background-size: cover;

        }
        .titlee {
         font-size:175%;
         margin-top:2%; 
        margin-bottom:5%;
        } 
        .finishbody{
        display:flex;
        align-items:center;
        justify-content:center;
        }
          .data{
    border :#808080 1px solid ;
    margin-left: 2%;
}
.data td, .data th {
    border: 1px solid #808080;
    padding: 8px;
    text-align: left;
    flex-wrap:nowrap;
    white-space: nowrap;
    
    
  }
.data td{
    color :#ddd;
}
.data th{
    color:#000000;
}
  
  .data .line td {
    border-top: 1px solid #ddd;
  }
  .finishbut{
      background-color:#ff0000 ;
      color : #ddd ;
      border :none;
  }
    </style>
</head>
<body class ="body">
     <header class="titlee"> Finsh Your Tasks</header>
        <div class ="finishbody">
                         <table class="data">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Creation Date</th>
                        <th>Due Date</th>
                        <th>Category</th>
                        <th>Creator</th>
                        <th>Status</th>
                        <th>Reminder</th>
                        <th>Action</th>
                    </tr>
                </thead>
                 <tbody>
                 <tr>
                    <td><span id="lblTaskId"></span></td>
                    <td><span id="lblName"></span></td>
                    <td><span id="lblCreation"></span></td>
                    <td><span id="lblDue"></span></td>
                    <td><span id="lblCategory"></span></td>
                    <td><span id="lblCreator"></span></td>
                    <td><span id="lblStatus"></span></td>
                    <td><span id="lblReminder"></span></td>
                    <td>
                    <button type="button" class="finishbut" onclick="setstat()" id="finishButton">Finish</button>
                    </td>
                </tr>
                <!-- Data will be dynamically added here using JavaScript -->
            </tbody>
                                
            </table>
        </div>
    
</body>
</html>
