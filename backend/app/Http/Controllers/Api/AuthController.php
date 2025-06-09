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

        if ($request->password != $user->password) {
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
}
