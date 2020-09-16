<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EPWCosts extends Model
{
    protected $table = 'epw_costs';

    protected $primaryKey = 'epw_id';

    protected $fillable = [
        'epw_id', 'claim_id','staff_name','yearly_salary','per_R_D'
    ];
}
