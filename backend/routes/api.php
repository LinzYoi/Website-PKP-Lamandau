<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Models\User;

Route::get('user', 'App\Http\Controllers\Api\AuthController@user')->middleware('auth:api');
Route::post('/login', [App\Http\Controllers\Api\AuthController::class, 'login']);

Route::get('/get-all-berandas', [App\Http\Controllers\Api\BerandaController::class, 'getAllBerandas']);
Route::get('/get-all-beritas', [App\Http\Controllers\Api\BeritaController::class, 'getAllBeritas']);
Route::get('/get-all-galeris', [App\Http\Controllers\Api\GaleriController::class, 'getAllGaleris']);
Route::get('/get-all-layanans', [App\Http\Controllers\Api\LayananController::class, 'getAllLayanans']);
Route::get('/get-all-produk-hukums', [App\Http\Controllers\Api\ProdukHukumController::class, 'getAllProdukHukums']);
Route::get('/get-all-struktur-organisasis', [App\Http\Controllers\Api\StrukturOrganisasiController::class, 'getAllStrukturOrganisasis']);
Route::get('/get-all-pegawais', [App\Http\Controllers\Api\PegawaiController::class, 'getAllPegawais']);
Route::post('/tambah-aspirasi', [App\Http\Controllers\Api\AspirasiController::class, 'tambahAspirasi']);

Route::group(['middleware' => 'auth:api'], function () {
    // Route::get('/logout', [App\Http\Controllers\Api\AuthController::class, 'logout']);
    
    Route::post('/tambah-pegawai', [App\Http\Controllers\Api\PegawaiController::class, 'tambahPegawai']);
    Route::post('/sunting-pegawai/{id_pegawai}', [App\Http\Controllers\Api\PegawaiController::class, 'suntingPegawai']);
    Route::delete('/hapus-pegawai/{id_pegawai}', [App\Http\Controllers\Api\PegawaiController::class, 'hapusPegawai']);

    Route::post('/tambah-layanan', [App\Http\Controllers\Api\LayananController::class, 'tambahLayanan']);
    Route::post('/sunting-layanan/{id_layanan}', [App\Http\Controllers\Api\LayananController::class, 'suntingLayanan']);
    Route::delete('/hapus-layanan/{id_layanan}', [App\Http\Controllers\Api\LayananController::class, 'hapusLayanan']);

    Route::post('/tambah-produk-hukum', [App\Http\Controllers\Api\ProdukHukumController::class, 'tambahProdukHukum']);
    Route::post('/sunting-produk-hukum/{id_produk_hukum}', [App\Http\Controllers\Api\ProdukHukumController::class, 'suntingProdukHukum']);
    Route::delete('/hapus-produk-hukum/{id_produk_hukum}', [App\Http\Controllers\Api\ProdukHukumController::class, 'hapusProdukHukum']);

    Route::post('/tambah-berita', [App\Http\Controllers\Api\BeritaController::class, 'tambahBerita']);
    Route::post('/sunting-berita/{id_berita}', [App\Http\Controllers\Api\BeritaController::class, 'suntingBerita']);
    Route::delete('/hapus-berita/{id_berita}', [App\Http\Controllers\Api\BeritaController::class, 'hapusBerita']);

    Route::get('/get-all-aspirasis', [App\Http\Controllers\Api\AspirasiController::class, 'getAllAspirasis']);
    Route::delete('/hapus-aspirasi/{id_aspirasi}', [App\Http\Controllers\Api\AspirasiController::class, 'hapusAspirasi']);
    
    Route::post('/tambah-galeri', [App\Http\Controllers\Api\GaleriController::class, 'tambahGaleri']);
    Route::post('/sunting-galeri/{id_galeri}', [App\Http\Controllers\Api\GaleriController::class, 'suntingGaleri']);
    Route::delete('/hapus-galeri/{id_galeri}', [App\Http\Controllers\Api\GaleriController::class, 'hapusGaleri']);
    
    Route::post('/sunting-struktur-organisasi/{id_struktur_organisasi}', [App\Http\Controllers\Api\StrukturOrganisasiController::class, 'suntingStrukturOrganisasi']);
    
    Route::post('/sunting-beranda/{id_beranda}', [App\Http\Controllers\Api\BerandaController::class, 'suntingBeranda']);
});
