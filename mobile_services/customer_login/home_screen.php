<?php
header("Content-Type: application/json");
require_once "../../connect.php";

$customer_code = $_POST["customer_code"] ?? $_GET["customer_code"];

try {
    if (!$customer_code) {
        echo json_encode([
            "status" => "error",
            "message" => "Customer code not Set"
        ]);
        exit;
    }

    // Fetch invoice list
    $query = $con->prepare(
        "SELECT 
            i.*, 
            rm.* 
        FROM invoice i
        LEFT JOIN rate_master rm ON rm.id = i.item
        WHERE i.customer_code = :customer_code
        GROUP BY i.invoice_number
        ORDER by i.invoice_number DESC;"
    );
    $query->bindParam(':customer_code', $customer_code);
    $query->execute();

    if ($query->rowCount() > 0) {

        $rows = $query->fetchAll(PDO::FETCH_ASSOC);

        $finalData = [];

        // 👉 Loop through each invoice
        foreach ($rows as $row) {

            $invoiceNo = $row['invoice_number'];

            // Fetch courier count for this invoice
            $courier = $con->prepare("
              SELECT COUNT(*) AS courier_count ,joa.status FROM invoice i LEFT join job_order_allocation joa ON joa.invoice_number = i.invoice_number LEFT JOIN rate_master rm ON rm.id = i.item WHERE i.invoice_number = :invoiceNo AND LOWER(TRIM(rm.type)) = 'courier';
            ");

            $courier->bindParam(':invoiceNo', $invoiceNo);
            $courier->execute();
            $countRow = $courier->fetch(PDO::FETCH_ASSOC);

            // Add courier_count to the row
            $row['courier_count'] = $countRow['courier_count'];
            $row['jobstatus'] = $countRow['status'] ?? 0;

            // Push to final array
            $finalData[] = $row;
        }

        echo json_encode([
            "status" => "success",
            "data" => $finalData
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
        "message" => "Database Error " . $e->getMessage()
    ]);
}
