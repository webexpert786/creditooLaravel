<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CompanyClaims extends Model
{
    protected $table = 'company_claims';

    protected $primaryKey = 'cid';

    protected $fillable = [
        	'cid','claim_id', 'number_of_directors','number_of_staff','year_end_date','profit_loss','turnover','gross_balance_sheet','grants','property_ownership','part_of_group','name_of_group','percentage_own','about_us'
    ];

    public function claims()

    {

        return $this->belongsTo('App\Claims');

    }
}
