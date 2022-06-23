<?php
if (!isset($_POST)) {
    /*$response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();*/
    echo "failed";
}

include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);
$sqllogin = "SELECT * FROM tbl_adminstutor WHERE user_email = '$email' AND user_pass = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if ($numrow > 0) {
   /* while ($row = $result->fetch_assoc()) {
        $admin['id'] = $row['user_id'];
        $admin['name'] = $row['user_name'];
        $admin['email'] = $row['user_email'];
        $admin['phonenumber'] = $row['user_num'];
        $admin['address'] = $row['user_address'];
        $admin['regdate'] = $row['admin_datereg'];
    }
    $response = array('status' => 'success', 'data' => $admin);
    sendJsonResponse($response);*/
    echo "success";
} else {
   /*$response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);*/
    echo "failed";
}

?>
