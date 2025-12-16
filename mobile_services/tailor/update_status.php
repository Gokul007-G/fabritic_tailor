<?php
header("Content-Type: application/json");
require_once "../../connect.php";

$jbNo = $_POST["jbNo"] ?? $_GET["jbNo"] ?? '';
$status = $_POST["status"] ?? $_GET["status"] ?? '';

try {
    if (!$jbNo) {
        echo json_encode([
            "status" => $jbNo,
            "message" => "Job Number Not Found"
        ]);
    }
    if (!$status) {
        echo json_encode([
            "status" => $status,
            "message" => "Status Not Found"
        ]);
    }
    $query = $con->prepare("UPDATE job_order_allocation SET status = :status WHERE jb_no = :jb_no");
    $query->bindParam(':jb_no', $jbNo);
    $query->bindParam(':status', $status);

    if ($query->execute()) {
        echo json_encode([
            "status" => "success",
            "data" => 'Update Successfully'
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "No Data found"
        ]);
    }
} catch (Exception $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Database Error"
    ]);
}
