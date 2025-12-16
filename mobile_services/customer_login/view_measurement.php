<?php
header("Content-Type: application/json");
require_once "../../connect.php";

$invoiceNo = $_POST["invoiceNo"] ?? $_GET["invoiceNo"] ?? '';

try {
    if (!$invoiceNo) {
        echo json_encode([
            "status" => 'error',
            "message" => "Job Number Not Found"
        ]);
    }
    $query = "SELECT i.jb_no,i.customer_name,i.delivery_date,i.Customer_phone,i.invoice_number FROM invoice i inner join rate_master rm on rm.id = i.item where i.invoice_number='$invoiceNo' AND rm.type != 'Otherworks'";
    $stmt = $con->prepare($query);  // Prepare the query
    $stmt->execute();  // Execute the query
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    $jb_no = $row['jb_no'] ?? null;


    $stmt = $con->prepare("SELECT * FROM customer_measurements WHERE jb_no = '$jb_no' LIMIT 1");
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    $customer_code = $result ? $result['customer_code'] : null;
    $newSno = $result ? $result['sno'] : null;


    $measurement_id = $invoiceNo;
    $query = "SELECT cm.remarks,i.qty, r.rate, r.type, r.item, i.jb_no,cm.design_image,cm.image, d.image AS design_image_path,cm.unit_delivery_date,cm.otherworks_jbno FROM invoice i LEFT JOIN rate_master r ON i.item = r.id LEFT JOIN customer_measurements cm ON i.jb_no = cm.jb_no LEFT JOIN design d ON cm.design_image = d.id WHERE i.invoice_number = :measurement_id AND r.type IN ('Saree','Blouse')";
    $stmt = $con->prepare($query);
    $stmt->bindParam(':measurement_id', $measurement_id, PDO::PARAM_STR);
    $stmt->execute();
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "status" => "success",
        'measurement' => $result,
        'stitching' => $rows,
    ]);
} catch (Exception $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Database Error"
    ]);
}
