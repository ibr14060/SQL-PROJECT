<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewstatus.aspx.cs" Inherits="milestone3.viewstatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
     <script>
         function viewstate() {
             // Retrieve the task ID from the input field
             var taskId = $('#Text1').val();

             // Validate input
             if (!taskId || isNaN(taskId)) {
                 alert('Please enter a valid Task ID.');
                 return;
             }

             // Call the WebMethod using AJAX
             $.ajax({
                 type: "POST",
                 url: "viewstatus.aspx/GetStatus",
                 data: JSON.stringify({ userId: taskId }), // Changed variable name
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (data) {
                     // Update the UI with the retrieved data
                     $('#lblTaskId').text(data.d.Taskid);
                     $('#lblName').text(data.d.Name || ''); // Handle null values
                     $('#lblstate').text(data.d.statuss || ''); // Handle null values

                     console.log(data.d);
                     console.log(data.d.statuss);
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
            background-image: url('images/Presentation3.jpg');
            background-size: cover;

        }
        .titlee {
         font-size:175%;
         margin-top:2%; 
        margin-bottom:5%;
        } 
        .statusbody{
        display:flex;
        align-items:center;
        justify-content:center;
        flex-direction:column;
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
    </style>
</head>
<body class ="body">
   <header class="titlee"> View status </header>
        <div class ="statusbody">
            <lable>Enter the task ID</lable>
            <input id="Text1" type="text"  placeholder="Enter Task ID"/>
              <table class="data">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Status</th>

                    </tr>
                </thead>
                <tbody>
                 <tr>
                    <td><span id="lblTaskId"></span></td>
                    <td><span id="lblName"></span></td>
                    <td><span id="lblstate"></span></td>


                </tr>
                <!-- Data will be dynamically added here using JavaScript -->
            </tbody>
            </table>
              <button type="button" onclick="viewstate()" class="addreminder">View Status</button>
        </div>
   
</body>
</html>
