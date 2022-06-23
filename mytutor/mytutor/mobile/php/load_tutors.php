<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$results_per_page = 5;
$pageno = (int)$_POST['pageno'];
$page_first_result = ($pageno - 1) * $results_per_page;

$sqlloadtutors = "SELECT * FROM tbl_tutors";
$result = $conn->query($sqlloadtutors);
$number_of_results = $result->num_rows;
$number_of_page = ceil($number_of_results / $results_per_page);
$sqlloadsubjects = $sqlloadtutors . " LIMIT $page_first_result, $results_per_page";
$result = $conn->query($sqlloadtutors);

if ($result->num_rows>0){
    $Subject["tutors" ]=array ();
    While ($row = $result->fetch_assoc()) {
        $tutorlist = array ();
        $tutorlist['tutor_id ']=$row['tutor_id'];
        $tutorlist['tutor_email']=$row['tutor_email'];
        $tutorlist['tutor _phone']=$row['tutor_phone'];
        $tutorlist['tutor_name']=$row['tutor_name'];
        $tutorlist['tutor _description']=$row['tutor_description'];
        $tutorlist['tutor_datereg']=$row['tutor_datereg'];
        array_push ($tutors['tutors'], $tutorlist);
    }
    $response = array('status' => 'success', 'pageno'=> "$pageno", 'numofpage' => "$num_of_page", 'data'=> $tutors);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>