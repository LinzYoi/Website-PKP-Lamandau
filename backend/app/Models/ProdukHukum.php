<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class ProdukHukum extends Model
{
    //
    public $timestamps = false;
    protected $table = 'produk_hukum';
    protected $primaryKey = 'id_produk_hukum';
    protected $fillable = [
        'bentuk_produk_hukum',
        'judul_produk_hukum',
        'tahun_produk_hukum',
        'file_dokumen_produk_hukum',
    ];
}
