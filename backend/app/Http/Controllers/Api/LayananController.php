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
use App\Models\Layanan;
class LayananController extends Controller
{
    public function getAllLayanans()
    {
        $layanan = Layanan::all();
        if ($layanan->isEmpty()) {
            return response()->json([
                'message' => 'No Layanan found',
            ], 404);
        }

        return response()->json([
            'message' => 'Layanan retrieved successfully',
            'data' => $layanan,
        ], 200);
    }

    public function tambahLayanan(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'judul_layanan' => 'required|string|max:255',
            'deskripsi_layanan' => 'required|string',
            'file_gambar_layanan' => 'required|file|mimes:jpg,jpeg,png|max:2048',
            'file_dokumen_layanan' => 'nullable|file|mimes:zip|max:20480',
        ]);

        if ($request->hasFile('file_gambar_layanan')) {
            if ($request->file('file_gambar_layanan')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File gambar layanan maksimal 2MB',
                ], 422);
            }
        }

        if ($request->hasFile('file_dokumen_layanan')) {
            if ($request->file('file_dokumen_layanan')->getSize() > 20480 * 1024) {
                return response()->json([
                    'message' => 'File dokumen layanan maksimal 20MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Upload file
        $gambarPath = $request->file('file_gambar_layanan')->store('layanan_files', 'public');
        $dokumenPath = null;
        if ($request->hasFile('file_dokumen_layanan')) {
            $dokumenPath = $request->file('file_dokumen_layanan')->store('layanan_files', 'public');
        }

        // Buat Layanan
        $layanan = Layanan::create([
            'judul_layanan' => $request->judul_layanan,
            'deskripsi_layanan' => $request->deskripsi_layanan,
            'file_gambar_layanan' => $gambarPath,
            'file_dokumen_layanan' => $dokumenPath,
        ]);

        return response()->json([
            'message' => 'Layanan berhasil ditambahkan',
            'data' => $layanan,
        ], 201);
    }

    public function suntingLayanan(Request $request, $id_layanan)
    {
        $validator = Validator::make($request->all(), [
            'judul_layanan' => 'required|string|max:255',
            'deskripsi_layanan' => 'required|string',
            'file_gambar_layanan' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
            'file_dokumen_layanan' => 'nullable|file|mimes:zip|max:20480',
        ]);

        if ($request->hasFile('file_gambar_layanan')) {
            if ($request->file('file_gambar_layanan')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File gambar layanan maksimal 2MB',
                ], 422);
            }
        }

        if ($request->hasFile('file_dokumen_layanan')) {
            if ($request->file('file_dokumen_layanan')->getSize() > 20480 * 1024) {
                return response()->json([
                    'message' => 'File dokumen layanan maksimal 20MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Cari Layanan
        $layanan = Layanan::find($id_layanan);
        if (!$layanan) {
            return response()->json([
                'message' => 'Layanan not found',
            ], 404);
        }

        // Update Layanan
        $layanan->judul_layanan = $request->judul_layanan;
        $layanan->deskripsi_layanan = $request->deskripsi_layanan;

        if ($request->hasFile('file_gambar_layanan')) {
            // Hapus file gambar layanan lama jika ada
            if ($layanan->file_gambar_layanan) {
                Storage::disk('public')->delete($layanan->file_gambar_layanan);
            }

            // Upload file baru
            $gambarPath = $request->file('file_gambar_layanan')->store('layanan_files', 'public');
            $layanan->file_gambar_layanan = $gambarPath;
        }

        if ($request->hasFile('file_dokumen_layanan')) {
            // Hapus file dokumen layanan lama jika ada
            if ($layanan->file_dokumen_layanan) {
                Storage::disk('public')->delete($layanan->file_dokumen_layanan);
            }

            // Upload file baru
            $dokumenPath = $request->file('file_dokumen_layanan')->store('layanan_files', 'public');
            $layanan->file_dokumen_layanan = $dokumenPath;
        }

        $layanan->save();

        return response()->json([
            'message' => 'Layanan berhasil disunting',
            'data' => $layanan,
        ], 200);
    }

    public function hapusLayanan($id_layanan)
    {
        $layanan = Layanan::find($id_layanan);
        if (!$layanan) {
            return response()->json([
                'message' => 'Layanan not found',
            ], 404);
        }

        // Hapus file layanan jika ada
        if ($layanan->file_gambar_layanan) {
            Storage::disk('public')->delete($layanan->file_gambar_layanan);
        }
        if ($layanan->file_dokumen_layanan) {
            Storage::disk('public')->delete($layanan->file_dokumen_layanan);
        }

        $layanan->delete();

        return response()->json([
            'message' => 'Layanan berhasil dihapus',
        ], 200);
    }
}
