<?php
define('PHPMYADMIN', true);
define('ROOT_PATH', __DIR__ . "/../phpmyadmin/");

include __DIR__ . "/../phpmyadmin/libraries/constants.php";
include __DIR__ . "/../phpmyadmin/libraries/classes/Version.php";

// Konfigurasi koneksi
$host = "localhost";
$user = "root";
$password = ""; // Kosongkan jika tanpa password
$socket = "/data/data/com.termux/files/usr/var/run/mysqld.sock";

// Koneksi ke MariaDB
$mysqli = new mysqli($host, $user, $password, "", 0, $socket);

// Cek koneksi
if ($mysqli->connect_error) {
    die("Koneksi gagal: " . $mysqli->connect_error);
}

// Ambil daftar database
$result = $mysqli->query("SHOW DATABASES");
$databases = [];
while ($row = $result->fetch_assoc()) {
    $databases[] = $row['Database'];
}

// Ambil versi MySQL (MariaDB)
$mysql_version = $mysqli->server_info ?? 'Tidak tersedia';

// Ambil versi PHP
$php_version = phpversion();

// Ambil versi phpMyAdmin (jika ada)
$phpmyadmin_version = \PhpMyAdmin\Version::VERSION ?? "not set";

// Tutup koneksi
$mysqli->close();
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MAMPP Termux Dashboard</title>
    <meta name="author" content="Angeom21">
    <style>
        /* Global Styles */
        :root {
            --primary: #2a9d8f;
            --secondary: #264653;
            --background: #1e1e1e;
            --text: #ffffff;
            --hover: #e9c46a;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background: var(--background);
            color: var(--text);
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            text-align: center;
        }
        header {
            width: 100%;
            background: var(--secondary);
            padding: 1rem 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        header h1 {
            font-size: 24px;
        }

        /* NAVBAR */
        .nav-container {
            width: 100%;
            overflow-x: auto;
            white-space: nowrap;
            padding: 10px 0;
            background: var(--secondary);
            display: flex;
            justify-content: center;
        }
        nav ul {
            list-style: none;
            display: inline-flex;
            gap: 10px;
        }
        nav a {
            text-decoration: none;
            color: var(--text);
            padding: 8px 16px;
            background: var(--primary);
            border-radius: 5px;
            transition: 0.3s;
            display: inline-block;
        }
        nav a:hover {
            background: var(--hover);
            color: var(--secondary);
        }

        main {
            width: 90%;
            max-width: 800px;
            background: #222;
            padding: 20px;
            margin: 20px 0;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        h2 {
            margin-bottom: 10px;
            font-size: 20px;
            color: var(--hover);
        }
        p {
            font-size: 16px;
        }
        ul {
            list-style: none;
            padding: 0;
            margin-top: 10px;
            width: 100%;
            overflow: auto;
        }
        li {
            background: var(--primary);
            margin: 5px 0;
            padding: 8px;
            border-radius: 5px;
            transition: 0.3s;
        }
        li:hover {
            background: var(--hover);
            color: var(--secondary);
        }

        /* FOOTER */
        footer {
            margin-top: auto;
            padding: 15px;
            width: 100%;
            text-align: center;
            background: var(--secondary);
        }
        footer a {
            color: var(--hover);
            text-decoration: none;
        }
        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to MAMPP Termux</h1>
    </header>

    <div class="nav-container">
        <nav>
            <ul>
                <li><a href="phpinfo.php">PHP Info</a></li>
                <li><a href="/phpmyadmin">phpMyAdmin</a></li>
            </ul>
        </nav>
    </div>

    <main>
        <h2>MySQL Server Info</h2>
        <p>Versi PHP: <?= $php_version; ?></p>
        <p>Versi MariaDB: <?= $mysql_version; ?></p>
        <p>Versi phpMyAdmin: <?= $phpmyadmin_version; ?></p>

        <h2>Daftar Database</h2>
        <ul>
            <?php foreach ($databases as $db) : ?>
                <li><?= htmlspecialchars($db); ?></li>
            <?php endforeach; ?>
        </ul>
    </main>

    <footer>
        <p>© 2025 MAMPP Termux | Created by <a href="https://github.com/angeom21">Angeom21</a></p>
    </footer>
</body>
</html>
