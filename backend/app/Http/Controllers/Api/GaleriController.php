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
use App\Models\Galeri;
class GaleriController extends Controller
{
    public function getAllGaleris()
    {
        $galeri = Galeri::all();
        if ($galeri->isEmpty()) {
            return response()->json([
                'message' => 'No Galeri found',
            ], 404);
        }

        return response()->json([
            'message' => 'Galeri retrieved successfully',
            'data' => $galeri,
        ], 200);
    }

    public function tambahGaleri(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'tanggal_media' => 'required',
            'file_gambar_media' => 'required|file|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('file_gambar_media')) {
            if ($request->file('file_gambar_media')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File gambar media maksimal 2MB',
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
        $gambarPath = $request->file('file_gambar_media')->store('galeri_files', 'public');

        // Buat Galeri
        $galeri = Galeri::create([
            'tanggal_media' => $request->tanggal_media,
            'file_gambar_media' => $gambarPath,
        ]);

        return response()->json([
            'message' => 'Galeri berhasil ditambahkan',
            'data' => $galeri,
        ], 201);
    }

    public function suntingGaleri(Request $request, $id_galeri)
    {
        $validator = Validator::make($request->all(), [
            'tanggal_media' => 'required',
            'file_gambar_media' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('file_gambar_media')) {
            if ($request->file('file_gambar_media')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File gambar media maksimal 2MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Cari Galeri
        $galeri = Galeri::find($id_galeri);
        if (!$galeri) {
            return response()->json([
                'message' => 'Galeri not found',
            ], 404);
        }

        // Update Galeri
        $galeri->tanggal_media = $request->tanggal_media;

        if ($request->hasFile('file_gambar_media')) {
            // Hapus file gambar media lama jika ada
            if ($galeri->file_gambar_media) {
                Storage::disk('public')->delete($galeri->file_gambar_media);
            }

            // Upload file baru
            $gambarPath = $request->file('file_gambar_media')->store('galeri_files', 'public');
            $galeri->file_gambar_media = $gambarPath;
        }

        $galeri->save();

        return response()->json([
            'message' => 'Galeri berhasil disunting',
            'data' => $galeri,
        ], 200);
    }

    public function hapusGaleri($id_galeri)
    {
        $galeri = Galeri::find($id_galeri);
        if (!$galeri) {
            return response()->json([
                'message' => 'Galeri not found',
            ], 404);
        }

        // Hapus file galeri jika ada
        if ($galeri->file_gambar_media) {
            Storage::disk('public')->delete($galeri->file_gambar_media);
        }

        $galeri->delete();

        return response()->json([
            'message' => 'Galeri berhasil dihapus',
        ], 200);
    }
}
