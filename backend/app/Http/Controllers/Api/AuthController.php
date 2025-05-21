<?php

namespace App\Http\Controllers\Api;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;


use App\Models\User;
use App\Models\Warga;
use App\Models\OrangTua;
class AuthController extends Controller
{
    public function user()
    {
        $user = Auth::user();

        return response()->json([
            'message' => 'User berhasil diambil',
            'data' => $user,
        ], 200);
    }
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Invalid input',
                'errors' => $validator->errors(),
            ], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response([
                'message' => 'Email tidak terdaftar',
                'data' => null
            ], 404);
        }

        if (!Hash::check($request->password, $user->password)) {
            return response()->json([
                'message' => 'Password tidak sesuai',
            ], 401);
        }

        $token = $user->createTokenWithExpiry('auth_token', ['*']);

        return response()->json([
            'message' => 'Login berhasil',
            'data' => [
                'user' => $user,
                'auth_token' => $token->accessToken,
                'expires_at' => $token->token->expires_at,
            ],
        ], 200);
    }

    public function pendaftaranWarga(Request $request)
    {
        $validator = Validator::make($request->all(), [
            // User Warga
            'nama_warga' => 'required',
            'no_telp_warga' => 'required',
            'email_warga' => 'required|email|unique:user,email',
            'password_warga' => 'required',

            // Warga
            'nik' => 'required',
            'tempat_lahir' => 'required',
            'tanggal_lahir' => 'required',
            'alamat_ktp' => 'required',
            'universitas' => 'required',
            'angkatan' => 'required',

            // Files
            'ktp_file' => 'required|file|mimes:jpg,jpeg,png,pdf|max:2048',
            'ktm_file' => 'required|file|mimes:jpg,jpeg,png,pdf|max:2048',

            // User Orang Tua
            'nama_ortu' => 'required',
            'no_telp_ortu' => 'required',
            'email_ortu' => 'required|email|unique:user,email',
            'password_ortu' => 'required',            

            // Orang Tua
            'nama_ayah' => 'required',
            'nama_ibu' => 'required',
            'alamat' => 'required',
        ]);

        if ($request->file('ktp_file')->getSize() > 2048 * 1024) {
            return response()->json([
                'message' => 'File size exceeds 2MB',
            ], 422);
        }
        if ($request->file('ktm_file')->getSize() > 2048 * 1024) {
            return response()->json([
                'message' => 'File size exceeds 2MB',
            ], 422);
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Invalid input',
                'errors' => $validator->errors(),
            ], 422);
        }

        // jika email sudah ada di database
        if (User::where('email', $request->email_warga)->exists()) {
            return response()->json([
                'message' => 'Email warga sudah terdaftar',
            ], 422);
        }
        if (User::where('email', $request->email_ortu)->exists()) {
            return response()->json([
                'message' => 'Email orang tua sudah terdaftar',
            ], 422);
        }

        if ($request->email_warga === $request->email_ortu) {
            return response()->json([
                'message' => 'Email anda dan orang tua anda tidak boleh sama',
            ], 422);
        }

        // 1. Buat User untuk Warga
        $userWarga = User::create([
            'nama' => $request->nama_warga,
            'email' => $request->email_warga,
            'no_telp' => $request->no_telp_warga,
            'password' => Hash::make($request->password_warga),
            'role' => 'warga',
        ]);

        // 2. Buat User untuk Orang Tua
        $userOrtu = User::create([
            'nama' => $request->nama_ortu,
            'email' => $request->email_ortu,
            'no_telp' => $request->no_telp_ortu,
            'password' => Hash::make($request->password_ortu),
            'role' => 'ortu',
        ]);

        // 3. Buat Orang Tua
        $orangTua = OrangTua::create([
            'id_user' => $userOrtu->id_user,
            'nama_ayah' => $request->nama_ayah,
            'nama_ibu' => $request->nama_ibu,
            'alamat' => $request->alamat,
        ]);

        // 4. Upload file
        $ktpPath = $request->file('ktp_file')->store('ktp_files', 'public');
        $ktmPath = $request->file('ktm_file')->store('ktm_files', 'public');

        // 5. Buat Warga
        $warga = Warga::create([
            'id_user' => $userWarga->id_user,
            'id_orang_tua' => $orangTua->id_orang_tua,
            'nik' => $request->nik,
            'tempat_lahir' => $request->tempat_lahir,
            'tanggal_lahir' => Carbon::createFromFormat('Y-m-d', $request->tanggal_lahir)->format('Y-m-d H:i:s'),
            'alamat_ktp' => $request->alamat_ktp,
            'universitas' => $request->universitas,
            'angkatan' => $request->angkatan,
            'ktp_file' => $ktpPath,
            'ktm_file' => $ktmPath,
            'tanggal_daftar' => Carbon::now(),
        ]);

        return response()->json([
            'message' => 'Pendaftaran berhasil',
            'data' => [
                'warga' => $warga->load('orangTua'),
                'user_warga' => $userWarga,
                'user_orang_tua' => $userOrtu,
            ]
        ], 201);
    }

}
