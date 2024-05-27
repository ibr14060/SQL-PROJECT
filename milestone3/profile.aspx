<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="milestone3.profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        .body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-image: url('images/profile-picture-background-npa9yae86g2tj6xs.jpg');
            background-size: cover;
        }

        .titlee {
            font-size: 175%;
            margin-top: 2%;
            margin-bottom: 5%;
            font-size: 350%;
        }

        .profilebody {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction:column;
        }

        .data {
            border: #808080 1px solid;
            margin-left: 2%;
            margin-top: 20%;
        }

        .data td,
        .data th {
            border: 1px solid #808080;
            padding: 8px;
            text-align: left;
            flex-wrap: nowrap;
            white-space: nowrap;
        }

        .data td {
            color: #000000;
        }

        .data th {
            color: #000000;
        }

        .data .line td {
            border-top: 1px solid #ddd;
        }

        .navv{
            margin-left:9%;
        }

        .navs {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            white-space: nowrap;
        }

        .adminpart {
            display: none; /* Initially hide admin links */
        }

        .userpart {
            display: none; /* Initially hide user links */
        }
    </style>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    $(document).ready(function () {
        // Retrieve the user ID from the query string
        var userId = '<%= Request.QueryString["userId"] %>';

        // Call the WebMethod using AJAX
        $.ajax({
            type: "POST",
            url: "profile.aspx/GetUserProfileData",
            data: JSON.stringify({ userId: userId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // Update the UI with the retrieved data
                $('#lblUserId').text(data.d.UserId);
                // ... (other fields)
                $('#lblFirstName').text(data.d.FirstName || ''); // Handle null values
                $('#lblLastName').text(data.d.LastName || ''); // Handle null values
                $('#lblEmail').text(data.d.Email || ''); // Handle null values
                $('#lblpassword').text(data.d.Password || ''); // Handle null values
                $('#lblpreference').text(data.d.Preference || ''); // Handle null values
                $('#lblRoom').text(data.d.Room);
                $('#lblType').text(data.d.tyype || ''); // Handle null values
                $('#lblBirthday').text(data.d.Birthday || ''); // Handle null values
                $('#lblage').text(data.d.Age);
                console.log(data.d);

                // Check user type and show/hide navigation links
                if (data.d.tyype) {
                    var userTypeLower = data.d.tyype.toLowerCase();
                    console.log("User Type:", userTypeLower);

                    if (userTypeLower === "admin") {
                        $('.adminpart').show();
                        $('.userpart').hide();
                    } else {
                        $('.adminpart').hide();
                        $('.userpart').show();
                    }
                } else {
                    console.log("User Type is null or undefined.");
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
</script>
</head>
<body class="body">
    <header class="titlee"> Profile page</header>
    <div class="profilebody">
        <div class ="navs">
            <div class ="adminpart">
             <a href="AdminRemoveUsers.aspx?userId=<%= Request.QueryString["userId"] %>" id="lnkremoveusers" class ="navv">View And Remove Users</a>
             <a href="AdminGuests.aspx?userId=<%= Request.QueryString["userId"] %>" id="lnkAdminguestsremoveusers" class ="navv">Set Number of Allowed Guests</a>
            </div>
            <div class="userpart">
             <a href="UserTasks.aspx?userId=<%= Request.QueryString["userId"] %>" id="lnkUserTasks" class ="navv">My Tasks</a>
             <a href="addreminder.aspx?userId=<%= Request.QueryString["userId"] %>" id="lnkaddreminderTasks" class ="navv">Add Reminder</a>
             <a href="updatedeadline.aspx?userId=<%= Request.QueryString["userId"] %>" id="lnkdeadlineTasks" class ="navv">Update Deadline</a>
             <a href="FinishTask.aspx?userId=<%= Request.QueryString["userId"] %>" id="lnkfinishTasks" class ="navv">Finish Task</a>
             <a href="viewstatus.aspx?userId=<%= Request.QueryString["userId"] %>" id="lnkstate" class ="navv">View Task Status</a>
            </div>
        </div>
        <table class="data">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Preference</th>
                    <th>Room</th>
                    <th>Type</th>
                    <th>Birthday</th>
                    <th>Age</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><span id="lblUserId"></span></td>
                    <td><span id="lblFirstName"></span></td>
                    <td><span id="lblLastName"></span></td>
                    <td><span id="lblEmail"></span></td>
                    <td><span id="lblpassword"></span></td>
                    <td><span id="lblpreference"></span></td>
                    <td><span id="lblRoom"></span></td>
                    <td><span id="lblType"></span></td>
                    <td><span id="lblBirthday"></span></td>
                    <td><span id="lblage"></span></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
