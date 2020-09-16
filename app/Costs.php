<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Costs extends Model
{
     protected $table = 'costs';

    protected $primaryKey = 'cost_id';

    protected $fillable = [
        'cost_id', 'claim_id','expenditure','total_amount','per_attributed'
    ];
}
