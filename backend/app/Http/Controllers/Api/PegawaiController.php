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
use App\Models\Pegawai;
class PegawaiController extends Controller
{
    public function getAllPegawais()
    {
        $pegawai = Pegawai::all();
        if ($pegawai->isEmpty()) {
            return response()->json([
                'message' => 'No Pegawai found',
            ], 404);
        }

        return response()->json([
            'message' => 'Pegawai retrieved successfully',
            'data' => $pegawai,
        ], 200);
    }

    public function tambahPegawai(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama' => 'required|string|max:255',
            'jabatan' => 'required|string|max:255',
            'nip' => 'required|string|max:255',
            'status' => 'required|string|max:255',
            'file_pegawai' => 'required|file|mimes:jpg,jpeg,png,pdf|max:2048',
        ]);

        if ($request->hasFile('file_pegawai')) {
            if ($request->file('file_pegawai')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File maksimal 2MB',
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
        $filePath = $request->file('file_pegawai')->store('pegawai_files', 'public');

        // Buat Pegawai
        $pegawai = Pegawai::create([
            'nama' => $request->nama,
            'jabatan' => $request->jabatan,
            'nip' => $request->nip,
            'status' => $request->status,
            'file_pegawai' => $filePath,
        ]);

        return response()->json([
            'message' => 'Pegawai berhasil ditambahkan',
            'data' => $pegawai,
        ], 201);
    }

    public function suntingPegawai(Request $request, $id_pegawai)
    {
        $validator = Validator::make($request->all(), [
            'nama' => 'required|string|max:255',
            'jabatan' => 'required|string|max:255',
            'nip' => 'required|string|max:255',
            'status' => 'required|string|max:255',
            'file_pegawai' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:2048',
        ]);

        if ($request->hasFile('file_pegawai')) {
            if ($request->file('file_pegawai')->getSize() > 2048 * 1024) {
                return response()->json([
                    'message' => 'File maksimal 2MB',
                ], 422);
            }
        }

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Input kosong atau tidak valid',
                'errors' => $validator->errors(),
            ], 422);
        }

        // Cari Pegawai
        $pegawai = Pegawai::find($id_pegawai);
        if (!$pegawai) {
            return response()->json([
                'message' => 'Pegawai not found',
            ], 404);
        }

        // Update Pegawai
        $pegawai->nama = $request->nama;
        $pegawai->jabatan = $request->jabatan;
        $pegawai->nip = $request->nip;
        $pegawai->status = $request->status;

        if ($request->hasFile('file_pegawai')) {
            // Hapus file pegawai lama jika ada
            if ($pegawai->file_pegawai) {
                Storage::disk('public')->delete($pegawai->file_pegawai);
            }

            // Upload file baru
            $filePath = $request->file('file_pegawai')->store('pegawai_files', 'public');
            $pegawai->file_pegawai = $filePath;
        }

        $pegawai->save();

        return response()->json([
            'message' => 'Pegawai berhasil disunting',
            'data' => $pegawai,
        ], 200);
    }
    
    public function hapusPegawai($id_pegawai)
    {
        $pegawai = Pegawai::find($id_pegawai);
        if (!$pegawai) {
            return response()->json([
                'message' => 'Pegawai not found',
            ], 404);
        }

        // Hapus file pegawai jika ada
        if ($pegawai->file_pegawai) {
            Storage::disk('public')->delete($pegawai->file_pegawai);
        }

        $pegawai->delete();

        return response()->json([
            'message' => 'Pegawai berhasil dihapus',
        ], 200);
    }    
}
