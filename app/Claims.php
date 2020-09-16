<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Claims extends Model
{
     protected $table = 'claims';

    protected $primaryKey = 'id';

    protected $fillable = [
        	'id','company_id', 'status', 'paid_status'
    ];

    public function companyClaim()

    {

        return $this->hasOne('App\CompanyClaims');

    }
}
