<?php
header("Content-Type: application/json");
require_once "../../connect.php";

$mobile_number = $_POST['mobile_number'] ?? $_GET['mobile_number'] ?? null;
$password = $_POST['password'] ?? $_GET['password'] ?? null;

try {
    if (!$mobile_number) {
        echo json_encode(["status" => "error", "message" => "Mobile number is required"]);
        exit;
    }

    // Prepare and execute query
    $stmt = $con->prepare('SELECT * FROM customer_details WHERE contact_number = :mobile_number');
    $stmt->bindParam(':mobile_number', $mobile_number);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if (password_verify($password, $row['password'])) {
            echo json_encode(["status" => "success", "data" =>  $row]);
            exit;
        } else {
            echo json_encode(["status" => "error", "message" => "Password Missmatch"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "User not found"]);
    }
} catch (Exception $e) {
    echo json_encode([
        "status"  => "error",
        "message" => "Database error " #. $e->getMessage()
    ]);
}
