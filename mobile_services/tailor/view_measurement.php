<?php
header("Content-Type: application/json");
require_once "../../connect.php";

$jbNo = $_POST["jbNo"] ?? $_GET["jbNo"] ?? '';

try {
    if (!$jbNo) {
        echo json_encode([
            "status" => $jbNo,
            "message" => "Job Number Not Found"
        ]);
    }
    $query = $con->prepare("SELECT
        cm.*,
        rm.item,
        joa.status
    FROM customer_measurements cm
    JOIN job_order_allocation joa ON cm.jb_no = joa.jb_no
    JOIN invoice inv ON joa.invoice_number = inv.invoice_number
    JOIN rate_master rm ON inv.item = rm.id
    WHERE cm.jb_no = :jb_no");
    $query->bindParam(':jb_no', $jbNo);
    $query->execute();

    if ($query->rowCount() > 0) {
        $row = $query->fetchAll(PDO::FETCH_ASSOC);
        if ($row) {
            echo json_encode([
                "status" => "success",
                "data" => $row
            ]);
        } else {
            echo json_encode([
                "status" => "error",
                "message" => "No Data found"
            ]);
        }
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Job Not found"
        ]);
    }
} catch (Exception $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Database Error"
    ]);
}
