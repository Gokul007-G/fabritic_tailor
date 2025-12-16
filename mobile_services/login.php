    <?php
    header("Content-Type: application/json");
    require_once "../connect.php";

    try {
        $mobile = trim($_POST["mobile_number"] ?? $_GET["mobile_number"]) ?? '';
        $password = trim($_POST["password"] ?? $_GET["password"]) ?? '';
        if (!$mobile && $mobile != null) {
            echo json_encode([
                "status" => "error",
                "message" => "Mobile number not set"
            ]);
            exit;
        }

        if (!$password) {
            echo json_encode([
                "status" => "error",
                "message" => "Password not set"
            ]);
            exit;
        }

        $query = $con->prepare('SELECT * FROM users WHERE mobile_number = :mobile AND user_role = "Tailor" LIMIT 1');
        $query->bindParam(':mobile', $mobile);
        $query->execute();

        if ($query->rowCount() > 0) {
            $row = $query->fetch(PDO::FETCH_ASSOC);
            if (!isset($row['password'])) {
                echo json_encode(['status' => 'error', 'message' => 'Password not found for user']);
                exit;
            }
            if (password_verify($password, $row['password'])) {
                echo json_encode([
                    "status" => "success",
                    "data" => $row,
                ]);
                exit;
            } else {
                echo json_encode([
                    "status" => "error",
                    "message" => "Mismatch Username & Password"
                ]);
            }
        } else {
            echo json_encode([
                "status" => "error",
                "message" => "Mismatch Username & Password"
            ]);
        }
    } catch (Exception $e) {
        echo json_encode([
            "status" => "error",
            "message" => "Databse error " . $e->getMessage()
        ]);
    }
