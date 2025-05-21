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
use App\Models\Berita;
class BeritaController extends Controller
{
    public function getAllBeritas()
    {
        $berita = Berita::all();
        if ($berita->isEmpty()) {
            return response()->json([
                'message' => 'No Berita found',
            ], 404);
        }

        return response()->json([
            'message' => 'Berita retrieved successfully',
            'data' => $berita,
        ], 200);
    }

    public function tambahBerita(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'judul_berita' => 'required|string|max:255',
            'deskripsi_berita' => 'required|string',
            'tanggal_berita' => 'required',
            'file_gambar_berita' => 'required|file|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('file_gambar_berita')) {
            if ($request->file('file_gambar_berita')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File gambar berita maksimal 2MB',
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
        $gambarPath = $request->file('file_gambar_berita')->store('berita_files', 'public');

        // Buat Berita
        $berita = Berita::create([
            'judul_berita' => $request->judul_berita,
            'deskripsi_berita' => $request->deskripsi_berita,
            'tanggal_berita' => $request->tanggal_berita,
            'file_gambar_berita' => $gambarPath,
        ]);

        return response()->json([
            'message' => 'Berita berhasil ditambahkan',
            'data' => $berita,
        ], 201);
    }

    public function suntingBerita(Request $request, $id_berita)
    {
        $validator = Validator::make($request->all(), [
            'judul_berita' => 'required|string|max:255',
            'deskripsi_berita' => 'required|string',
            'tanggal_berita' => 'required',
            'file_gambar_berita' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('file_gambar_berita')) {
            if ($request->file('file_gambar_berita')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File gambar berita maksimal 2MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Cari Berita
        $berita = Berita::find($id_berita);
        if (!$berita) {
            return response()->json([
                'message' => 'Berita not found',
            ], 404);
        }

        // Update Berita
        $berita->judul_berita = $request->judul_berita;
        $berita->deskripsi_berita = $request->deskripsi_berita;
        $berita->tanggal_berita = $request->tanggal_berita;

        if ($request->hasFile('file_gambar_berita')) {
            // Hapus file gambar berita lama jika ada
            if ($berita->file_gambar_berita) {
                Storage::disk('public')->delete($berita->file_gambar_berita);
            }

            // Upload file baru
            $gambarPath = $request->file('file_gambar_berita')->store('berita_files', 'public');
            $berita->file_gambar_berita = $gambarPath;
        }

        $berita->save();

        return response()->json([
            'message' => 'Berita berhasil disunting',
            'data' => $berita,
        ], 200);
    }

    public function hapusBerita($id_berita)
    {
        $berita = Berita::find($id_berita);
        if (!$berita) {
            return response()->json([
                'message' => 'Berita not found',
            ], 404);
        }

        // Hapus file berita jika ada
        if ($berita->file_gambar_berita) {
            Storage::disk('public')->delete($berita->file_gambar_berita);
        }

        $berita->delete();

        return response()->json([
            'message' => 'Berita berhasil dihapus',
        ], 200);
    }
}
