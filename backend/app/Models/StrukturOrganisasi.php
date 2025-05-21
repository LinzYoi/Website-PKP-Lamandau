<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class StrukturOrganisasi extends Model
{
    //
    public $timestamps = false;
    protected $table = 'struktur_organisasi';
    protected $primaryKey = 'id_struktur_organisasi';
    protected $fillable = [        
        'file_gambar_struktur_organisasi',
    ];
}
