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

$sqlloadsubjects = "SELECT * FROM tbl_subjects";
$result = $conn->query($sqlloadsubjects);
$number_of_results = $result->num_rows;
$number_of_page = ceil($number_of_results / $results_per_page);
$sqlloadsubjects = $sqlloadsubjects . "LIMIT $page_first_result, $results_per_page";
$result = $conn->query($sqlloadsubjects);

if ($result->num_rows>0){
    $Subjects["subjects" ]=array ();
    While ($row = $result->fetch_assoc()) {
        $sublist = array ();
        $sublist['subject_id ']=$row['subject_id'];
        $sublist['subject_name']=$row['subject_name'];
        $sublist['subject_description']=$row['subject_description'];
        $sublist['subject_price']=$row['subject_price'];
        $sublist['tutor_id']=$row['tutor_1d'];
        $sublist['subject_sessions']=$row['subject_sessions'];
        $sublist['subJect_rating']=$row['subJect_rating'];
        array_push ($subjects['subjects'], $sublist);
    }
    $response = array('status' => 'success', 'pageno'=> "$pageno", 'numofpage' => "$num_of_page", 'data'=> $subjects);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>