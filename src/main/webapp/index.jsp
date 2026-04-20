<!DOCTYPE html>
<html>
<head>
    <title>Student Result Form</title>
    <script>
        function validateForm() {
            let roll = document.forms["form"]["rollno"].value;
            let name = document.forms["form"]["name"].value;
            let marks = document.forms["form"]["sub"];

            if (roll === "" || name === "") {
                alert("Roll No and Name are required");
                return false;
            }

            for (let i = 0; i < marks.length; i++) {
                if (marks[i].value === "" || marks[i].value < 0 || marks[i].value > 100) {
                    alert("Enter valid marks (0-100) for all subjects");
                    return false;
                }
            }
            return true;
        }
    </script>
</head>

<body>
    <h2>Student Result Form</h2>

    <form name="form" action="ResultServlet" method="post" onsubmit="return validateForm()">
        Roll No: <input type="text" name="rollno"><br><br>
        Name: <input type="text" name="name"><br><br>

        Sub1: <input type="number" name="sub"><br><br>
        Sub2: <input type="number" name="sub"><br><br>
        Sub3: <input type="number" name="sub"><br><br>
        Sub4: <input type="number" name="sub"><br><br>
        Sub5: <input type="number" name="sub"><br><br>

        <input type="submit" value="Submit">
    </form>
</body>
</html>
>