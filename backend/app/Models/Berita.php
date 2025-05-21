<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class Berita extends Model
{
    //
    public $timestamps = false;
    protected $table = 'berita';
    protected $primaryKey = 'id_berita';
    protected $fillable = [
        'judul_berita',
        'deskripsi_berita',
        'tanggal_berita',
        'file_gambar_berita',
    ];    
}
