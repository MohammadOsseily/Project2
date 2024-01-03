<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT");
header("Access-Control-Allow-Headers: *");

$servername = "localhost";
$username = "id21742716_mhmd";
$password = "Osseily_1010";
$dbname = "id21742716_notes";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Retrieve notes
    $sql = "SELECT * FROM notes";
    $result = $conn->query($sql);

    $notes = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $notes[] = array(
                'id' => $row['id'],
                'content' => $row['content'],
                'timestamp' => $row['timestamp']
            );
        }
    }

    echo json_encode($notes);
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Add a new note
    $data = json_decode(file_get_contents("php://input"), true);

    if (isset($data['content'])) {
        $content = $data['content'];

        $sql = "INSERT INTO notes (content) VALUES ('$content')";

        if ($conn->query($sql) === TRUE) {
            echo json_encode(array('status' => 'success'));
        } else {
            echo json_encode(array('status' => 'error', 'message' => $conn->error));
        }
    } else {
        echo json_encode(array('status' => 'error', 'message' => 'Content not provided'));
    }
}

$conn->close();
