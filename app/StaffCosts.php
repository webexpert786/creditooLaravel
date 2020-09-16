<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class StaffCosts extends Model
{
    protected $table = 'staff_costs';

    protected $primaryKey = 'costs_id';

    protected $fillable = [
        'costs_id', 'claim_id','staff_name','yearly_salary','per_R_D'
    ];
}
