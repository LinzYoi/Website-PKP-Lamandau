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
use App\Models\Beranda;
class BerandaController extends Controller
{
    public function getAllBerandas()
    {
        $beranda = Beranda::all();
        if ($beranda->isEmpty()) {
            return response()->json([
                'message' => 'No Beranda found',
            ], 404);
        }

        return response()->json([
            'message' => 'Beranda retrieved successfully',
            'data' => $beranda,
        ], 200);
    }

    public function suntingBeranda(Request $request, $id_beranda)
    {
        $validator = Validator::make($request->all(), [
            'judul_beranda' => 'nullable|string|max:255',
            'deskripsi_beranda' => 'nullable|string',
            'nama' => 'nullable|string|max:255',
            'file_beranda' => 'nullable|file|mimes:jpg,jpeg,png,mp4,mov|max:204800',
        ]);

        if ($request->hasFile('file_beranda')) {
            if ($request->file('file_beranda')->getSize() > 204800 * 1024) {
                return response()->json([
                    'message' => 'File gambar/video beranda maksimal 200MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Cari Beranda
        $beranda = Beranda::find($id_beranda);
        if (!$beranda) {
            return response()->json([
                'message' => 'Beranda not found',
            ], 404);
        }

        // Update Beranda
        $beranda->judul_beranda = $request->judul_beranda;
        $beranda->deskripsi_beranda = $request->deskripsi_beranda;
        $beranda->nama = $request->nama;

        if ($request->hasFile('file_beranda')) {
            // Hapus file gambar berita lama jika ada
            if ($beranda->file_beranda) {
                Storage::disk('public')->delete($beranda->file_beranda);
            }

            // Upload file baru
            $gambarPath = $request->file('file_beranda')->store('berita_files', 'public');
            $beranda->file_beranda = $gambarPath;
        }

        $beranda->save();

        return response()->json([
            'message' => 'Beranda berhasil disunting',
            'data' => $beranda,
        ], 200);
    }
}
