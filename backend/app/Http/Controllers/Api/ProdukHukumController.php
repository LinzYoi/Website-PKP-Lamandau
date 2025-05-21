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
use App\Models\ProdukHukum;
class ProdukHukumController extends Controller
{
    public function getAllProdukHukums()
    {
        $produk_hukum = ProdukHukum::all();
        if ($produk_hukum->isEmpty()) {
            return response()->json([
                'message' => 'No Produk Hukum found',
            ], 404);
        }

        return response()->json([
            'message' => 'Produk Hukum retrieved successfully',
            'data' => $produk_hukum,
        ], 200);
    }

    public function tambahProdukHukum(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'bentuk_produk_hukum' => 'required|string|max:255',
            'judul_produk_hukum' => 'required|string|max:255',
            'tahun_produk_hukum' => 'required|string',
            'file_dokumen_produk_hukum' => 'required|file|mimes:zip,pdf,doc,docx|max:20480',
        ]);

        if ($request->hasFile('file_dokumen_produk_hukum')) {
            if ($request->file('file_dokumen_produk_hukum')->getSize() > 20480 * 1024) {
                return response()->json([
                    'message' => 'File dokumen produk hukum maksimal 20MB',
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
        $dokumenPath = $request->file('file_dokumen_produk_hukum')->store('produk_hukum_files', 'public');

        // Buat Produk Hukum
        $produk_hukum = ProdukHukum::create([
            'bentuk_produk_hukum' => $request->bentuk_produk_hukum,
            'judul_produk_hukum' => $request->judul_produk_hukum,
            'tahun_produk_hukum' => $request->tahun_produk_hukum,
            'file_dokumen_produk_hukum' => $dokumenPath,
        ]);

        return response()->json([
            'message' => 'Produk Hukum berhasil ditambahkan',
            'data' => $produk_hukum,
        ], 201);
    }

    public function suntingProdukHukum(Request $request, $id_produk_hukum)
    {
        $validator = Validator::make($request->all(), [
            'bentuk_produk_hukum' => 'required|string|max:255',
            'judul_produk_hukum' => 'required|string|max:255',
            'tahun_produk_hukum' => 'required|string',
            'file_dokumen_produk_hukum' => 'nullable|file|mimes:zip,pdf,doc,docx|max:20480',
        ]);

        if ($request->hasFile('file_dokumen_produk_hukum')) {
            if ($request->file('file_dokumen_produk_hukum')->getSize() > 20480 * 1024) {
                return response()->json([
                    'message' => 'File dokumen produk hukum maksimal 20MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Cari Produk Hukum
        $produk_hukum = ProdukHukum::find($id_produk_hukum);
        if (!$produk_hukum) {
            return response()->json([
                'message' => 'Produk Hukum not found',
            ], 404);
        }

        // Update Produk Hukum
        $produk_hukum->bentuk_produk_hukum = $request->bentuk_produk_hukum;
        $produk_hukum->judul_produk_hukum = $request->judul_produk_hukum;
        $produk_hukum->tahun_produk_hukum = $request->tahun_produk_hukum;

        if ($request->hasFile('file_dokumen_produk_hukum')) {
            // Hapus file dokumen produk hukum lama jika ada
            if ($produk_hukum->file_dokumen_produk_hukum) {
                Storage::disk('public')->delete($produk_hukum->file_dokumen_produk_hukum);
            }

            // Upload file baru
            $dokumenPath = $request->file('file_dokumen_produk_hukum')->store('produk_hukum_files', 'public');
            $produk_hukum->file_dokumen_produk_hukum = $dokumenPath;
        }

        $produk_hukum->save();

        return response()->json([
            'message' => 'Produk Hukum berhasil disunting',
            'data' => $produk_hukum,
        ], 200);
    }

    public function hapusProdukHukum($id_produk_hukum)
    {
        $produk_hukum = ProdukHukum::find($id_produk_hukum);
        if (!$produk_hukum) {
            return response()->json([
                'message' => 'Produk Hukum not found',
            ], 404);
        }

        // Hapus file produk hukum jika ada
        if ($produk_hukum->file_dokumen_produk_hukum) {
            Storage::disk('public')->delete($produk_hukum->file_dokumen_produk_hukum);
        }

        $produk_hukum->delete();

        return response()->json([
            'message' => 'Produk Hukum berhasil dihapus',
        ], 200);
    }
}
