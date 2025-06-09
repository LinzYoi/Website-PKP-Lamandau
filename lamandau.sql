-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2025 at 06:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lamandau`
--

-- --------------------------------------------------------

--
-- Table structure for table `aspirasi`
--

CREATE TABLE `aspirasi` (
  `id_aspirasi` int(11) NOT NULL,
  `judul_aspirasi` varchar(255) NOT NULL,
  `tanggal_aspirasi` date NOT NULL,
  `isi_aspirasi` longtext NOT NULL,
  `nama_pembuat` varchar(255) NOT NULL,
  `no_telp_pembuat` varchar(255) NOT NULL,
  `email_pembuat` varchar(255) NOT NULL,
  `file_gambar_aspirasi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aspirasi`
--

INSERT INTO `aspirasi` (`id_aspirasi`, `judul_aspirasi`, `tanggal_aspirasi`, `isi_aspirasi`, `nama_pembuat`, `no_telp_pembuat`, `email_pembuat`, `file_gambar_aspirasi`) VALUES
(2, 'Aspirasi 1', '2025-05-20', 'Akku dakwj dkajw dkam kaw skmaw skma? dkawkawms kajwsmkajwsk ajwskaw saw smanw smanwsawsawsalwksa ws akwmsakmws akmws amkw smawdalkwdmalkd. adwnd awjd akwwjd akwjwkd akwjd w.', 'Paijo', '082993827212', 'paijo@gmail.com', ''),
(3, 'wewe', '2025-06-06', 'awdaw', 'wdaw', '1@gmail.com', 'akjd@gmail.com', 'aspirasi_files/3ZWdau1i0wH9oIerXXrQfsTi3NBvHOEzm6H6T8Dy.jpg'),
(4, 'ead', '2025-06-06', 'awdaw', 'dwad', 'awd', '3@gmail.com', NULL),
(5, 'dasda', '2025-06-06', 'dawdaw', 'dawd', '12039810293', 'asda@gmail.com', 'aspirasi_files/6CYF4a6ouOTr9tqbG33G8NarA9Axt2kYNZEKPA0C.jpg'),
(6, 'wdw', '2025-06-08', 'qwdqwwwwwwwwwwwwwwwwwwwww', 'wdqw', 'qwd', 'qwdw@gmail.com', NULL),
(7, 'Judu;', '2025-06-09', 'Isi', 'Agus', '0712391823', 'wdawd@gmail.com', 'aspirasi_files/LO98hZtT48uCHXM42uvZcuhzdkAA4DWto0ou7Kma.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `beranda`
--

CREATE TABLE `beranda` (
  `id_beranda` int(11) NOT NULL,
  `judul_beranda` varchar(255) DEFAULT NULL,
  `deskripsi_beranda` longtext DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `file_beranda` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `beranda`
--

INSERT INTO `beranda` (`id_beranda`, `judul_beranda`, `deskripsi_beranda`, `nama`, `file_beranda`) VALUES
(1, NULL, NULL, NULL, 'berita_files/1JhobTusJDFpEjd30DKbuvBDdQDSLwnKNZPRQuPM.mp4'),
(2, 'Bupati dan Wakil Bupati Kabupaten Lamandau', NULL, NULL, 'berita_files/wisiVVmuMcU42tsm9wrGk9I6kFRPzObAf3dRWNW4.png'),
(3, 'Dinas PUPR PERKIMTAN Kabupaten Lamandau', 'DPUPR PERKIMTAN Lamandau memiliki tugas pokok untuk membantu Bupati dalam melaksanakan kewenangan desentralisasi dan dekonsentrasi di bidang perumahan, kawasan permukiman, dan pertanahan sesuai dengan kebijakan yang telah ditetapkan berdasarkan peraturan perundang-undangan.', NULL, 'berita_files/c8KyuHwcGGyLU5BVBDVqfGX5gRrVTVFODCfnZKYk.jpg'),
(4, 'Kepala DPUPR PERKIMTAN Kabupaten Lamandau', 'Selamat datang di website resmi Bidang Perumahan dan Kawasan Permukiman Dinas PUPR Perkimtan Kabupaten Lamandau. Kami berkomitmen memberikan layanan terbaik dalam mewujudkan hunian yang layak dan kawasan permukiman yang tertata demi kenyamanan dan kesejahteraan masyarakat.', 'Joni Elen, S.T., M.T.', 'berita_files/VoyCrbgY9BmwtyBLdKwjBwvG3oWxT8a9J8FRRijh.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `berita`
--

CREATE TABLE `berita` (
  `id_berita` int(11) NOT NULL,
  `judul_berita` varchar(255) NOT NULL,
  `deskripsi_berita` longtext NOT NULL,
  `tanggal_berita` date DEFAULT NULL,
  `file_gambar_berita` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `berita`
--

INSERT INTO `berita` (`id_berita`, `judul_berita`, `deskripsi_berita`, `tanggal_berita`, `file_gambar_berita`) VALUES
(1, 'Berita 1', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna.\r\nNunc viverra imperdiet enim. Fusce est. Vivamus a tellus.', '2025-05-05', 'berita_files/J1mtqRQgUw5pHJiD6U7TDvSErmhrCK6dcfRfQ0eU.png'),
(3, 'Berita 2', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna.\r\nNunc viverra imperdiet enim. Fusce est. Vivamus a tellus.', '2025-05-21', 'berita_files/MWvU3cPeEUCi5PMqsMM8ndWqO3QaB9HP5LO14Z3D.png');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `galeri`
--

CREATE TABLE `galeri` (
  `id_galeri` int(11) NOT NULL,
  `tanggal_media` date DEFAULT NULL,
  `file_gambar_media` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `galeri`
--

INSERT INTO `galeri` (`id_galeri`, `tanggal_media`, `file_gambar_media`) VALUES
(2, '2025-05-17', 'galeri_files/DgorV25cscda2yDFfvDWZ5r5e3oLHFFNrYV5jjpV.png'),
(3, '2025-06-06', 'galeri_files/NXRRqFlOlqQzsH3CbxPPAEVwCjTsIVLOgGqmED1I.png'),
(4, '2025-06-06', 'galeri_files/R1bLUuqidu39nwwjDNRMHeBBgFql5yUSRB1nKQIQ.png'),
(5, '2025-06-06', 'galeri_files/27st94fkI42CdrDXFAXINLxxBg3x07KHKVBNV72x.png'),
(6, '2025-06-03', 'galeri_files/pm2Z2vyMiOujeZihjHiA8fsIxvaL3bx1AnBSPkYs.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `grafik`
--

CREATE TABLE `grafik` (
  `id_grafik` int(11) NOT NULL,
  `file_grafik` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `layanan`
--

CREATE TABLE `layanan` (
  `id_layanan` int(11) NOT NULL,
  `judul_layanan` varchar(255) NOT NULL,
  `deskripsi_layanan` longtext NOT NULL,
  `file_gambar_layanan` varchar(255) NOT NULL,
  `file_dokumen_layanan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `layanan`
--

INSERT INTO `layanan` (`id_layanan`, `judul_layanan`, `deskripsi_layanan`, `file_gambar_layanan`, `file_dokumen_layanan`) VALUES
(1, 'Layanan Satu', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna.\r\nNunc viverra imperdiet enim. Fusce est. Vivamus a tellus.', 'layanan_files/BeUgGRgKBns2UHxQaaFlQo3mzOaLxKc6VvCJMzKX.png', 'layanan_files/ggfFffTQwOzcUOEB1Z75z7s71W7Xb6XqtICsEBrc.zip'),
(2, 'Layanan Dua', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna.\r\nNunc viverra imperdiet enim. Fusce est. Vivamus a tellus.', 'layanan_files/nGF5O0fMUsgmGkIXmGW23s0ILKTLADIpI6tsjyEo.png', 'layanan_files/Sh7c8LMsnXBjCTC8E2qt41fupfndjfONpucr1cZS.zip');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2025_05_01_033545_create_oauth_auth_codes_table', 1),
(4, '2025_05_01_033546_create_oauth_access_tokens_table', 1),
(5, '2025_05_01_033547_create_oauth_refresh_tokens_table', 1),
(6, '2025_05_01_033548_create_oauth_clients_table', 1),
(7, '2025_05_01_033549_create_oauth_personal_access_clients_table', 1),
(8, '2025_05_18_222307_create_oauth_auth_codes_table', 2),
(9, '2025_05_18_222308_create_oauth_access_tokens_table', 3),
(10, '2025_05_18_222309_create_oauth_refresh_tokens_table', 3),
(11, '2025_05_18_222310_create_oauth_clients_table', 3),
(12, '2025_05_18_222311_create_oauth_device_codes_table', 3),
(13, '2025_05_18_222331_create_oauth_auth_codes_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` char(80) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0de45835927590974ee30ee2a847ee1da6d5707a6ccf7ab13c2a83aeac0846bd12d4a5af82831d84', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-06-06 04:33:04', '2025-06-06 04:33:04', '2025-06-07 11:33:04'),
('165a93829479d8af412456a21cc8064324e9888bce1aad83be05f00257f676be12ba79cbae0c0a4d', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-06-09 15:36:11', '2025-06-09 15:36:11', '2025-06-10 22:36:11'),
('1ec290a885e0d987a0b2e3ac4e4839188ac6f5e5bf88fc017c7575f6af48cc01efd5aacc73e8c0ee', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-06-06 02:22:24', '2025-06-06 02:22:24', '2025-06-07 09:22:24'),
('3735c965f846519602c3ce87f054ba3b1ad83b9c14da924309aedd52534ec1c716ce0a4e4288aa55', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-20 13:59:28', '2025-05-20 13:59:29', '2025-05-21 20:59:29'),
('3fb16d2d21721ebf4807bc287504b16b5312dbd0af574fa5726cc12600ea1c614351d2c8a1ec4918', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-06-06 07:47:56', '2025-06-06 07:47:56', '2025-06-07 14:47:56'),
('4812905a71a4230af4afba8d26aae85bc59ad0a81cec32cc448f06eac244b530ce3670c7b18ef53d', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-26 12:02:20', '2025-05-26 12:02:21', '2025-05-27 19:02:21'),
('4b142f2255cace68af181feaa8c49a8e69b58d412a65dbd3cfcbd7dd1b704ce86f23a1a50bdb7acb', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-19 11:23:08', '2025-05-19 11:23:08', '2025-05-20 18:23:08'),
('6f075f7d0f4b0673994fec6b4a3dfbfc58ca1fb1536f310020e82936294628db7032070cc22a232c', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-25 15:59:09', '2025-05-25 15:59:10', '2025-05-26 22:59:10'),
('7979d7a8c3b9c4726af943238f1e134ad124d02ee1a769e026b663d1d7b29a33ee800de6ffc9444e', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-25 18:11:16', '2025-05-25 18:11:16', '2025-05-27 01:11:16'),
('8cafe7992594b62c00297323f69687b85a71dc0cb624f23d0a8f8428f6bee192ebb53a26b3f8858e', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-21 13:12:25', '2025-05-21 13:12:26', '2025-05-22 20:12:26'),
('b477d79d8fabc5f0f6ee89cbaf8fa97737a45feb31594dd10a61de16713167fbe522a2894c46fd84', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-06-06 14:39:13', '2025-06-06 14:39:13', '2025-06-07 21:39:13'),
('bfabc5b9e9a805ce02e568dad3dfd1944f3dd8ac01d3c700d06ae6b5a06e8895d8d2ba487917dc30', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-06-06 04:44:16', '2025-06-06 04:44:16', '2025-06-07 11:44:16'),
('c2963a308470f88608e1ef59b9a01f707d9abf652adf3bfb9be7edb462a2cd431c0b5e86b8b4df4a', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-06-09 15:37:27', '2025-06-09 15:37:27', '2025-06-10 22:37:27'),
('de704b09da782adbc9d4976bd669d87ce4b1e76b4286480c77008e5f54f0b5aedd24c829ef9fb0ea', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-18 15:37:21', '2025-05-18 15:37:21', '2025-05-19 22:37:21');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` char(80) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` char(36) NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` char(36) NOT NULL,
  `owner_type` varchar(255) DEFAULT NULL,
  `owner_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect_uris` text NOT NULL,
  `grant_types` text NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `owner_type`, `owner_id`, `name`, `secret`, `provider`, `redirect_uris`, `grant_types`, `revoked`, `created_at`, `updated_at`) VALUES
('0196e40a-5cd2-722e-a745-1b6a291f9fc8', NULL, NULL, 'yes', '$2y$12$vZ7ultLknOn5LfPj7grMBeEHKBaqU1IVDZ7KGSFZB0GqYthScKoMK', 'users', '[]', '[\"personal_access\"]', 0, '2025-05-18 15:36:46', '2025-05-18 15:36:46');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_device_codes`
--

CREATE TABLE `oauth_device_codes` (
  `id` char(80) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` char(36) NOT NULL,
  `user_code` char(8) NOT NULL,
  `scopes` text NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `user_approved_at` datetime DEFAULT NULL,
  `last_polled_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` char(80) NOT NULL,
  `access_token_id` char(80) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jabatan` varchar(255) NOT NULL,
  `nip` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `file_pegawai` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id_pegawai`, `nama`, `jabatan`, `nip`, `status`, `file_pegawai`) VALUES
(4, 'Spongebob Squarepants', 'Kepala Desa', '00000111000', 'Aktif', 'pegawai_files/AswLwaKRdmZ0k0JE8G3Gn8xtGVLvuPHBKRHEBY5a.jpg'),
(5, 'Spongebob Squarepants', 'MC', '9999999999', 'Mutasi', 'pegawai_files/ISagT4NZWsAC5nQFPsWzg1jUAnCv3CXwwVoZ7GT2.jpg'),
(6, 'Spongebob Squarepants', 'Bendahara', '2231203120391', 'Mutasi', 'pegawai_files/ZQiPbhgqmYD7JR4aFwFARSg10mtNI8f1Po9GeqSt.jpg'),
(8, 'Spongebob Squarepants', 'Sekretaris', '2312319283', 'Tidak Aktif', 'pegawai_files/BrprfmW0XeMSW0hDcX3sDiOKlRgMieIAb75OCQUP.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `produk_hukum`
--

CREATE TABLE `produk_hukum` (
  `id_produk_hukum` int(11) NOT NULL,
  `bentuk_produk_hukum` varchar(255) NOT NULL,
  `judul_produk_hukum` varchar(255) NOT NULL,
  `tahun_produk_hukum` varchar(255) NOT NULL,
  `file_dokumen_produk_hukum` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk_hukum`
--

INSERT INTO `produk_hukum` (`id_produk_hukum`, `bentuk_produk_hukum`, `judul_produk_hukum`, `tahun_produk_hukum`, `file_dokumen_produk_hukum`) VALUES
(1, 'Peraturan Daerah', 'Peraturan Satu', '2010', 'produk_hukum_files/2FwmH0tudkcSWAHxrCjye41RWzFcA8AnkTk3nWYX.zip'),
(2, 'Peraturan Daerah', 'Peraturan 2', '2030', 'produk_hukum_files/1rtWq9h3eUfgRH1h3vxLQYtjirJI397BDcMevuBq.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `struktur_organisasi`
--

CREATE TABLE `struktur_organisasi` (
  `id_struktur_organisasi` int(11) NOT NULL,
  `file_gambar_struktur_organisasi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `struktur_organisasi`
--

INSERT INTO `struktur_organisasi` (`id_struktur_organisasi`, `file_gambar_struktur_organisasi`) VALUES
(1, 'struktur_organisasi_files/P6Z5m9FgiLkKCP0oP2SmIjrxSVVWR55XGGp9o2EU.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `email`, `password`) VALUES
(1, 'admin@gmail.com', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aspirasi`
--
ALTER TABLE `aspirasi`
  ADD PRIMARY KEY (`id_aspirasi`);

--
-- Indexes for table `beranda`
--
ALTER TABLE `beranda`
  ADD PRIMARY KEY (`id_beranda`);

--
-- Indexes for table `berita`
--
ALTER TABLE `berita`
  ADD PRIMARY KEY (`id_berita`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `galeri`
--
ALTER TABLE `galeri`
  ADD PRIMARY KEY (`id_galeri`);

--
-- Indexes for table `grafik`
--
ALTER TABLE `grafik`
  ADD PRIMARY KEY (`id_grafik`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `layanan`
--
ALTER TABLE `layanan`
  ADD PRIMARY KEY (`id_layanan`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_owner_type_owner_id_index` (`owner_type`,`owner_id`);

--
-- Indexes for table `oauth_device_codes`
--
ALTER TABLE `oauth_device_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `oauth_device_codes_user_code_unique` (`user_code`),
  ADD KEY `oauth_device_codes_user_id_index` (`user_id`),
  ADD KEY `oauth_device_codes_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`);

--
-- Indexes for table `produk_hukum`
--
ALTER TABLE `produk_hukum`
  ADD PRIMARY KEY (`id_produk_hukum`);

--
-- Indexes for table `struktur_organisasi`
--
ALTER TABLE `struktur_organisasi`
  ADD PRIMARY KEY (`id_struktur_organisasi`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aspirasi`
--
ALTER TABLE `aspirasi`
  MODIFY `id_aspirasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `beranda`
--
ALTER TABLE `beranda`
  MODIFY `id_beranda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `berita`
--
ALTER TABLE `berita`
  MODIFY `id_berita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `galeri`
--
ALTER TABLE `galeri`
  MODIFY `id_galeri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `grafik`
--
ALTER TABLE `grafik`
  MODIFY `id_grafik` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `layanan`
--
ALTER TABLE `layanan`
  MODIFY `id_layanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id_pegawai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `produk_hukum`
--
ALTER TABLE `produk_hukum`
  MODIFY `id_produk_hukum` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `struktur_organisasi`
--
ALTER TABLE `struktur_organisasi`
  MODIFY `id_struktur_organisasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
