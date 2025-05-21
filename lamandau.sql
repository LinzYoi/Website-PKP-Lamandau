-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2025 at 06:24 PM
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
  `file_gambar_aspirasi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aspirasi`
--

INSERT INTO `aspirasi` (`id_aspirasi`, `judul_aspirasi`, `tanggal_aspirasi`, `isi_aspirasi`, `nama_pembuat`, `no_telp_pembuat`, `email_pembuat`, `file_gambar_aspirasi`) VALUES
(2, 'Aspirasi 1', '2025-05-20', 'Akku dakwj dkajw dkam kaw skmaw skma? dkawkawms kajwsmkajwsk ajwskaw saw smanw smanwsawsawsalwksa ws akwmsakmws akmws amkw smawdalkwdmalkd. adwnd awjd akwwjd akwjwkd akwjd w.', 'Paijo', '082993827212', 'paijo@gmail.com', '');

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
(1, NULL, NULL, NULL, 'berita_files/qujdVTfWBzYgNoIqo3isfrjSgm7mTL2aFG8PKRkZ.mp4'),
(2, 'Bupati dan Wakil Bupati Kabupaten Lamandau', NULL, NULL, 'berita_files/ejlcWsEDdnGsz7aKm2KlT4aSBl4mt33HhKVXU5IZ.jpg'),
(3, 'Dinas PUPR PERKIMTAN Kabupaten Lamandau', 'DPUPR PERKIMTAN Lamandau memiliki tugas pokok untuk membantu Bupati dalam melaksanakan kewenangan desentralisasi dan dekonsentrasi di bidang perumahan, kawasan permukiman, dan pertanahan sesuai dengan kebijakan yang telah ditetapkan berdasarkan peraturan perundang-undangan.', NULL, 'berita_files/8O7yqGChtMHsWkPWs80QUOd5LqkbIbXdlBA8qulV.jpg'),
(4, 'Kepala DPUPR PERKIMTAN Kabupaten Lamandau', 'Selamat datang di website resmi Bidang Perumahan dan Kawasan Permukiman Dinas PUPR Perkimtan Kabupaten Lamandau. Kami berkomitmen memberikan layanan terbaik dalam mewujudkan hunian yang layak dan kawasan permukiman yang tertata demi kenyamanan dan kesejahteraan masyarakat.', 'Kepala Dinas A', 'berita_files/RuMGoklHJZERTZz0ciF9Xsc44r42jW9MBEx3rlZQ.png');

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
(1, 'Berita', 'asdas asas asdadawm ndmanw dmna wmdna mnws amwn smanw s', '2025-05-05', 'berita_files/DpdY6iKTtEQAHJhlJIJUOc4Uo1c9mjOxn0PWqEX2.png'),
(3, 'dawdwa', 'dawdawd', '2025-05-21', 'berita_files/MWvU3cPeEUCi5PMqsMM8ndWqO3QaB9HP5LO14Z3D.png');

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
(2, '2025-05-17', 'galeri_files/3n4QGNDZMqsvxHMz0PvMHUjd9bi5uLqhWSLJz7uZ.png');

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
(1, 'dadwa sfsefse', 'dawdawd', 'layanan_files/l2HgDpITWBTXc52gODQ8F9LlOcjC4IeKHWhVtaZU.jpg', 'layanan_files/ggfFffTQwOzcUOEB1Z75z7s71W7Xb6XqtICsEBrc.zip'),
(2, 'asjdnakjsd', 'dawjdajkw d', 'layanan_files/ZuCmgbLFcBSvAFXdqcjN0OI0uDIKMUmxBA1RqoaK.jpg', 'layanan_files/Sh7c8LMsnXBjCTC8E2qt41fupfndjfONpucr1cZS.zip');

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
('3735c965f846519602c3ce87f054ba3b1ad83b9c14da924309aedd52534ec1c716ce0a4e4288aa55', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-20 13:59:28', '2025-05-20 13:59:29', '2025-05-21 20:59:29'),
('4b142f2255cace68af181feaa8c49a8e69b58d412a65dbd3cfcbd7dd1b704ce86f23a1a50bdb7acb', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-19 11:23:08', '2025-05-19 11:23:08', '2025-05-20 18:23:08'),
('8cafe7992594b62c00297323f69687b85a71dc0cb624f23d0a8f8428f6bee192ebb53a26b3f8858e', 1, '0196e40a-5cd2-722e-a745-1b6a291f9fc8', 'auth_token', '[\"*\"]', 0, '2025-05-21 13:12:25', '2025-05-21 13:12:26', '2025-05-22 20:12:26'),
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
(4, 'Caplin asdawdaw', 'Kepala Desa', '00000111000', 'Aktif', 'pegawai_files/yuhwVNchqrg3krIHx0g3ciU0eFHJtlPI8vREoVg2.jpg'),
(5, 'Spongebob', 'MC', '9999999999', 'Mutasi', 'pegawai_files/0ZgAbenHzmpVbwD1mMT47TwsMdkQf7zgJKJj9ohh.jpg'),
(6, 'sfesfef', 'efse', 'edsed', 'Mutasi', 'pegawai_files/CqTHKnZJKsb2t45anuciiq0GzAmtLzPWKcx41DF2.png');

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
(1, 'Peraturan Daerah', 'efs', '2010', 'produk_hukum_files/2FwmH0tudkcSWAHxrCjye41RWzFcA8AnkTk3nWYX.zip'),
(2, 'Peraturan Daerah', 'adaw', '2030', 'produk_hukum_files/1rtWq9h3eUfgRH1h3vxLQYtjirJI397BDcMevuBq.pdf');

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
(1, 'struktur_organisasi_files/r4Fk4ocRHl3431PF3fMnpMXgEwhp2oleCl9AfgTP.png');

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
(1, 'admin@gmail.com', '$2y$10$DnKOeI6tSLBzHOqK8dWzue/fZ8KaNu3rrFuu9.op0KGRn9bvOFrDy');

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
  MODIFY `id_aspirasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id_galeri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id_pegawai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
