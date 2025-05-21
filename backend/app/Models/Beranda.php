<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class Beranda extends Model
{
    //
    public $timestamps = false;
    protected $table = 'beranda';
    protected $primaryKey = 'id_beranda';
    protected $fillable = [
        'judul_beranda',
        'deskripsi_beranda',
        'nama',
        'file_beranda',
    ];
}
