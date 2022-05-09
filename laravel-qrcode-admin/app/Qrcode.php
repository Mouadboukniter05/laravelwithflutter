<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Qrcode extends Model
{
    protected $fillable = [
        'user_id', 'website', 'product_name','product_url','company_name',
    ];
    protected $casts = [
        'id' => 'integer',
        'user_id' => 'integer',
        'website' => 'string',
        'product_name' => 'string',
        'product_url' => 'string',
        'company_name' => 'string',
        'callback_url' => 'string',
        'qrcode_path' => 'string',
        'status' => 'boolean',
        'amount' => 'float'
    ];

}
