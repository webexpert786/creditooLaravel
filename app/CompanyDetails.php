<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CompanyDetails extends Model
{
    protected $table = 'client_company';

    protected $primaryKey = 'company_id';

    protected $fillable = [
        'company_id', 'added_by', 'company_name','email','phone','company_reg','directory_name','incorporated_date'
    ];
}
