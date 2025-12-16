<?php
header("Content-Type: application/json");
require_once "../../connect.php";

if (isset($_GET['invoice_number']) && isset($_GET['branch'])) {
    $invoiceNumber = $_GET['invoice_number'];
    $companyID = $_GET['branch'];

    // Fetch company details from company_master table
    $sql = "SELECT company_name, address, contact_number, email_id, gst_number FROM company_master WHERE id = :branch_id";
    $stmt = $con->prepare($sql);
    $stmt->bindParam(':branch_id', $companyID, PDO::PARAM_INT);
    $stmt->execute();
    $company = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];

    // Fetch invoice details from invoice table
    $sql1 = "SELECT invoice_number, date, customer_name, Customer_phone, discount, total_value, gst, final_net_amount,delivery_date, created_on FROM invoice WHERE invoice_number = ? LIMIT 1";
    $stmt = $con->prepare($sql1);
    $stmt->execute([$invoiceNumber]);
    $invoice = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];

    // Fetch invoice items
    $sql2 = "SELECT r.item, SUM(i.qty) AS qty, i.rate, i.total FROM invoice i 
        JOIN rate_master r ON i.item = r.id WHERE i.invoice_number = ? GROUP BY i.item";
    $stmt = $con->prepare($sql2);
    $stmt->execute([$invoiceNumber]);
    $items = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];

    // Fetch courier address from courier_details table
    $sql3 = "SELECT cd.billNo,cd.companyName,cd.deliveredDate,cd.courierImage,cd.courier_address ,
    joa.rec_date,joa.rec_name,joa.rec_phone,joa.rec_emp FROM courier_details cd 
    LEFT join job_order_allocation joa ON joa.invoice_number = cd.invoice_number
    WHERE cd.invoice_number = ? LIMIT 1";
    $stmt = $con->prepare($sql3);
    $stmt->execute([$invoiceNumber]);
    $courierDetails = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];

    // Fetch total discount percentage for the invoice
    $sqlDiscount = "SELECT SUM(discount) AS total_discount FROM invoice WHERE invoice_number = ?";
    $stmt = $con->prepare($sqlDiscount);
    $stmt->execute([$invoiceNumber]);
    $discountData = $stmt->fetch(PDO::FETCH_ASSOC);
    $totalDiscountPercent = $discountData['total_discount'] ?? 0;

    // Calculate subtotal from items
    $subtotal = 0;
    foreach ($items as $item) {
        $subtotal += $item['total']; // Sum up the total of all items
    }

    $gstValue = ($subtotal / 100) * ($invoice['gst'] ?? 0); // Recalculate GST based on subtotal
    $grandTotal = $subtotal + $gstValue;

    echo json_encode([
        // "status" => "success",
        "totalDiscountPercent" => $totalDiscountPercent,
        'subTotal' => $subtotal,
        'gst' => $invoice['gst'] ?? 0,
        "gstValue" => $gstValue,
        "final total" => $invoice['final_net_amount'],
        "grandTotal" => $grandTotal,
        "company" => $company,
        "items" => $items,
        "courierDetails" => $courierDetails
    ]);
} else {
    echo json_encode([
        'status' => 'error',
        'message' => "Invoice/Branch number not provided."
    ]);
}
