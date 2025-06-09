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
use Illuminate\Support\Facades\Http;


use App\Models\User;
use App\Models\Aspirasi;
class AspirasiController extends Controller
{
    public function getAllAspirasis()
    {
        $aspirasi = Aspirasi::all();
        if ($aspirasi->isEmpty()) {
            return response()->json([
                'message' => 'No Aspirasi found',
            ], 404);
        }

        return response()->json([
            'message' => 'Aspirasi retrieved successfully',
            'data' => $aspirasi,
        ], 200);
    }

    public function tambahAspirasi(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'judul_aspirasi' => 'required|string|max:255',
            'isi_aspirasi' => 'required|string',
            'nama_pembuat' => 'required|string|max:255',
            'no_telp_pembuat' => 'required|string|max:255',
            'email_pembuat' => 'required|email|max:255',
            'file_gambar_aspirasi' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',            
            // 'g-recaptcha-response' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // $recaptchaToken = $request->input('g-recaptcha-response');
        // $secretKey = '6Lf_6FcrAAAAAPoiquNu_LUVLYgDc5O6uSleJCii';
        // $recaptchaVerifyUrl = 'https://www.google.com/recaptcha/api/siteverify';
        // $recaptchaVerifyResponse = Http::post($recaptchaVerifyUrl, [
        //     'secret' => $secretKey,
        //     'response' => $recaptchaToken,
        // ]);

        // $recaptchaBody = $recaptchaVerifyResponse->json();

        // if (!isset($recaptchaBody['success']) || $recaptchaBody['success'] !== true) {
        //     return response()->json([
        //         'message' => 'reCAPTCHA tidak valid. Silakan cek kembali.',
        //         'errors' => ['recaptcha' => ['Verifikasi reCAPTCHA gagal.']],
        //     ], 422);
        // }
        
        $gambarPath = null;
        if ($request->hasFile('file_gambar_aspirasi')) {
            $gambarPath = $request->file('file_gambar_aspirasi')->store('aspirasi_files', 'public');
        }

        $aspirasi = Aspirasi::create([
            'judul_aspirasi' => $request->judul_aspirasi,
            'tanggal_aspirasi' => Carbon::now(),
            'isi_aspirasi' => $request->isi_aspirasi,
            'nama_pembuat' => $request->nama_pembuat,
            'no_telp_pembuat' => $request->no_telp_pembuat,
            'email_pembuat' => $request->email_pembuat,
            'file_gambar_aspirasi' => $gambarPath,
        ]);

        return response()->json([
            'message' => 'Aspirasi berhasil ditambahkan',
            'data' => $aspirasi,
        ], 201);
    }


    public function hapusAspirasi($id_aspirasi)
    {
        $aspirasi = Aspirasi::find($id_aspirasi);
        if (!$aspirasi) {
            return response()->json([
                'message' => 'Aspirasi not found',
            ], 404);
        }

        // Hapus file aspirasi jika ada
        if ($aspirasi->file_gambar_aspirasi) {
            Storage::disk('public')->delete($aspirasi->file_gambar_aspirasi);
        }

        $aspirasi->delete();

        return response()->json([
            'message' => 'Aspirasi berhasil dihapus',
        ], 200);
    }
}
