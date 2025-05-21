<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class Aspirasi extends Model
{
    //
    public $timestamps = false;
    protected $table = 'Aspirasi';
    protected $primaryKey = 'id_aspirasi';
    protected $fillable = [
        'judul_aspirasi',
        'tanggal_aspirasi',
        'isi_aspirasi',
        'nama_pembuat',
        'no_telp_pembuat',
        'email_pembuat',
        'file_gambar_aspirasi',
    ];
}
