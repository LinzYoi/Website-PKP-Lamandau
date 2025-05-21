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
use App\Models\StrukturOrganisasi;
class StrukturOrganisasiController extends Controller
{
    public function getAllStrukturOrganisasis()
    {
        $struktur_organisasi = StrukturOrganisasi::all();
        if ($struktur_organisasi->isEmpty()) {
            return response()->json([
                'message' => 'No Struktur Organisasi found',
            ], 404);
        }

        return response()->json([
            'message' => 'Struktur Organisasi retrieved successfully',
            'data' => $struktur_organisasi,
        ], 200);
    }

    public function suntingStrukturOrganisasi(Request $request, $id_struktur_organisasi)
    {
        $validator = Validator::make($request->all(), [
            'file_gambar_struktur_organisasi' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('file_gambar_struktur_organisasi')) {
            if ($request->file('file_gambar_struktur_organisasi')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File gambar struktur organisasi maksimal 2MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Cari Struktur Organisasi
        $struktur_organisasi = StrukturOrganisasi::find($id_struktur_organisasi);
        if (!$struktur_organisasi) {
            return response()->json([
                'message' => 'Struktur Organisasi not found',
            ], 404);
        }

        // Update Struktur Organisasi
        if ($request->hasFile('file_gambar_struktur_organisasi')) {
            // Hapus file gambar struktur organisasi lama jika ada
            if ($struktur_organisasi->file_gambar_struktur_organisasi) {
                Storage::disk('public')->delete($struktur_organisasi->file_gambar_struktur_organisasi);
            }

            // Upload file baru
            $gambarPath = $request->file('file_gambar_struktur_organisasi')->store('struktur_organisasi_files', 'public');
            $struktur_organisasi->file_gambar_struktur_organisasi = $gambarPath;
        }

        $struktur_organisasi->save();

        return response()->json([
            'message' => 'Struktur Organisasi berhasil disunting',
            'data' => $struktur_organisasi,
        ], 200);
    }
}
