<?php
header("Content-Type: application/json");
require_once "../../connect.php";

$emp_name = $_POST["emp_name"] ?? $_GET["emp_name"];
$branch_id = $_POST["branch_id"] ?? $_GET["branch_id"];

try {
    if (!$emp_name) {
        echo json_encode([
            "status" => "error",
            "message" => "Employee Name not Set"
        ]);
    }
    if (!$branch_id) {
        echo json_encode([
            "status" => "error",
            "message" => "Branch Id not Set"
        ]);
    }
    $query = $con->prepare('SELECT * FROM job_order_allocation WHERE Emp_name = :emp_name AND branch_id = :branch_id AND (status = 0 or status = 2) ORDER by status ASC');
    $query->bindParam(':emp_name', $emp_name);
    $query->bindParam(':branch_id', $branch_id);
    $query->execute();

    if ($query->rowCount() > 0) {
        $row = $query->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode([
            "status" => "success",
            "data" => $row
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "no data allocation"
        ]);
    }
} catch (Exception $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Database Error" #. $e->getMessage()
    ]);
}
