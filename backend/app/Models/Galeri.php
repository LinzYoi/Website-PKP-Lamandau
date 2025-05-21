<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class Galeri extends Model
{
    //
    public $timestamps = false;
    protected $table = 'galeri';    
    protected $primaryKey = 'id_galeri';
    protected $fillable = [
        'tanggal_media',
        'file_gambar_media',
    ];
}
