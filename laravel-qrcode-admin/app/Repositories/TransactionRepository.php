<?php

namespace App\Repositories;

use App\Models\Transaction;
use App\Repositories\BaseRepository;

/**
 * Class TransactionRepository
 * @package App\Repositories
 * @version July 16, 2020, 2:02 am UTC
*/

class TransactionRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        'name'
    ];

    /**
     * Return searchable fields
     *
     * @return array
     */
    public function getFieldsSearchable()
    {
        return $this->fieldSearchable;
    }

    /**
     * Configure the Model
     **/
    public function model()
    {
        return Transaction::class;
    }
}
