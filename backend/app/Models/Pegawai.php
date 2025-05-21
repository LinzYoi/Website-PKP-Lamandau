<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use PhpParser\Node\Expr\Cast;

class Pegawai extends Model
{
    //
    public $timestamps = false;
    protected $table = 'pegawai';
    protected $primaryKey = 'id_pegawai';
    protected $fillable = [
        'nama',
        'jabatan',
        'nip',
        'status',
        'file_pegawai',
    ];
}
