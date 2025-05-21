<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class Layanan extends Model
{
    //
    public $timestamps = false;
    protected $table = 'layanan';
    protected $primaryKey = 'id_layanan';
    protected $fillable = [
        'judul_layanan',
        'deskripsi_layanan',
        'file_gambar_layanan',
        'file_dokumen_layanan',
    ];
}
