<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SubContractorsCosts extends Model
{
     protected $table = 'subcontractors_costs';

    protected $primaryKey = 'sc_id';

    protected $fillable = [
        'sc_id', 'claim_id','total_amount','per_attributed','description'
    ];
}
