<?php

namespace App\Models;

use Eloquent as Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class Qrcode
 * @package App\Models
 * @version July 16, 2020, 1:59 am UTC
 *
 * @property integer $user_id
 * @property string $website
 * @property string $product_name
 * @property string $product_url
 * @property string $company_name
 * @property string $callback_url
 * @property string $qrcode_path
 * @property boolean $status
 * @property number $amount
 */
class Qrcode extends Model
{
    use SoftDeletes;

    public $table = 'qrcodes';

    const CREATED_AT = 'created_at';
    const UPDATED_AT = 'updated_at';


    protected $dates = ['deleted_at'];



    public $fillable = [
        'user_id',
        'website',
        'product_name',
        'product_url',
        'company_name',
        'callback_url',
        'qrcode_path',
        'status',
        'amount'
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
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

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        'user_id' => 'required',
        'product_name' => 'required',
        'company_name' => 'required',
        'callback_url' => 'required',
        //'qrcode_path' => 'required',
        'status' => 'required',
        'amount' => 'required'
    ];


}
